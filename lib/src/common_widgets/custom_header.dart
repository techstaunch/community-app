import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OrangeHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? leading;
  final double paddingBottom;

  const OrangeHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.leading,
    this.paddingBottom = 36.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.orange, AppColors.orangeDark],
        ),
      ),
      padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: paddingBottom),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(height: 12),
              ],
              Text(
                title,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 26,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: -paddingBottom - 18,
            left: -20,
            right: -20,
            child: Container(
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.cream,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
