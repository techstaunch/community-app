import 'package:flutter/material.dart';
import '../utils/responsive_ext.dart';
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
      padding: EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w, bottom: paddingBottom.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (leading != null) ...[
                leading!,
                SizedBox(height: 12.h),
              ],
              Text(
                title,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 26.sp,
                    ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.sp,
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
