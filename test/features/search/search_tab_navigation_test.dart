import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/community/data/community_provider.dart';
import 'package:community_connect/src/features/search/presentation/search_screen.dart';
import 'package:community_connect/src/features/search/data/search_models.dart';
import 'package:community_connect/src/features/search/data/search_repository.dart';

class _FakeSearchRepository extends SearchRepository {
  _FakeSearchRepository() : super(Dio());

  @override
  Future<List<SearchResult>> searchMembers({
    String? query,
    String? fullName,
    String? state,
    String? city,
    String? gender,
    String? gotra,
    String? surname,
    String? businessCategory,
    String? occupation,
    int? ageMin,
    int? ageMax,
    int page = 1,
    int limit = 10,
  }) async => [];

  @override
  Future<List<SearchResult>> findMatchMembers({
    String? query,
    String? fullName,
    String? state,
    String? city,
    String? gender,
    String? gotra,
    String? surname,
    String? occupation,
    int? ageMin,
    int? ageMax,
    int page = 1,
    int limit = 10,
  }) async => [];
}

void main() {
  group('SearchScreen Tab Navigation Tests', () {
    testWidgets('SearchScreen opens with Business tab selected by default (initialTab: 0)', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            searchRepositoryProvider.overrideWithValue(_FakeSearchRepository()),
            currentUserMembershipStatusProvider.overrideWith((ref) async => 'Approved'),
          ],
          child: const MaterialApp(
            home: SearchScreen(initialTab: 0),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Business tab should be active by default
      expect(find.text('Search businesses...'), findsOneWidget);
      expect(find.text('Search Businesses'), findsOneWidget);
    });

    testWidgets('SearchScreen opens with Find Match tab selected when initialTab is 1', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            searchRepositoryProvider.overrideWithValue(_FakeSearchRepository()),
            currentUserMembershipStatusProvider.overrideWith((ref) async => 'Approved'),
          ],
          child: const MaterialApp(
            home: SearchScreen(initialTab: 1),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find Match tab button should be selected (bold style and search match hint)
      expect(find.text('Search matches...'), findsOneWidget);
      expect(find.text('Find Your Match'), findsOneWidget);
    });

    testWidgets('SearchScreen synchronizes selectedTab when initialTab updates from 0 to 1', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      // Start with initialTab = 0 (Business)
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            searchRepositoryProvider.overrideWithValue(_FakeSearchRepository()),
            currentUserMembershipStatusProvider.overrideWith((ref) async => 'Approved'),
          ],
          child: const MaterialApp(
            home: SearchScreen(initialTab: 0),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Search businesses...'), findsOneWidget);
      expect(find.text('Search Businesses'), findsOneWidget);

      // Now re-pump with initialTab = 1 (Find Match), simulating navigation to Find Match
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            searchRepositoryProvider.overrideWithValue(_FakeSearchRepository()),
            currentUserMembershipStatusProvider.overrideWith((ref) async => 'Approved'),
          ],
          child: const MaterialApp(
            home: SearchScreen(initialTab: 1),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // It must switch to Find Match
      expect(find.text('Search matches...'), findsOneWidget);
      expect(find.text('Find Your Match'), findsOneWidget);
    });
  });
}
