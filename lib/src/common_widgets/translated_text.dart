import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

import '../features/translation/application/translation_provider.dart';
import '../features/translation/application/translation_service.dart';

class TranslatedText extends HookConsumerWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const TranslatedText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(targetLanguageProvider);
    final service = ref.watch(translationServiceProvider);
    
    final translatedText = useState<String>(text);

    useEffect(() {
      final cached = service.getCachedTranslation(text);
      if (cached != null) {
        translatedText.value = cached;
      } else if (lang == TranslateLanguage.english) {
        translatedText.value = text;
      } else {
        translatedText.value = text; // Fallback to original while translating
        service.translate(text).then((translated) {
          if (context.mounted) {
            translatedText.value = translated;
          }
        });
      }
      return null;
    }, [text, lang]);

    return Text(
      translatedText.value,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
