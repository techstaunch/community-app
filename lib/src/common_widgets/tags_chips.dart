import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
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

  const CustomChip({
    super.key,
    required this.text,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: isActive ? AppColors.orangeLight : AppColors.cream,
          border: Border.all(
            color: isActive ? AppColors.orange : AppColors.border,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? AppColors.orangeDark : AppColors.textDark,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
