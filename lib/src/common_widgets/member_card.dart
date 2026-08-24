import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MemberCard extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final Widget subtitle;
  final Widget? tag;
  final VoidCallback? onTap;

  const MemberCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.tag,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            DefaultTextStyle(
              style: const TextStyle(fontSize: 36),
              child: icon,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                    child: title,
                  ),
                  const SizedBox(height: 2),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                    child: subtitle,
                  ),
                  if (tag != null) ...[
                    const SizedBox(height: 4),
                    tag!,
                  ]
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              '›',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
