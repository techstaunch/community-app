import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'translation_service.dart';

part 'translation_provider.g.dart';

@Riverpod(keepAlive: true)
class TargetLanguage extends _$TargetLanguage {
  @override
  TranslateLanguage build() {
    return TranslateLanguage.english;
  }

  Future<void> setLanguage(
    TranslateLanguage lang, {
    void Function(int step, int total, String message)? onProgress,
  }) async {
    await ref
        .read(translationServiceProvider)
        .setTargetLanguage(lang, onProgress: onProgress);
    state = lang;
  }
}
