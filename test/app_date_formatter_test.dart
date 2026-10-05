import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:community_connect/src/utils/app_date_formatter.dart';

void main() {
  group('AppDateFormatter.tryParseDate', () {
    test('parses DateTime instance directly', () {
      final dt = DateTime(2000, 8, 15);
      expect(AppDateFormatter.tryParseDate(dt), equals(dt));
    });

    test('parses ISO 8601 strings', () {
      final dt1 = AppDateFormatter.tryParseDate('2000-08-15');
      expect(dt1, isNotNull);
      expect(dt1!.year, equals(2000));
      expect(dt1.month, equals(8));
      expect(dt1.day, equals(15));

      final dt2 = AppDateFormatter.tryParseDate('2026-09-18T10:30:00.000Z');
      expect(dt2, isNotNull);
      expect(dt2!.year, equals(2026));
      expect(dt2.month, equals(9));
      expect(dt2.day, equals(18));
    });

    test('parses DD/MM/YYYY and DD-MM-YYYY strings', () {
      final dt1 = AppDateFormatter.tryParseDate('15/08/2000');
      expect(dt1, isNotNull);
      expect(dt1!.year, equals(2000));
      expect(dt1.month, equals(8));
      expect(dt1.day, equals(15));

      final dt2 = AppDateFormatter.tryParseDate('15-08-2000');
      expect(dt2, isNotNull);
      expect(dt2!.year, equals(2000));
      expect(dt2.month, equals(8));
      expect(dt2.day, equals(15));
    });

    test('returns null for null, empty or invalid strings', () {
      expect(AppDateFormatter.tryParseDate(null), isNull);
      expect(AppDateFormatter.tryParseDate(''), isNull);
      expect(AppDateFormatter.tryParseDate('   '), isNull);
      expect(AppDateFormatter.tryParseDate('invalid-date'), isNull);
      expect(AppDateFormatter.tryParseDate('99/99/9999'), isNull);
    });
  });

  group('AppDateFormatter.formatDate', () {
    test('formats valid date string to DD MMM YYYY', () {
      expect(AppDateFormatter.formatDate('2000-08-15'), equals('15 Aug 2000'));
      expect(AppDateFormatter.formatDate('1995-04-02'), equals('02 Apr 1995'));
      expect(AppDateFormatter.formatDate('15/08/2000'), equals('15 Aug 2000'));
    });

    test('formats DateTime instance to DD MMM YYYY', () {
      expect(AppDateFormatter.formatDate(DateTime(2023, 1, 5)), equals('05 Jan 2023'));
    });

    test('returns fallback for invalid or null inputs', () {
      expect(AppDateFormatter.formatDate(null), equals('Not set'));
      expect(AppDateFormatter.formatDate('', fallback: 'Setup required'), equals('Setup required'));
      expect(AppDateFormatter.formatDate('not-a-date', fallback: 'None'), equals('None'));
    });
  });

  group('AppDateFormatter.formatTime', () {
    test('formats SQL TIME strings with seconds (HH:mm:ss)', () {
      expect(AppDateFormatter.formatTime('14:30:00'), equals('2:30 PM'));
      expect(AppDateFormatter.formatTime('09:15:00'), equals('9:15 AM'));
      expect(AppDateFormatter.formatTime('00:00:00'), equals('12:00 AM'));
      expect(AppDateFormatter.formatTime('12:00:00'), equals('12:00 PM'));
    });

    test('formats 24-hour time strings (HH:mm)', () {
      expect(AppDateFormatter.formatTime('14:30'), equals('2:30 PM'));
      expect(AppDateFormatter.formatTime('09:05'), equals('9:05 AM'));
    });

    test('formats 12-hour AM/PM time strings', () {
      expect(AppDateFormatter.formatTime('02:30 PM'), equals('2:30 PM'));
      expect(AppDateFormatter.formatTime('10:15 AM'), equals('10:15 AM'));
    });

    test('formats TimeOfDay instance', () {
      expect(AppDateFormatter.formatTime(const TimeOfDay(hour: 14, minute: 30)), equals('2:30 PM'));
      expect(AppDateFormatter.formatTime(const TimeOfDay(hour: 0, minute: 0)), equals('12:00 AM'));
    });

    test('formats ISO timestamp strings with time', () {
      final iso = DateTime(2026, 9, 18, 14, 30).toIso8601String();
      expect(AppDateFormatter.formatTime(iso), equals('2:30 PM'));
    });

    test('returns fallback for null or empty input', () {
      expect(AppDateFormatter.formatTime(null), equals('Not set'));
      expect(AppDateFormatter.formatTime(''), equals('Not set'));
    });
  });

  group('AppDateFormatter.toApiDate', () {
    test('formats DateTime to YYYY-MM-DD', () {
      expect(AppDateFormatter.toApiDate(DateTime(2000, 8, 15)), equals('2000-08-15'));
      expect(AppDateFormatter.toApiDate(DateTime(1995, 4, 2)), equals('1995-04-02'));
    });
  });

  group('AppDateFormatter.formatRelativeTime', () {
    test('formats recent timestamp as Just now', () {
      final now = DateTime.now();
      expect(AppDateFormatter.formatRelativeTime(now), equals('Just now'));
    });

    test('formats minutes ago', () {
      final tenMinutesAgo = DateTime.now().subtract(const Duration(minutes: 10));
      expect(AppDateFormatter.formatRelativeTime(tenMinutesAgo), equals('10m ago'));
    });

    test('formats hours ago', () {
      final twoHoursAgo = DateTime.now().subtract(const Duration(hours: 2));
      expect(AppDateFormatter.formatRelativeTime(twoHoursAgo), equals('2h ago'));
    });

    test('formats days ago', () {
      final threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
      expect(AppDateFormatter.formatRelativeTime(threeDaysAgo), equals('3d ago'));
    });
  });
}
