import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_service.g.dart';

@Riverpod(keepAlive: true)
TranslationService translationService(Ref ref) {
  final service = TranslationService();
  ref.onDispose(() => service.dispose());
  return service;
}

class TranslationService {
  final _modelManager = OnDeviceTranslatorModelManager();
  OnDeviceTranslator? _translator;
  TranslateLanguage _currentTargetLanguage = TranslateLanguage.english;
  final Map<String, String> _cache = {};

  /// Downloads and sets up the target language.
  /// [onProgress] receives (currentStep, totalSteps, statusMessage)
  Future<void> setTargetLanguage(
    TranslateLanguage lang, {
    void Function(int step, int total, String message)? onProgress,
  }) async {
    if (_currentTargetLanguage == lang && _translator != null) return;

    _currentTargetLanguage = lang;
    _cache.clear();

    // Close existing translator
    if (_translator != null) {
      onProgress?.call(0, 4, 'Closing previous translator...');
      await _translator!.close();
      _translator = null;
    }

    if (lang == TranslateLanguage.english) {
      onProgress?.call(4, 4, 'Done');
      return;
    }

    try {
      // Step 1: Check if target language model exists
      onProgress?.call(1, 4, 'Checking ${lang.name} model...');
      final isDownloaded = await _modelManager
          .isModelDownloaded(lang.bcpCode)
          .timeout(const Duration(seconds: 15), onTimeout: () => false);

      // Step 2: Download target language model if needed
      if (!isDownloaded) {
        onProgress?.call(2, 4, 'Downloading ${lang.name} model (~30 MB)...');
        final success = await _modelManager.downloadModel(lang.bcpCode,
            isWifiRequired: false);
        if (!success) {
          throw Exception(
              'Failed to download ${lang.name} model. Check your internet connection.');
        }
      }
      onProgress?.call(2, 4, '${lang.name} model ready ✓');

      // Step 3: Ensure English model is available
      onProgress?.call(3, 4, 'Verifying English model...');
      final isEnglishDownloaded = await _modelManager
          .isModelDownloaded(TranslateLanguage.english.bcpCode)
          .timeout(const Duration(seconds: 15), onTimeout: () => false);

      if (!isEnglishDownloaded) {
        onProgress?.call(3, 4, 'Downloading English model...');
        await _modelManager.downloadModel(TranslateLanguage.english.bcpCode,
            isWifiRequired: false);
      }
      onProgress?.call(3, 4, 'English model ready ✓');

      // Step 4: Initialize translator
      onProgress?.call(4, 4, 'Initializing translator...');
    } catch (e) {
      _currentTargetLanguage = TranslateLanguage.english;
      rethrow;
    }

    _translator = OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.english, targetLanguage: lang);
  }

  String? getCachedTranslation(String text) {
    if (_currentTargetLanguage == TranslateLanguage.english) return text;
    return _cache[text];
  }

  Future<String> translate(String text) async {
    if (_currentTargetLanguage == TranslateLanguage.english ||
        _translator == null) {
      return text;
    }

    if (_cache.containsKey(text)) {
      return _cache[text]!;
    }

    try {
      final translated = await _translator!.translateText(text);
      _cache[text] = translated;
      return translated;
    } catch (e) {
      return text;
    }
  }

  void dispose() {
    _translator?.close();
  }
}
