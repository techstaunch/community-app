import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/family_tree/data/family_models.dart';
import 'package:community_connect/src/features/family_tree/data/family_provider.dart';
import 'package:community_connect/src/features/family_tree/presentation/member_family_tree_screen.dart';
import 'package:community_connect/src/features/profile/data/profile_models.dart';
import 'package:community_connect/src/features/profile/data/profile_provider.dart';
import 'package:community_connect/src/features/profile/presentation/my_profile_screen.dart';
import 'package:community_connect/src/features/profile/presentation/profile_view_screen.dart';

void main() {
  group('Profile & Family Tree Navigation Tests', () {
    testWidgets('MyProfileScreen: tapping linked family member navigates to /profile_view', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      String? pushedProfileId;

      final testProfile = UserProfile(
        id: 'self-user-id',
        profile: const CoreProfile(fullName: 'Self User', city: 'Mumbai', gotra: 'Garg'),
        ownedFamilyMembers: [
          const OwnedFamilyMember(
            id: 'mem-1',
            fullName: 'Ramesh Agarwal',
            relationshipType: 'Father',
            linkedUserId: 'linked-father-id',
          ),
          const OwnedFamilyMember(
            id: 'mem-2',
            fullName: 'Sita Agarwal',
            relationshipType: 'Mother',
            linkedUserId: null, // Unlinked
          ),
        ],
      );

      final router = GoRouter(
        initialLocation: '/my_profile',
        routes: [
          GoRoute(
            path: '/my_profile',
            builder: (context, state) => const MyProfileScreen(),
          ),
          GoRoute(
            path: '/profile_view',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              pushedProfileId = extra?['id'] as String?;
              return Scaffold(body: Text('Profile View: $pushedProfileId'));
            },
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileControllerProvider.overrideWith(() => MockProfileController(testProfile)),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Switch to Family tab
      final familyTabFinder = find.text('Family');
      expect(familyTabFinder, findsOneWidget);
      await tester.tap(familyTabFinder);
      await tester.pumpAndSettle();

      // Tap unlinked member (Mother)
      final unlinkedMotherFinder = find.text('Sita Agarwal');
      expect(unlinkedMotherFinder, findsOneWidget);
      await tester.tap(unlinkedMotherFinder);
      await tester.pumpAndSettle();

      // Unlinked member should NOT navigate
      expect(pushedProfileId, isNull);

      // Tap linked member (Father)
      final linkedFatherFinder = find.text('Ramesh Agarwal');
      expect(linkedFatherFinder, findsOneWidget);
      await tester.tap(linkedFatherFinder);
      await tester.pumpAndSettle();

      // Linked member should navigate to /profile_view with linkedUserId
      expect(pushedProfileId, 'linked-father-id');
      expect(find.text('Profile View: linked-father-id'), findsOneWidget);
    });

    testWidgets('ProfileViewScreen: tapping View Full Family Tree navigates to member family tree', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      String? pushedUserId;
      String? pushedUserName;

      final memberProfile = UserProfile(
        id: 'member-user-123',
        profile: const CoreProfile(fullName: 'Vikram Mehta', city: 'Delhi', gotra: 'Bansal'),
        privacySettings: const PrivacySettings(showFamilyInfo: true),
        ownedFamilyMembers: [
          const OwnedFamilyMember(
            id: 'mem-10',
            fullName: 'Anita Mehta',
            relationshipType: 'Spouse',
            linkedUserId: 'anita-linked-id',
          ),
        ],
      );

      final router = GoRouter(
        initialLocation: '/profile_view',
        routes: [
          GoRoute(
            path: '/profile_view',
            builder: (context, state) => const ProfileViewScreen(userId: 'member-user-123'),
          ),
          GoRoute(
            path: '/member_family_tree',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              pushedUserId = extra?['userId'] as String?;
              pushedUserName = extra?['userName'] as String?;
              return Scaffold(body: Text('Tree of $pushedUserName ($pushedUserId)'));
            },
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            memberProfileProvider('member-user-123').overrideWith((ref) async => memberProfile),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Switch to Family tab
      final familyTabFinder = find.text('Family');
      expect(familyTabFinder, findsOneWidget);
      await tester.tap(familyTabFinder);
      await tester.pumpAndSettle();

      // Find "View Full Family Tree" button
      final treeButtonFinder = find.text('View Full Family Tree');
      expect(treeButtonFinder, findsOneWidget);

      await tester.tap(treeButtonFinder);
      await tester.pumpAndSettle();

      // Verify navigation to /member_family_tree with userId and userName
      expect(pushedUserId, 'member-user-123');
      expect(pushedUserName, 'Vikram Mehta');
      expect(find.text('Tree of Vikram Mehta (member-user-123)'), findsOneWidget);
    });

    testWidgets('MemberFamilyTreeScreen renders back button, custom header, and hides add button', (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final otherMemberTree = FamilyTreeNode(
        id: 'member-user-123',
        fullName: 'Vikram Mehta',
        gender: 'Male',
        directRelationship: 'Self',
        isRegisteredUser: true,
      );

      final router = GoRouter(
        initialLocation: '/home',
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => context.push('/member_family_tree', extra: {
                    'userId': 'member-user-123',
                    'userName': 'Vikram Mehta',
                  }),
                  child: const Text('Open Tree'),
                ),
              ),
            ),
          ),
          GoRoute(
            path: '/member_family_tree',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return MemberFamilyTreeScreen(
                userId: extra?['userId'] as String? ?? '',
                userName: extra?['userName'] as String?,
              );
            },
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            memberFamilyTreeProvider('member-user-123').overrideWith((ref) async => otherMemberTree),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Open tree
      await tester.tap(find.text('Open Tree'));
      await tester.pumpAndSettle();

      // Verify header text has user's name
      expect(find.text("Vikram Mehta's Family Tree"), findsOneWidget);

      // Verify "➕" Add Family Member button is hidden
      expect(find.text('➕'), findsNothing);

      // Verify back button is visible and tapping it pops back to previous screen
      final backButton = find.byIcon(Icons.arrow_back);
      expect(backButton, findsOneWidget);

      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Back on Home screen
      expect(find.text('Open Tree'), findsOneWidget);
    });
  });
}

class MockProfileController extends ProfileController {
  final UserProfile mockProfile;
  MockProfileController(this.mockProfile);

  @override
  Future<UserProfile?> build() async {
    return mockProfile;
  }
}
