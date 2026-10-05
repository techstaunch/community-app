import 'package:flutter/material.dart';

/// Centralized utility for consistent date and time formatting across Community Connect.
class AppDateFormatter {
  AppDateFormatter._();

  static const List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  /// Safely parses an input (DateTime or String in ISO 8601, YYYY-MM-DD, DD/MM/YYYY, or DD-MM-YYYY)
  /// without throwing exceptions. Returns null if invalid or empty.
  static DateTime? tryParseDate(dynamic input) {
    if (input == null) return null;
    if (input is DateTime) return input;

    final str = input.toString().trim();
    if (str.isEmpty) return null;

    try {
      final parsed = DateTime.tryParse(str);
      if (parsed != null) return parsed;

      // Check DD/MM/YYYY or DD-MM-YYYY
      final dmyRegex = RegExp(r'^(\d{1,2})[-/](\d{1,2})[-/](\d{4})$');
      final dmyMatch = dmyRegex.firstMatch(str);
      if (dmyMatch != null) {
        final day = int.parse(dmyMatch.group(1)!);
        final month = int.parse(dmyMatch.group(2)!);
        final year = int.parse(dmyMatch.group(3)!);
        if (month >= 1 && month <= 12 && day >= 1 && day <= 31) {
          return DateTime(year, month, day);
        }
      }

      // Check YYYY/MM/DD
      final ymdRegex = RegExp(r'^(\d{4})[-/](\d{1,2})[-/](\d{1,2})$');
      final ymdMatch = ymdRegex.firstMatch(str);
      if (ymdMatch != null) {
        final year = int.parse(ymdMatch.group(1)!);
        final month = int.parse(ymdMatch.group(2)!);
        final day = int.parse(ymdMatch.group(3)!);
        if (month >= 1 && month <= 12 && day >= 1 && day <= 31) {
          return DateTime(year, month, day);
        }
      }
    } catch (_) {}

    return null;
  }

  /// Formats a date string or DateTime into standard human-friendly format: `15 Aug 1995`.
  /// Returns [fallback] if input is null or unparseable.
  static String formatDate(dynamic input, {String fallback = 'Not set'}) {
    final dt = tryParseDate(input);
    if (dt == null) return fallback;
    return '${dt.day.toString().padLeft(2, '0')} ${monthNames[dt.month - 1]} ${dt.year}';
  }

  /// Formats a DateTime directly into `15 Aug 1995`. Returns [fallback] if null.
  static String formatDateOnly(DateTime? date, {String fallback = ''}) {
    if (date == null) return fallback;
    return '${date.day.toString().padLeft(2, '0')} ${monthNames[date.month - 1]} ${date.year}';
  }

  /// Formats time input into 12-hour AM/PM format (e.g., `10:30 AM`, `2:30 PM`).
  /// Handles `TimeOfDay`, `DateTime`, SQL TIME strings (`14:30:00`), 24-hr (`14:30`),
  /// 12-hr (`02:30 PM`), and ISO timestamps.
  static String formatTime(dynamic input, {String fallback = 'Not set'}) {
    if (input == null) return fallback;

    if (input is TimeOfDay) {
      final hour = input.hourOfPeriod == 0 ? 12 : input.hourOfPeriod;
      final minute = input.minute.toString().padLeft(2, '0');
      final period = input.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hour:$minute $period';
    }

    if (input is DateTime) {
      final local = input.toLocal();
      final ampm = local.hour >= 12 ? 'PM' : 'AM';
      final hour = local.hour == 0 ? 12 : (local.hour > 12 ? local.hour - 12 : local.hour);
      final min = local.minute.toString().padLeft(2, '0');
      return '$hour:$min $ampm';
    }

    final str = input.toString().trim();
    if (str.isEmpty) return fallback;

    // Check if ISO 8601 string
    if (str.contains('T') || (str.contains('-') && str.contains(':'))) {
      final dt = DateTime.tryParse(str);
      if (dt != null) {
        return formatTime(dt);
      }
    }

    // Match 24-hour or 12-hour time strings with optional seconds
    final regex = RegExp(r'^(\d{1,2}):(\d{2})(?::\d{2})?\s*(AM|PM|am|pm)?$', caseSensitive: false);
    final match = regex.firstMatch(str);
    if (match != null) {
      int hour = int.parse(match.group(1)!);
      final minute = int.parse(match.group(2)!);
      final period = match.group(3)?.toUpperCase();

      if (period == 'PM' && hour < 12) hour += 12;
      if (period == 'AM' && hour == 12) hour = 0;

      if (hour >= 0 && hour < 24 && minute >= 0 && minute < 60) {
        final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
        final displayMin = minute.toString().padLeft(2, '0');
        final displayPeriod = hour >= 12 ? 'PM' : 'AM';
        return '$displayHour:$displayMin $displayPeriod';
      }
    }

    return str.isNotEmpty ? str : fallback;
  }

  /// Formats date and time: `15 Aug 2026 • 2:30 PM`.
  static String formatDateTime(dynamic input, {String fallback = 'Not set'}) {
    final dt = tryParseDate(input);
    if (dt == null) return fallback;
    final local = dt.toLocal();
    final datePart = '${monthNames[local.month - 1]} ${local.day}, ${local.year}';
    final timePart = formatTime(local);
    return '$datePart • $timePart';
  }

  /// Formats date for compact views (announcements, compact lists):
  /// e.g. `Aug 15` if same year, or `Aug 15, 2026` if different year.
  static String formatShortDate(dynamic input, {String fallback = ''}) {
    final dt = tryParseDate(input);
    if (dt == null) return fallback;
    final local = dt.toLocal();
    final now = DateTime.now();
    if (local.year == now.year) {
      return '${monthNames[local.month - 1]} ${local.day}';
    }
    return '${monthNames[local.month - 1]} ${local.day}, ${local.year}';
  }

  /// Formats relative time for notifications and activity feeds:
  /// `Just now`, `5m ago`, `2h ago`, `3d ago`, or date string.
  static String formatRelativeTime(dynamic input, {String fallback = 'Recently'}) {
    final dt = tryParseDate(input);
    if (dt == null) return fallback;
    final local = dt.toLocal();
    final now = DateTime.now();
    final diff = now.difference(local);

    if (diff.isNegative || diff.inMinutes < 1) {
      return 'Just now';
    }
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    }
    if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    }
    if (local.year == now.year) {
      return '${monthNames[local.month - 1]} ${local.day}';
    }
    return '${monthNames[local.month - 1]} ${local.day}, ${local.year}';
  }

  /// Converts a DateTime into API date format: `YYYY-MM-DD`.
  static String toApiDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
