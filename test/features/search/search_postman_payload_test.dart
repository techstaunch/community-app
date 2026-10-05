import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/community/data/community_provider.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import 'package:community_connect/src/features/search/data/search_repository.dart';
import 'package:community_connect/src/features/search/presentation/search_screen.dart';

void main() {
  group('Exact Postman Response Integration Test', () {
    final postmanResponse = {
      "success": true,
      "message": "Members matching name search criteria retrieved",
      "data": [
        {
          "id": "05c412bb-f261-43db-99a4-5cc21b505f8e",
          "mobileNumber": "917859821703",
          "email": "meet.panchal@techstaunch.in",
          "isVerified": true,
          "isActive": true,
          "createdAt": "2026-08-25T12:38:21.898Z",
          "updatedAt": "2026-09-15T12:30:25.841Z",
          "lastProfileReminderAt": "2026-09-10T00:00:01.829Z",
          "profile": {
            "id": "fbc5d0bc-b3a3-47f1-b5ef-ef35a12ae740",
            "userId": "05c412bb-f261-43db-99a4-5cc21b505f8e",
            "title": null,
            "fullName": "tom cat",
            "dob": "2026-08-04T00:00:00.000Z",
            "gender": "Male",
            "profilePhotoUrl": "https://qnsmbayplbosfgmmkgco.supabase.co/storage/v1/object/public/community-data/uploads/1787737880455-22.webp",
            "city": "surat",
            "state": null,
            "nativeVillage": "Moscow",
            "surname": "cat",
            "gotra": null,
            "subCaste": null,
            "timeOfBirth": null,
            "disability": "",
            "manglik": "Don't Know",
            "maternalSurname": null,
            "maternalGotra": null,
            "address": "surat",
            "bio": "I am good cat.",
            "bloodGroup": "O+",
            "height": "6 ft 3 in",
            "education": "B.mouse",
            "instagram": "",
            "facebook": "",
            "linkedin": "",
            "twitter": "",
            "createdAt": "2026-08-25T12:56:14.052Z",
            "updatedAt": "2026-09-15T12:30:26.061Z"
          },
          "job": null,
          "business": null,
          "privacySettings": {
            "id": "714e6921-2679-4da1-aa6f-f36b18449406",
            "userId": "05c412bb-f261-43db-99a4-5cc21b505f8e",
            "showMobileNumber": false,
            "showEmail": false,
            "showGotra": true,
            "showFamilyInfo": true,
            "showMaternalInfo": true,
            "showBusinessInfo": true,
            "showProfessionalInfo": true
          },
          "ownedFamilyMembers": [],
          "linkedFamilyNodes": [],
          "familyTree": null
        }
      ]
    };

    test('SearchRepository parses Postman payload and retains tom cat', () async {
      final dio = Dio();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.resolve(
              Response(
                requestOptions: options,
                data: postmanResponse,
                statusCode: 200,
              ),
            );
          },
        ),
      );

      final repo = SearchRepository(dio);
      final results = await repo.searchMembers(fullName: 'tom cat');

      expect(results.length, equals(1));
      expect(results.first.fullName, equals('tom cat'));
      expect(results.first.city, equals('surat'));
      expect(results.first.isApproved, isTrue);
      expect(results.first.membershipStatus, equals('Approved'));
      expect(results.first.isVerified, isTrue);
    });

    test('SearchRepository retains users when isVerified is false', () async {
      final unverifiedResponse = {
        "success": true,
        "message": "Members matching name search criteria retrieved",
        "data": [
          {
            "id": "unverified-user-1",
            "mobileNumber": "917859821999",
            "isVerified": false,
            "isActive": true,
            "profile": {
              "fullName": "Jerry Mouse",
              "city": "mumbai",
            },
          }
        ]
      };

      final dio = Dio();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.resolve(
              Response(
                requestOptions: options,
                data: unverifiedResponse,
                statusCode: 200,
              ),
            );
          },
        ),
      );

      final repo = SearchRepository(dio);
      final results = await repo.searchMembers(fullName: 'Jerry');

      expect(results.length, equals(1));
      expect(results.first.fullName, equals('Jerry Mouse'));
      expect(results.first.isVerified, isFalse);
    });

    testWidgets('SearchScreen renders tom cat member card when returned from search', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final dio = Dio();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.resolve(
              Response(
                requestOptions: options,
                data: postmanResponse,
                statusCode: 200,
              ),
            );
          },
        ),
      );

      final repo = SearchRepository(dio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            searchRepositoryProvider.overrideWithValue(repo),
            currentUserMembershipStatusProvider.overrideWith((ref) async => 'Approved'),
          ],
          child: const MaterialApp(
            home: SearchScreen(initialTab: 0),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Initially shows Search Businesses empty state without showing random members
      expect(find.text('Search Businesses'), findsOneWidget);

      // Now enter search query 'tom cat'
      await tester.enterText(find.byType(TextField), 'tom cat');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Expect 'tom cat' member card to be rendered on screen with verified badge
      expect(find.widgetWithText(TranslatedText, 'tom cat'), findsOneWidget);
      expect(find.widgetWithText(TranslatedText, '✓ Verified'), findsOneWidget);
      expect(find.text('surat'), findsOneWidget);
      expect(find.text('Business'), findsNWidgets(2));
      expect(find.text('Search Businesses'), findsNothing);
    });

    testWidgets('SearchScreen renders unverified member without verified badge', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final unverifiedResponse = {
        "success": true,
        "message": "Members matching name search criteria retrieved",
        "data": [
          {
            "id": "unverified-user-1",
            "mobileNumber": "917859821999",
            "isVerified": false,
            "isActive": true,
            "profile": {
              "fullName": "Jerry Mouse",
              "city": "mumbai",
            },
          }
        ]
      };

      final dio = Dio();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.resolve(
              Response(
                requestOptions: options,
                data: unverifiedResponse,
                statusCode: 200,
              ),
            );
          },
        ),
      );

      final repo = SearchRepository(dio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            searchRepositoryProvider.overrideWithValue(repo),
            currentUserMembershipStatusProvider.overrideWith((ref) async => 'Approved'),
          ],
          child: const MaterialApp(
            home: SearchScreen(initialTab: 0),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Jerry');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      // Expect 'Jerry Mouse' to be rendered on screen but NOT have '✓ Verified'
      expect(find.widgetWithText(TranslatedText, 'Jerry Mouse'), findsOneWidget);
      expect(find.text('mumbai'), findsOneWidget);
      expect(find.widgetWithText(TranslatedText, '✓ Verified'), findsNothing);
    });

    testWidgets('SearchScreen renders businessName when job was deleted', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final chunilalResponse = {
        "success": true,
        "message": "Members matching name search criteria retrieved",
        "data": [
          {
            "id": "d208b569-17cb-4caf-bc11-81daa4431e87",
            "mobileNumber": "917859821704",
            "email": null,
            "isVerified": false,
            "isActive": true,
            "profile": {
              "fullName": "Chunilal Rathoree",
              "city": "",
            },
            "job": {
              "companyName": "",
              "designation": "",
              "city": "Surat",
            },
            "business": {
              "businessName": "Google 1",
              "category": "Information Technology (IT) & Software",
              "city": "Bangalore Rural",
              "role": "ceo"
            },
          }
        ]
      };

      final dio = Dio();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.resolve(
              Response(
                requestOptions: options,
                data: chunilalResponse,
                statusCode: 200,
              ),
            );
          },
        ),
      );

      final repo = SearchRepository(dio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            searchRepositoryProvider.overrideWithValue(repo),
            currentUserMembershipStatusProvider.overrideWith((ref) async => 'Approved'),
          ],
          child: const MaterialApp(
            home: SearchScreen(initialTab: 0),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'ch');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.widgetWithText(TranslatedText, 'Chunilal Rathoree'), findsOneWidget);
      // Subtitle should be 'Bangalore Rural · ceo · Google 1' (City · Role · Business)
      expect(find.widgetWithText(TranslatedText, 'Bangalore Rural · ceo · Google 1'), findsOneWidget);
      // Tag pill should be 'Google 1'
      expect(find.widgetWithText(TranslatedText, 'Google 1'), findsOneWidget);
    });

    testWidgets('SearchScreen renders Option 3 subtitle for Job: City · Designation · Company', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final jobResponse = {
        "success": true,
        "message": "Members matching name search criteria retrieved",
        "data": [
          {
            "id": "job-user-1",
            "mobileNumber": "917859821703",
            "isVerified": true,
            "isActive": true,
            "profile": {
              "fullName": "Rohan Mehta",
              "city": "Surat",
            },
            "job": {
              "companyName": "Techstaunch",
              "designation": "Flutter Developer",
              "city": "Surat",
            },
            "business": null,
          }
        ]
      };

      final dio = Dio();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.resolve(
              Response(
                requestOptions: options,
                data: jobResponse,
                statusCode: 200,
              ),
            );
          },
        ),
      );

      final repo = SearchRepository(dio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            searchRepositoryProvider.overrideWithValue(repo),
            currentUserMembershipStatusProvider.overrideWith((ref) async => 'Approved'),
          ],
          child: const MaterialApp(
            home: SearchScreen(initialTab: 0),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Rohan');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.widgetWithText(TranslatedText, 'Rohan Mehta'), findsOneWidget);
      // Option 3 Subtitle: 'Surat · Flutter Developer · Techstaunch'
      expect(find.widgetWithText(TranslatedText, 'Surat · Flutter Developer · Techstaunch'), findsOneWidget);
      // Tag pill: 'Techstaunch'
      expect(find.widgetWithText(TranslatedText, 'Techstaunch'), findsOneWidget);
    });
  });
}
