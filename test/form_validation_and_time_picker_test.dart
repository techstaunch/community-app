import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:community_connect/src/common_widgets/custom_inputs.dart';

void main() {
  group('CustomTimePickerField tests', () {
    test('parses 12-hour format with AM/PM correctly', () {
      final t1 = CustomTimePickerField.parseTimeString('10:30 AM');
      expect(t1, isNotNull);
      expect(t1!.hour, equals(10));
      expect(t1.minute, equals(30));

      final t2 = CustomTimePickerField.parseTimeString('02:15 PM');
      expect(t2, isNotNull);
      expect(t2!.hour, equals(14));
      expect(t2.minute, equals(15));

      final t3 = CustomTimePickerField.parseTimeString('12:00 AM');
      expect(t3, isNotNull);
      expect(t3!.hour, equals(0));
      expect(t3.minute, equals(0));

      final t4 = CustomTimePickerField.parseTimeString('12:45 PM');
      expect(t4, isNotNull);
      expect(t4!.hour, equals(12));
      expect(t4.minute, equals(45));
    });

    test('parses 24-hour format correctly', () {
      final t = CustomTimePickerField.parseTimeString('14:30');
      expect(t, isNotNull);
      expect(t!.hour, equals(14));
      expect(t.minute, equals(30));
    });

    test('parses SQL TIME format with seconds (HH:mm:ss) correctly', () {
      final t1 = CustomTimePickerField.parseTimeString('14:30:00');
      expect(t1, isNotNull);
      expect(t1!.hour, equals(14));
      expect(t1.minute, equals(30));

      final t2 = CustomTimePickerField.parseTimeString('09:15:45 AM');
      expect(t2, isNotNull);
      expect(t2!.hour, equals(9));
      expect(t2.minute, equals(15));
    });

    test('returns null for arbitrary gibberish like drrgg6vfhh', () {
      expect(CustomTimePickerField.parseTimeString('drrgg6vfhh'), isNull);
      expect(CustomTimePickerField.parseTimeString(''), isNull);
      expect(CustomTimePickerField.parseTimeString(null), isNull);
      expect(CustomTimePickerField.parseTimeString('99:99'), isNull);
      expect(CustomTimePickerField.parseTimeString('12:60 PM'), isNull);
    });

    test('formats TimeOfDay correctly into 12-hour AM/PM string', () {
      expect(
        CustomTimePickerField.formatTimeOfDay(const TimeOfDay(hour: 10, minute: 30)),
        equals('10:30 AM'),
      );
      expect(
        CustomTimePickerField.formatTimeOfDay(const TimeOfDay(hour: 14, minute: 5)),
        equals('2:05 PM'),
      );
      expect(
        CustomTimePickerField.formatTimeOfDay(const TimeOfDay(hour: 0, minute: 0)),
        equals('12:00 AM'),
      );
      expect(
        CustomTimePickerField.formatTimeOfDay(const TimeOfDay(hour: 12, minute: 0)),
        equals('12:00 PM'),
      );
    });
  });

  group('Form validation rules tests', () {
    test('validates 10-digit mobile number starting with 6-9', () {
      final phoneRegex = RegExp(r'^[6-9]\d{9}$');

      expect(phoneRegex.hasMatch('9876543210'), isTrue);
      expect(phoneRegex.hasMatch('8876543210'), isTrue);
      expect(phoneRegex.hasMatch('7876543210'), isTrue);
      expect(phoneRegex.hasMatch('6876543210'), isTrue);

      // Invalid: starts with 1-5
      expect(phoneRegex.hasMatch('5876543210'), isFalse);
      expect(phoneRegex.hasMatch('1234567890'), isFalse);

      // Invalid lengths
      expect(phoneRegex.hasMatch('98765'), isFalse);
      expect(phoneRegex.hasMatch('98765432101'), isFalse);

      // Invalid characters
      expect(phoneRegex.hasMatch('98765abcde'), isFalse);
    });

    test('validates name format containing letters, spaces, hyphens, and apostrophes', () {
      final nameRegex = RegExp(r"^[\p{L}\p{M}\s.'-]+$", unicode: true);

      expect(nameRegex.hasMatch('Ravi Agarwal'), isTrue);
      expect(nameRegex.hasMatch("O'Connor"), isTrue);
      expect(nameRegex.hasMatch('Mary-Jane'), isTrue);
      expect(nameRegex.hasMatch('डॉ. शर्मा'), isTrue);

      // Invalid: digits or symbols
      expect(nameRegex.hasMatch('Ravi123'), isFalse);
      expect(nameRegex.hasMatch('John @Doe'), isFalse);
      expect(nameRegex.hasMatch(''), isFalse);
    });

    test('validates email format', () {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

      expect(emailRegex.hasMatch('test@example.com'), isTrue);
      expect(emailRegex.hasMatch('user.name@domain.co.in'), isTrue);
      expect(emailRegex.hasMatch('not-an-email'), isFalse);
      expect(emailRegex.hasMatch('test@'), isFalse);
      expect(emailRegex.hasMatch('@example.com'), isFalse);
    });
  });
}
