import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/profile/data/profile_provider.dart';
import 'package:community_connect/src/features/profile/data/profile_models.dart';
import 'package:community_connect/src/features/search/presentation/search_screen.dart';
import 'package:community_connect/src/features/authentication/presentation/register_screen.dart';
import 'package:community_connect/src/features/search/data/search_models.dart';
import 'package:community_connect/src/features/search/data/search_repository.dart';
import 'package:community_connect/src/common_widgets/custom_inputs.dart';

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

class _FakeProfileController extends ProfileController {
  @override
  FutureOr<UserProfile?> build() => null;
}

void main() {
  group('Gotra Dropdown Tests', () {
    test('kCommunityGotras contains standard community and vedic gotras', () {
      expect(kCommunityGotras, isNotEmpty);
      expect(kCommunityGotras.contains('Kashyap'), isTrue);
      expect(kCommunityGotras.contains('Bansal'), isTrue);
      expect(kCommunityGotras.contains('Garg'), isTrue);
      expect(kCommunityGotras.contains('Goyal'), isTrue);
      expect(kCommunityGotras.contains('Mittal'), isTrue);
      expect(kCommunityGotras.contains('Shandilya'), isTrue);
      expect(kCommunityGotras.contains('Bharadwaj'), isTrue);
    });

    testWidgets(
      'RegisterScreen renders Gotra and Maternal Gotra as dropdowns',
      (tester) async {
        tester.view.physicalSize = const Size(800, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              profileControllerProvider.overrideWith(
                () => _FakeProfileController(),
              ),
              statesListProvider.overrideWith(
                (ref) async => ['Gujarat', 'Maharashtra'],
              ),
              citiesListProvider(
                '',
              ).overrideWith((ref) async => ['Ahmedabad', 'Surat']),
            ],
            child: const MaterialApp(home: RegisterScreen()),
          ),
        );

        await tester.pumpAndSettle();

        // Find Gotra dropdown
        final gotraDropdown = find.widgetWithText(
          SearchableDropdownFormField<String>,
          'Select Gotra *',
        );
        expect(gotraDropdown, findsOneWidget);

        // Scroll to Maternal Gotra field
        final maternalGotraLabel = find.text('Maternal Gotra').first;
        await tester.ensureVisible(maternalGotraLabel);
        await tester.pumpAndSettle();

        // Find Maternal Gotra dropdown (hint is 'Select Gotra')
        final maternalGotraDropdown = find.widgetWithText(
          SearchableDropdownFormField<String>,
          'Select Gotra',
        );
        expect(maternalGotraDropdown, findsOneWidget);

        // Tap Gotra dropdown and verify items appear
        await tester.tap(gotraDropdown);
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField).last, 'Kashyap');
        await tester.pumpAndSettle();

        expect(find.text('Kashyap').hitTestable(), findsWidgets);
        await tester.enterText(find.byType(TextField).last, 'Bansal');
        await tester.pumpAndSettle();
        expect(find.text('Bansal').hitTestable(), findsWidgets);

        // Select Bansal
        await tester.tap(find.text('Bansal').last);
        await tester.pumpAndSettle();

        // Tap Maternal Gotra dropdown and verify items appear
        await tester.tap(maternalGotraDropdown);
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField).last, 'Garg');
        await tester.pumpAndSettle();

        expect(find.text('Garg').hitTestable(), findsWidgets);
      },
    );

    testWidgets(
      'SearchScreen Business filter tab renders Business Category dropdown',
      (tester) async {
        tester.view.physicalSize = const Size(800, 1200);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              searchRepositoryProvider.overrideWithValue(
                _FakeSearchRepository(),
              ),
              statesListProvider.overrideWith((ref) async => ['Gujarat']),
              citiesListProvider('').overrideWith((ref) async => ['Ahmedabad']),
            ],
            child: const MaterialApp(
              home: Scaffold(body: SearchScreen(initialTab: 0)),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Open filters bottom sheet
        await tester.tap(find.byIcon(Icons.tune_rounded));
        await tester.pumpAndSettle();

        // Check Business Category dropdown is present
        final catFilterDropdown = find.widgetWithText(
          SearchableDropdownFormField<String>,
          'Select Category',
        );
        expect(catFilterDropdown, findsOneWidget);
      },
    );

    testWidgets('SearchScreen Matrimony filter tab renders Gotra dropdown', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            searchRepositoryProvider.overrideWithValue(_FakeSearchRepository()),
            statesListProvider.overrideWith((ref) async => ['Gujarat']),
            citiesListProvider('').overrideWith((ref) async => ['Ahmedabad']),
          ],
          child: const MaterialApp(
            home: Scaffold(body: SearchScreen(initialTab: 1)),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Open filters bottom sheet
      await tester.tap(find.byIcon(Icons.tune_rounded));
      await tester.pumpAndSettle();

      // Check Gotra dropdown is present in Matrimony tab
      final gotraFilterDropdown = find.widgetWithText(
        SearchableDropdownFormField<String>,
        'Select Gotra',
      );
      expect(gotraFilterDropdown, findsOneWidget);

      // Open Gotra dropdown
      await tester.tap(gotraFilterDropdown);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'Kashyap');
      await tester.pumpAndSettle();

      expect(find.text('Kashyap').hitTestable(), findsWidgets);
    });
  });
}
