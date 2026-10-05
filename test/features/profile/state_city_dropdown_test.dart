import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/profile/data/profile_provider.dart';
import 'package:community_connect/src/features/profile/data/profile_models.dart';
import 'package:community_connect/src/features/search/presentation/search_screen.dart';
import 'package:community_connect/src/features/authentication/presentation/register_screen.dart';
import 'package:community_connect/src/common_widgets/custom_inputs.dart';

import 'dart:async';
import 'package:community_connect/src/features/search/data/search_models.dart';
import 'package:community_connect/src/features/search/data/search_provider.dart';

class _FakeSearchController extends SearchController {
  @override
  FutureOr<List<SearchResult>> build() => [];
}

class _FakeProfileController extends ProfileController {
  @override
  FutureOr<UserProfile?> build() => null;
}

void main() {
  group('State and City Dropdown Tests', () {
    testWidgets(
      'SearchScreen City dropdown is disabled with "Select State first" when no state selected',
      (tester) async {
        tester.view.physicalSize = const Size(800, 1200);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              searchControllerProvider.overrideWith(
                () => _FakeSearchController(),
              ),
              statesListProvider.overrideWith(
                (ref) async => ['Gujarat', 'Maharashtra', 'Rajasthan'],
              ),
              citiesListProvider('Gujarat').overrideWith(
                (ref) async => ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot'],
              ),
            ],
            child: const MaterialApp(home: Scaffold(body: SearchScreen())),
          ),
        );

        await tester.pumpAndSettle();

        // Open filters bottom sheet
        final filterButton = find.byIcon(Icons.tune_rounded);
        expect(filterButton, findsOneWidget);
        await tester.tap(filterButton);
        await tester.pumpAndSettle();

        // Verify City dropdown shows 'Select State first'
        final cityDropdownFinder = find.widgetWithText(
          SearchableDropdownFormField<String>,
          'Select State first',
        );
        expect(cityDropdownFinder, findsOneWidget);

        final cityDropdownWidget = tester
            .widget<SearchableDropdownFormField<String>>(cityDropdownFinder);
        expect(cityDropdownWidget.onChanged, isNull);
      },
    );

    testWidgets(
      'Selecting a state enables the city dropdown and loads its cities',
      (tester) async {
        tester.view.physicalSize = const Size(800, 1200);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              searchControllerProvider.overrideWith(
                () => _FakeSearchController(),
              ),
              statesListProvider.overrideWith(
                (ref) async => ['Gujarat', 'Maharashtra'],
              ),
              citiesListProvider(
                'Gujarat',
              ).overrideWith((ref) async => ['Surat', 'Rajkot', 'Vadodara']),
            ],
            child: const MaterialApp(home: Scaffold(body: SearchScreen())),
          ),
        );

        await tester.pumpAndSettle();

        // Open filters bottom sheet
        await tester.tap(find.byIcon(Icons.tune_rounded));
        await tester.pumpAndSettle();

        // Select 'Gujarat' in State dropdown
        final stateDropdown = find.widgetWithText(
          SearchableDropdownFormField<String>,
          'Select State',
        );
        expect(stateDropdown, findsOneWidget);
        await tester.tap(stateDropdown);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Gujarat').last);
        await tester.pumpAndSettle();

        // Now City dropdown should show 'Select City' and be enabled
        final cityDropdown = find.widgetWithText(
          SearchableDropdownFormField<String>,
          'Select City',
        );
        expect(cityDropdown, findsOneWidget);

        await tester.tap(cityDropdown);
        await tester.pumpAndSettle();

        // Surat and Rajkot should be available
        expect(find.text('Surat').hitTestable(), findsWidgets);
        expect(find.text('Rajkot').hitTestable(), findsWidgets);
      },
    );

    testWidgets(
      'RegisterScreen City dropdown is disabled until state is selected',
      (tester) async {
        tester.view.physicalSize = const Size(800, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              profileControllerProvider.overrideWith(
                () => _FakeProfileController(),
              ),
              statesListProvider.overrideWith(
                (ref) async => ['Gujarat', 'Maharashtra', 'Rajasthan'],
              ),
              citiesListProvider(
                'Gujarat',
              ).overrideWith((ref) async => ['Ahmedabad', 'Surat']),
            ],
            child: const MaterialApp(home: RegisterScreen()),
          ),
        );

        await tester.pumpAndSettle();

        // Verify City dropdown initially shows 'Select State first' and is disabled
        final disabledCityDropdown = find.widgetWithText(
          SearchableDropdownFormField<String>,
          'Select State first',
        );
        expect(disabledCityDropdown, findsOneWidget);
        final widget = tester.widget<SearchableDropdownFormField<String>>(
          disabledCityDropdown,
        );
        expect(widget.onChanged, isNull);

        // Select State 'Gujarat'
        final stateDropdown = find.widgetWithText(
          SearchableDropdownFormField<String>,
          'Select State',
        );
        expect(stateDropdown, findsOneWidget);
        await tester.tap(stateDropdown);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Gujarat').last);
        await tester.pumpAndSettle();

        // Now City dropdown should show 'Select City' and be enabled
        final cityDropdown = find.widgetWithText(
          SearchableDropdownFormField<String>,
          'Select City',
        );
        expect(cityDropdown, findsOneWidget);

        await tester.tap(cityDropdown);
        await tester.pumpAndSettle();

        expect(find.text('Ahmedabad').hitTestable(), findsWidgets);
        expect(find.text('Surat').hitTestable(), findsWidgets);
      },
    );
  });
}
