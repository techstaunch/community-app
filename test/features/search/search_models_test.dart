import 'package:flutter_test/flutter_test.dart';
import 'package:community_connect/src/features/search/data/search_models.dart';

void main() {
  group('SearchResult.fromJson Tests', () {
    test('Correctly parses member from search API payload without explicit status fields', () {
      final json = {
        'id': '05c412bb-f261-43db-99a4-5cc21b505f8e',
        'mobileNumber': '917859821703',
        'email': 'meet.panchal@techstaunch.in',
        'isVerified': true,
        'isActive': true,
        'createdAt': '2026-08-25T12:38:21.898Z',
        'updatedAt': '2026-09-15T12:30:25.841Z',
        'lastProfileReminderAt': '2026-09-10T00:00:01.829Z',
        'profile': {
          'id': 'fbc5d0bc-b3a3-47f1-b5ef-ef35a12ae740',
          'userId': '05c412bb-f261-43db-99a4-5cc21b505f8e',
          'title': null,
          'fullName': 'tom cat',
          'dob': '2026-08-04T00:00:00.000Z',
          'gender': 'Male',
          'profilePhotoUrl': 'https://example.com/photo.webp',
          'city': 'surat',
          'state': null,
          'nativeVillage': 'Moscow',
          'surname': 'cat',
        },
      };

      final result = SearchResult.fromJson(json);

      expect(result.id, equals('05c412bb-f261-43db-99a4-5cc21b505f8e'));
      expect(result.fullName, equals('tom cat'));
      expect(result.city, equals('surat'));
      expect(result.isApproved, isTrue);
      expect(result.membershipStatus, equals('Approved'));
      expect(result.isVerified, isTrue);
    });

    test('Correctly parses member with isVerified: false and retains active/approved state', () {
      final json = {
        'id': 'unverified-user-123',
        'mobileNumber': '919876543210',
        'email': 'unverified@example.com',
        'isVerified': false,
        'isActive': true,
        'profile': {
          'id': 'profile-123',
          'fullName': 'Jerry Mouse',
          'city': 'mumbai',
        },
      };

      final result = SearchResult.fromJson(json);

      expect(result.id, equals('unverified-user-123'));
      expect(result.fullName, equals('Jerry Mouse'));
      expect(result.city, equals('mumbai'));
      expect(result.isVerified, isFalse);
      expect(result.isApproved, isTrue);
      expect(result.membershipStatus, equals('Approved'));
    });

    test('Correctly extracts businessName and falls back when job has empty strings', () {
      final json = {
        'id': 'd208b569-17cb-4caf-bc11-81daa4431e87',
        'mobileNumber': '917859821704',
        'isVerified': false,
        'isActive': true,
        'profile': {
          'fullName': 'Chunilal Rathoree',
          'city': '',
        },
        'job': {
          'companyName': '',
          'designation': '',
          'city': 'Surat',
        },
        'business': {
          'businessName': 'Google 1',
          'category': 'Information Technology (IT) & Software',
          'city': 'Bangalore Rural',
          'role': 'ceo',
        },
      };

      final result = SearchResult.fromJson(json);

      expect(result.id, equals('d208b569-17cb-4caf-bc11-81daa4431e87'));
      expect(result.fullName, equals('Chunilal Rathoree'));
      expect(result.businessName, equals('Google 1'));
      expect(result.companyName, equals('Google 1'));
      expect(result.city, equals('Bangalore Rural'));
      expect(result.designation, equals('ceo'));
    });

    test('Respects explicit Rejected / Pending status if present', () {
      final json = {
        'id': '123',
        'status': 'Pending',
        'profile': {
          'fullName': 'Pending User',
        },
      };

      final result = SearchResult.fromJson(json);

      expect(result.isApproved, isFalse);
      expect(result.membershipStatus, equals('Pending'));
    });
  });
}
