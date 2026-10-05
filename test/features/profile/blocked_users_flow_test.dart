import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/family_tree/data/family_models.dart';
import 'package:community_connect/src/features/family_tree/data/family_provider.dart';
import 'package:community_connect/src/features/profile/data/profile_models.dart';
import 'package:community_connect/src/features/profile/data/profile_provider.dart';
import 'package:community_connect/src/features/profile/presentation/blocked_users_screen.dart';
import 'package:community_connect/src/features/profile/presentation/profile_view_screen.dart';

class FakeProfileController extends ProfileController {
  @override
  FutureOr<UserProfile?> build() => const UserProfile(id: 'my-user-id');
}

class FakeFamilyController extends FamilyController {
  @override
  FutureOr<FamilyTreeNode?> build() => null;
}

void main() {
  group('Blocked Users and Block Status UI Flow Tests', () {
    const blockedUserId = 'blocked-user-999';

    const dummyBlockedProfile = UserProfile(
      id: blockedUserId,
      mobileNumber: '9998887770',
      qrCode: QrCodeDetails(qrImageUrl: 'https://example.com/qr_blocked.png'),
      pdfUrl: 'https://example.com/biodata_blocked.pdf',
      privacySettings: PrivacySettings(isFindmatch: true),
      profile: CoreProfile(
        fullName: 'Ramesh Sharma',
        gender: 'Male',
        city: 'Jaipur',
        gotra: 'Kashyap',
      ),
    );

    const dummyFamilyNode = FamilyTreeNode(
      id: blockedUserId,
      fullName: 'Ramesh Sharma',
      relationshipType: 'Brother',
    );

    Widget createScreenUtilWrapper({required Widget child}) {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) => child,
      );
    }

    testWidgets(
      'ProfileViewScreen shows blocked banner and hides private profile tabs when user is blocked',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        final router = GoRouter(
          initialLocation: '/profile_view',
          routes: [
            GoRoute(
              path: '/profile_view',
              builder: (context, state) => const ProfileViewScreen(
                userId: blockedUserId,
                isFromMyFamilyTree: true,
                familyNode: dummyFamilyNode,
              ),
            ),
          ],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              profileControllerProvider.overrideWith(FakeProfileController.new),
              familyControllerProvider.overrideWith(FakeFamilyController.new),
              memberProfileProvider(blockedUserId)
                  .overrideWith((ref) async => dummyBlockedProfile),
              blockStatusProvider(blockedUserId)
                  .overrideWith((ref) async => true),
            ],
            child: createScreenUtilWrapper(
              child: MaterialApp.router(routerConfig: router),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // 1. Should show the user name and blocked indication
        expect(find.text('Ramesh Sharma'), findsOneWidget);
        expect(find.text('Blocked User'), findsOneWidget);
        expect(find.text('This Profile is Blocked'), findsOneWidget);
        expect(
          find.text(
            'You have blocked this member. Their personal information, contact details, work profile, matrimonial biodata, and family relations are hidden.',
          ),
          findsOneWidget,
        );

        // 2. Should show the Unblock Member button
        expect(find.text('Unblock Member'), findsOneWidget);

        // 3. Private details and content tabs MUST NOT be visible
        expect(find.text('About'), findsNothing);
        expect(find.text('Business'), findsNothing);
        expect(find.text('Family'), findsNothing);
        expect(find.text('Contact Details'), findsNothing);
        expect(find.byTooltip('View QR Code'), findsNothing);
        expect(find.byIcon(Icons.picture_as_pdf_rounded), findsNothing);
      },
    );

    testWidgets(
      'BlockedUsersScreen renders empty state when no users are blocked',
      (tester) async {
        final router = GoRouter(
          initialLocation: '/blocked_users',
          routes: [
            GoRoute(
              path: '/blocked_users',
              builder: (context, state) => const BlockedUsersScreen(),
            ),
          ],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              blockedUsersProvider.overrideWith((ref) async => []),
            ],
            child: createScreenUtilWrapper(
              child: MaterialApp.router(routerConfig: router),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Blocked Users'), findsOneWidget);
        expect(find.text('No Blocked Users'), findsOneWidget);
        expect(
          find.text('You have not blocked any members.'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'BlockedUsersScreen renders list of blocked users with unblock buttons',
      (tester) async {
        final router = GoRouter(
          initialLocation: '/blocked_users',
          routes: [
            GoRoute(
              path: '/blocked_users',
              builder: (context, state) => const BlockedUsersScreen(),
            ),
          ],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              blockedUsersProvider.overrideWith((ref) async => [
                    dummyBlockedProfile,
                  ]),
            ],
            child: createScreenUtilWrapper(
              child: MaterialApp.router(routerConfig: router),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Blocked Users'), findsOneWidget);
        expect(find.text('Ramesh Sharma'), findsOneWidget);
        expect(find.text('Jaipur • Kashyap'), findsOneWidget);
        expect(find.text('Unblock'), findsOneWidget);
      },
    );

    testWidgets(
      'ProfileViewScreen shows unblock confirmation dialog when Unblock Member button is pressed',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        final router = GoRouter(
          initialLocation: '/profile_view',
          routes: [
            GoRoute(
              path: '/profile_view',
              builder: (context, state) => const ProfileViewScreen(
                userId: blockedUserId,
              ),
            ),
          ],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              profileControllerProvider.overrideWith(FakeProfileController.new),
              memberProfileProvider(blockedUserId)
                  .overrideWith((ref) async => dummyBlockedProfile),
              blockStatusProvider(blockedUserId)
                  .overrideWith((ref) async => true),
            ],
            child: createScreenUtilWrapper(
              child: MaterialApp.router(routerConfig: router),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final unblockButton = find.text('Unblock Member');
        expect(unblockButton, findsOneWidget);

        await tester.ensureVisible(unblockButton);
        await tester.pumpAndSettle();
        await tester.tap(unblockButton);
        await tester.pumpAndSettle();

        expect(find.text('Unblock Member?'), findsOneWidget);
        expect(find.text('Cancel'), findsOneWidget);
        expect(find.text('Unblock'), findsOneWidget);
      },
    );

    testWidgets(
      'ProfileViewScreen renders normal profile tabs and Report & Block menu when user is not blocked',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        final router = GoRouter(
          initialLocation: '/profile_view',
          routes: [
            GoRoute(
              path: '/profile_view',
              builder: (context, state) => const ProfileViewScreen(
                userId: blockedUserId,
              ),
            ),
          ],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              profileControllerProvider.overrideWith(FakeProfileController.new),
              memberProfileProvider(blockedUserId)
                  .overrideWith((ref) async => dummyBlockedProfile),
              blockStatusProvider(blockedUserId)
                  .overrideWith((ref) async => false),
            ],
            child: createScreenUtilWrapper(
              child: MaterialApp.router(routerConfig: router),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // 1. Normal tabs should be visible
        expect(find.text('About'), findsOneWidget);
        expect(find.text('Business'), findsOneWidget);
        expect(find.text('Family'), findsOneWidget);

        // 2. Blocked banner should NOT be visible
        expect(find.text('This Profile is Blocked'), findsNothing);
        expect(find.text('Unblock Member'), findsNothing);

        // 3. Open top menu and verify Report & Block is available
        final menuButton = find.byIcon(Icons.more_vert);
        expect(menuButton, findsOneWidget);
        await tester.tap(menuButton);
        await tester.pumpAndSettle();

        expect(find.text('Report & Block'), findsOneWidget);
        expect(find.text('Unblock User'), findsNothing);
      },
    );
  });
}
