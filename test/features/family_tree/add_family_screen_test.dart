import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/family_tree/data/family_models.dart';
import 'package:community_connect/src/features/family_tree/data/family_provider.dart';
import 'package:community_connect/src/features/family_tree/presentation/add_family_screen.dart';
import 'package:community_connect/src/features/profile/data/profile_models.dart';
import 'package:community_connect/src/features/profile/data/profile_provider.dart';

class MockFamilyAddController extends FamilyController {
  Map<String, dynamic>? submittedData;

  @override
  Future<FamilyTreeNode?> build() async {
    return FamilyTreeNode(
      id: 'self-1',
      fullName: 'Viewer User',
      gender: 'Male',
      directRelationship: 'Self',
    );
  }

  @override
  Future<void> addFamilyMember(Map<String, dynamic> data) async {
    submittedData = data;
  }
}

class MockUserProfileController extends ProfileController {
  final UserProfile profile;
  MockUserProfileController(this.profile);

  @override
  Future<UserProfile?> build() async => profile;
}

void main() {
  group('AddFamilyScreen Tests', () {
    late UserProfile dummyProfile;

    setUp(() {
      dummyProfile = UserProfile(
        id: 'self-1',
        mobileNumber: '9999999999',
        profile: const CoreProfile(fullName: 'Viewer User'),
      );
    });

    testWidgets('Default mode is Create New Member and link switch is invisible', (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final familyController = MockFamilyAddController();

      final router = GoRouter(
        initialLocation: '/add_family',
        routes: [
          GoRoute(
            path: '/add_family',
            builder: (context, state) => const AddFamilyScreen(),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            familyControllerProvider.overrideWith(() => familyController),
            profileControllerProvider.overrideWith(() => MockUserProfileController(dummyProfile)),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Mode selector tabs
      expect(find.text('Create New Member'), findsOneWidget);
      expect(find.text('Add Member'), findsOneWidget);

      // Link to existing profile switch MUST be invisible
      expect(find.text('Link to existing profile?'), findsNothing);

      // Inputs for creating a user
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.textContaining('Mobile Number'), findsOneWidget);
      expect(find.text('Relation'), findsOneWidget);
      expect(find.text('Gender'), findsOneWidget);
    });

    testWidgets('Switching to Add Member shows Search App Member autocomplete', (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final familyController = MockFamilyAddController();

      final router = GoRouter(
        initialLocation: '/add_family',
        routes: [
          GoRoute(
            path: '/add_family',
            builder: (context, state) => const AddFamilyScreen(),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            familyControllerProvider.overrideWith(() => familyController),
            profileControllerProvider.overrideWith(() => MockUserProfileController(dummyProfile)),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap on 'Add Member'
      await tester.tap(find.text('Add Member'));
      await tester.pumpAndSettle();

      // In Add Member mode, Search App Member is shown
      expect(find.text('Search App Member'), findsOneWidget);
      expect(find.text('Type to search member by name...'), findsOneWidget);
    });

    testWidgets('Submitting new member with mobile number calls addFamilyMember with linkedMobile', (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final familyController = MockFamilyAddController();

      final router = GoRouter(
        initialLocation: '/add_family',
        routes: [
          GoRoute(
            path: '/add_family',
            builder: (context, state) => const AddFamilyScreen(),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            familyControllerProvider.overrideWith(() => familyController),
            profileControllerProvider.overrideWith(() => MockUserProfileController(dummyProfile)),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Enter Full Name
      final nameFields = find.byType(TextField);
      await tester.enterText(nameFields.at(0), 'Rohit Agarwal');
      await tester.pumpAndSettle();

      // Enter Mobile Number
      await tester.enterText(nameFields.at(1), '9876543210');
      await tester.pumpAndSettle();

      // Select Relation: tap DropdownFormField for Relation
      final relationDropdown = find.text('Select Relation');
      expect(relationDropdown, findsOneWidget);
      await tester.ensureVisible(relationDropdown);
      await tester.pumpAndSettle();
      await tester.tap(relationDropdown, warnIfMissed: false);
      await tester.pumpAndSettle();

      // Select 'Brother (Bhai)'
      final brotherItem = find.text('Brother (Bhai)').last;
      await tester.tap(brotherItem);
      await tester.pumpAndSettle();

      // Tap 'Save & Add'
      final saveBtn = find.text('Save & Add');
      await tester.ensureVisible(saveBtn);
      await tester.pumpAndSettle();
      await tester.tap(saveBtn);
      await tester.pumpAndSettle();

      // Verify submitted data
      expect(familyController.submittedData, isNotNull);
      expect(familyController.submittedData!['fullName'], 'Rohit Agarwal');
      expect(familyController.submittedData!['linkedMobile'], '9876543210');
      expect(familyController.submittedData!['relationshipType'], 'Brother');
      expect(familyController.submittedData!['gender'], 'Male');
      expect(familyController.submittedData!['isDeceased'], false);
    });
  });
}
