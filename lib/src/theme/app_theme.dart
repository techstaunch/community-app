import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color orange = Color(0xFFE8690A);
  static const Color orangeLight = Color(0xFFFEF0E6);
  static const Color orangeDark = Color(0xFFC94E00);
  static const Color indigo = Color(0xFF3D3D8F);
  static const Color indigoLight = Color(0xFFEEEDFE);
  static const Color cream = Color(0xFFFDF8F2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gold = Color(0xFFF5A623);
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textMid = Color(0xFF555555);
  static const Color textMuted = Color(0xFF999999);
  static const Color border = Color(0xFFE8E0D8);
  static const Color green = Color(0xFF2D7D46);
  static const Color red = Color(0xFFC0392B);
}

class AppTheme {
  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.dmSansTextTheme();
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.cream,
      primaryColor: AppColors.orange,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.orange,
        primary: AppColors.orange,
        secondary: AppColors.indigo,
        surface: AppColors.white,
        error: AppColors.red,
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: GoogleFonts.playfairDisplay(color: AppColors.textDark, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.playfairDisplay(color: AppColors.textDark, fontWeight: FontWeight.w600),
        displaySmall: GoogleFonts.playfairDisplay(color: AppColors.textDark, fontWeight: FontWeight.w500),
        titleLarge: GoogleFonts.playfairDisplay(color: AppColors.textDark, fontWeight: FontWeight.w600),
        titleMedium: GoogleFonts.playfairDisplay(color: AppColors.textDark, fontWeight: FontWeight.w600),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: AppColors.textDark),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: AppColors.textMid),
        labelLarge: baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          foregroundColor: AppColors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          padding: const EdgeInsets.all(14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.orange,
          side: const BorderSide(color: AppColors.orange, width: 1.5),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          padding: const EdgeInsets.all(13),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.orange, width: 1.5),
        ),
        labelStyle: const TextStyle(color: AppColors.indigo, fontSize: 12, fontWeight: FontWeight.w600),
        hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.cream,
        headerBackgroundColor: AppColors.indigo,
        headerForegroundColor: AppColors.white,
        dividerColor: AppColors.border,
        todayForegroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.white : AppColors.orange),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.white : AppColors.textDark),
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.orange : Colors.transparent),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        cancelButtonStyle: TextButton.styleFrom(foregroundColor: AppColors.textMuted),
        confirmButtonStyle: TextButton.styleFrom(foregroundColor: AppColors.orange, textStyle: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
