import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const CustomInputField({
    super.key,
    required this.label,
    this.hintText,
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.indigo,
            letterSpacing: 0.04,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textDark,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

class CustomDatePickerField extends StatelessWidget {
  final String label;
  final String? hintText;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Widget? prefixIcon;

  const CustomDatePickerField({
    super.key,
    required this.label,
    required this.onDateSelected,
    this.hintText,
    this.selectedDate,
    this.firstDate,
    this.lastDate,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';
    if (selectedDate != null) {
      formattedDate = "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.indigo,
            letterSpacing: 0.04,
          ),
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: () async {
            final now = DateTime.now();
            final date = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? now,
              firstDate: firstDate ?? DateTime(1900),
              lastDate: lastDate ?? DateTime(2100),
              helpText: 'SELECT ${label.toUpperCase()}',
            );
            if (date != null) {
              onDateSelected(date);
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: IgnorePointer(
            child: TextFormField(
              controller: TextEditingController(text: formattedDate),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textDark,
              ),
              decoration: InputDecoration(
                hintText: hintText ?? 'YYYY-MM-DD',
                prefixIcon: prefixIcon,
                suffixIcon: const Icon(Icons.calendar_today, color: AppColors.orange, size: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
