import 'package:flutter/material.dart';
import '../utils/responsive_ext.dart';
import '../theme/app_theme.dart';

class Tag extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const Tag({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  factory Tag.orange(String text) => Tag(
        text: text,
        backgroundColor: AppColors.orangeLight,
        textColor: AppColors.orangeDark,
      );

  factory Tag.blue(String text) => Tag(
        text: text,
        backgroundColor: AppColors.indigoLight,
        textColor: AppColors.indigo,
      );

  factory Tag.green(String text) => Tag(
        text: text,
        backgroundColor: const Color(0xFFE6F4EC),
        textColor: AppColors.green,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onTap;
  final IconData? icon;

  const CustomChip({
    super.key,
    required this.text,
    this.isActive = false,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(3.r),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.orangeLight : AppColors.cream,
          border: Border.all(
            color: isActive ? AppColors.orange : AppColors.border,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 14.r,
                color: isActive ? AppColors.orangeDark : AppColors.textDark,
              ),
              SizedBox(width: 5.w),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                color: isActive ? AppColors.orangeDark : AppColors.textDark,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
