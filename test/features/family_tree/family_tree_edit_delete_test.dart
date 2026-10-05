import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/family_tree/data/family_models.dart';
import 'package:community_connect/src/features/family_tree/data/family_provider.dart';
import 'package:community_connect/src/features/family_tree/presentation/family_tree_screen.dart';
import 'package:community_connect/src/features/family_tree/presentation/member_family_tree_screen.dart';
import 'package:community_connect/src/features/profile/data/profile_models.dart';
import 'package:community_connect/src/features/profile/data/profile_provider.dart';

class MockFamilyController extends FamilyController {
  final FamilyTreeNode tree;
  String? lastUpdatedId;
  Map<String, dynamic>? lastUpdatedData;
  String? lastDeletedId;

  MockFamilyController(this.tree);

  @override
  Future<FamilyTreeNode?> build() async {
    return tree;
  }

  @override
  Future<void> updateFamilyMember(String id, Map<String, dynamic> data) async {
    lastUpdatedId = id;
    lastUpdatedData = data;
  }

  @override
  Future<void> deleteFamilyMember(String id) async {
    lastDeletedId = id;
  }
}

class MockProfileController extends ProfileController {
  final UserProfile profile;
  MockProfileController(this.profile);

  @override
  Future<UserProfile?> build() async => profile;
}

void main() {
  group('Family Tree Edit and Delete Node Tests', () {
    late FamilyTreeNode sampleTree;
    late UserProfile dummyProfile;

    setUp(() {
      dummyProfile = UserProfile(
        id: 'self-123',
        profile: const CoreProfile(fullName: 'Self User'),
      );

      sampleTree = FamilyTreeNode(
        id: 'self-123',
        fullName: 'Self User',
        gender: 'Male',
        directRelationship: 'Self',
        isRegisteredUser: true,
        parents: [
          FamilyTreeNode(
            id: 'father-456',
            fullName: 'Ramesh Agarwal',
            gender: 'Male',
            directRelationship: 'Father',
            relationshipType: 'Father',
            isRegisteredUser: true,
            linkedUserId: 'linked-user-father',
            isDeceased: false,
          ),
          FamilyTreeNode(
            id: 'mother-789',
            fullName: 'Sita Devi',
            gender: 'Female',
            directRelationship: 'Mother',
            relationshipType: 'Mother',
            isRegisteredUser: false,
            isDeceased: true,
          ),
        ],
      );
    });

    testWidgets('Tapping relative node in FamilyTreeScreen opens actions sheet with Edit and Delete options', (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = MockFamilyController(sampleTree);

      final router = GoRouter(
        initialLocation: '/family_tree',
        routes: [
          GoRoute(
            path: '/family_tree',
            builder: (context, state) => const FamilyTreeScreen(),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            familyControllerProvider.overrideWith(() => controller),
            profileControllerProvider.overrideWith(() => MockProfileController(dummyProfile)),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find Ramesh Agarwal (Father)
      final fatherNode = find.text('Ramesh Agarwal');
      expect(fatherNode, findsOneWidget);

      // Tap on Ramesh Agarwal
      await tester.tap(fatherNode);
      await tester.pumpAndSettle();

      // Verify actions sheet opens with all 3 actions
      expect(find.text('View Profile'), findsOneWidget);
      expect(find.text('Edit Family Member'), findsOneWidget);
      expect(find.text('Remove from Family Tree'), findsOneWidget);
    });

    testWidgets('Edit Family Member sheet allows modifying all details (name, relation, mobile, deceased) and submits', (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = MockFamilyController(sampleTree);

      final router = GoRouter(
        initialLocation: '/family_tree',
        routes: [
          GoRoute(
            path: '/family_tree',
            builder: (context, state) => const FamilyTreeScreen(),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            familyControllerProvider.overrideWith(() => controller),
            profileControllerProvider.overrideWith(() => MockProfileController(dummyProfile)),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap on Ramesh Agarwal
      await tester.tap(find.text('Ramesh Agarwal'));
      await tester.pumpAndSettle();

      // Tap Edit Family Member
      await tester.tap(find.text('Edit Family Member'));
      await tester.pumpAndSettle();

      // Verify Edit Sheet header and editable fields
      expect(find.text('Edit Family Member'), findsWidgets);
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Gender'), findsOneWidget);
      expect(find.text('Relationship'), findsOneWidget);
      expect(find.text('Date of Birth'), findsOneWidget);
      expect(find.text('Mobile Number'), findsOneWidget);
      expect(find.text('Is Deceased'), findsOneWidget);

      // Edit name
      final nameField = find.widgetWithText(TextField, 'Ramesh Agarwal');
      expect(nameField, findsOneWidget);
      await tester.enterText(nameField, 'Rameshchandra Agarwal');
      await tester.pumpAndSettle();

      // Toggle Deceased status switch
      final deceasedSwitch = find.byType(Switch);
      expect(deceasedSwitch, findsOneWidget);
      await tester.tap(deceasedSwitch);
      await tester.pumpAndSettle();

      // Tap Save Changes
      final saveBtn = find.text('Save Changes');
      expect(saveBtn, findsOneWidget);
      await tester.tap(saveBtn);
      await tester.pumpAndSettle();

      // Verify controller was called with updated id and data
      expect(controller.lastUpdatedId, 'father-456');
      expect(controller.lastUpdatedData?['relationshipType'], 'Father');
      expect(controller.lastUpdatedData?['isDeceased'], true);
      expect(controller.lastUpdatedData?['fullName'], 'Rameshchandra Agarwal');
      expect(controller.lastUpdatedData?['gender'], 'Male');
    });

    testWidgets('Remove from Family Tree prompts confirmation and cancels or deletes accordingly', (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = MockFamilyController(sampleTree);

      final router = GoRouter(
        initialLocation: '/family_tree',
        routes: [
          GoRoute(
            path: '/family_tree',
            builder: (context, state) => const FamilyTreeScreen(),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            familyControllerProvider.overrideWith(() => controller),
            profileControllerProvider.overrideWith(() => MockProfileController(dummyProfile)),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap on Ramesh Agarwal
      await tester.tap(find.text('Ramesh Agarwal'));
      await tester.pumpAndSettle();

      // Tap Remove from Family Tree
      await tester.tap(find.text('Remove from Family Tree'));
      await tester.pumpAndSettle();

      // Verify confirmation dialog is visible
      expect(find.text('Remove from Tree?'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Remove'), findsOneWidget);

      // Tap Cancel first
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Delete should NOT be called
      expect(controller.lastDeletedId, isNull);

      // Actions sheet is still open
      expect(find.text('Remove from Family Tree'), findsOneWidget);

      await tester.tap(find.text('Remove from Family Tree'));
      await tester.pumpAndSettle();

      // Now tap Remove
      await tester.tap(find.text('Remove'));
      await tester.pumpAndSettle();

      // Delete SHOULD be called with member ID
      expect(controller.lastDeletedId, 'father-456');
    });

    testWidgets('MemberFamilyTreeScreen is read-only (no Add Member button, cannot edit/delete)', (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final controller = MockFamilyController(sampleTree);

      final router = GoRouter(
        initialLocation: '/member_tree',
        routes: [
          GoRoute(
            path: '/member_tree',
            builder: (context, state) => const MemberFamilyTreeScreen(
              userId: 'other-user-999',
              userName: 'Other Member',
            ),
          ),
          GoRoute(
            path: '/profile_view',
            builder: (context, state) => Scaffold(
              body: Text('Profile of ${(state.extra as Map)['id']}'),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            memberFamilyTreeProvider('other-user-999').overrideWith((ref) async => sampleTree),
            familyControllerProvider.overrideWith(() => controller),
            profileControllerProvider.overrideWith(() => MockProfileController(dummyProfile)),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check Add Member button is NOT present in AppBar
      expect(find.byTooltip('Add Member'), findsNothing);

      // Tap on Ramesh Agarwal (relative of the other user)
      final fatherNode = find.text('Ramesh Agarwal');
      expect(fatherNode, findsOneWidget);
      await tester.tap(fatherNode);
      await tester.pumpAndSettle();

      // In MemberFamilyTreeScreen, actions sheet is NOT shown, it navigates directly to profile
      expect(find.text('Edit Family Member'), findsNothing);
      expect(find.text('Remove from Family Tree'), findsNothing);
      expect(find.text('Profile of linked-user-father'), findsOneWidget);
    });
  });
}
