import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../utils/responsive_ext.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class LinkifiedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final int? maxLines;
  final TextOverflow? overflow;

  const LinkifiedText({
    super.key,
    required this.text,
    this.style,
    this.linkStyle,
    this.maxLines,
    this.overflow,
  });

  static final RegExp _urlRegex = RegExp(
    r'(https?://[^\s]+)',
    caseSensitive: false,
  );

  Future<void> _openUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final effectiveOverflow = overflow ?? (maxLines != null ? TextOverflow.ellipsis : null);
    final defaultStyle = style ?? TextStyle(fontSize: 13.sp, color: AppColors.textMid);
    final activeLinkStyle = linkStyle ??
        TextStyle(
          fontSize: 13.sp,
          color: AppColors.orange,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        );

    final matches = _urlRegex.allMatches(text);
    if (matches.isEmpty) {
      return Text(
        text,
        style: defaultStyle,
        maxLines: maxLines,
        overflow: effectiveOverflow,
      );
    }

    final spans = <TextSpan>[];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: defaultStyle,
        ));
      }

      final url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: activeLinkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => _openUrl(url),
        ),
      );

      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: defaultStyle,
      ));
    }

    return Text.rich(
      TextSpan(children: spans),
      maxLines: maxLines,
      overflow: effectiveOverflow,
    );
  }
}
