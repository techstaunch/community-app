import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/profile/data/profile_models.dart';
import 'package:community_connect/src/features/profile/data/profile_provider.dart';
import 'package:community_connect/src/features/profile/presentation/profile_view_screen.dart';

void main() {
  group('ProfileViewScreen Work / Business Tab Tests', () {
    testWidgets('renders both Business and Job cards when both exist', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      const userProfile = UserProfile(
        id: 'user-123',
        profile: CoreProfile(
          fullName: 'Chunilal Rathoree',
          city: 'Surat',
        ),
        job: JobDetails(
          id: 'job-1',
          companyName: 'techstaunch',
          designation: 'Flutter developer',
          industry: 'Information Technology (IT) & Software',
          yearsOfExperience: 10,
          city: 'Surat',
          state: 'Gujarat',
        ),
        business: BusinessDetails(
          id: 'biz-1',
          businessName: 'Google 1',
          category: 'Information Technology (IT) & Software',
          productsServices: 'it services',
          role: 'CEO',
          city: 'Bangalore Rural',
          state: 'Karnataka',
        ),
        privacySettings: PrivacySettings(
          showBusinessInfo: false,
          showProfessionalInfo: false,
        ),
      );

      final router = GoRouter(
        initialLocation: '/profile_view',
        routes: [
          GoRoute(
            path: '/profile_view',
            builder: (context, state) =>
                const ProfileViewScreen(userId: 'user-123'),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            memberProfileProvider(
              'user-123',
            ).overrideWith((ref) async => userProfile),
            blockStatusProvider(
              'user-123',
            ).overrideWith((ref) async => false),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );

      await tester.pumpAndSettle();

      // Tap the Business tab
      final businessTab = find.text('Business');
      expect(businessTab, findsOneWidget);
      await tester.tap(businessTab);
      await tester.pumpAndSettle();

      // Verify Business Profile section and details
      expect(find.text('Business Profile'), findsOneWidget);
      expect(find.text('Google 1'), findsOneWidget);
      expect(find.text('CEO'), findsOneWidget);
      expect(find.text('it services'), findsOneWidget);

      // Verify Job Profile section and details
      expect(find.text('Job Profile'), findsOneWidget);
      expect(find.text('Flutter developer'), findsWidgets);
      expect(find.text('techstaunch'), findsWidgets);
      expect(find.text('10 Years'), findsOneWidget);
      expect(find.text('Surat, Gujarat'), findsOneWidget);
    });

    testWidgets('renders only Job card when business is not available', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      const userProfile = UserProfile(
        id: 'user-456',
        profile: CoreProfile(
          fullName: 'Rahul Sharma',
        ),
        job: JobDetails(
          companyName: 'Infosys',
          designation: 'Software Engineer',
          yearsOfExperience: 3,
          city: 'Pune',
          state: 'Maharashtra',
        ),
      );

      final router = GoRouter(
        initialLocation: '/profile_view',
        routes: [
          GoRoute(
            path: '/profile_view',
            builder: (context, state) =>
                const ProfileViewScreen(userId: 'user-456'),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            memberProfileProvider(
              'user-456',
            ).overrideWith((ref) async => userProfile),
            blockStatusProvider(
              'user-456',
            ).overrideWith((ref) async => false),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );

      await tester.pumpAndSettle();

      final businessTab = find.text('Business');
      await tester.tap(businessTab);
      await tester.pumpAndSettle();

      expect(find.text('Business Profile'), findsNothing);
      expect(find.text('Job Profile'), findsOneWidget);
      expect(find.text('Software Engineer'), findsWidgets);
      expect(find.text('Infosys'), findsWidgets);
      expect(find.text('3 Years'), findsOneWidget);
    });

    testWidgets('shows privacy lock when professional info is marked private', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      const userProfile = UserProfile(
        id: 'user-789',
        profile: CoreProfile(fullName: 'Secret Worker'),
        job: JobDetails(
          companyName: 'Classified Corp',
          designation: 'Special Agent',
        ),
        privacySettings: PrivacySettings(
          showProfessionalInfo: true, // private
        ),
      );

      final router = GoRouter(
        initialLocation: '/profile_view',
        routes: [
          GoRoute(
            path: '/profile_view',
            builder: (context, state) =>
                const ProfileViewScreen(userId: 'user-789'),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            memberProfileProvider(
              'user-789',
            ).overrideWith((ref) async => userProfile),
            blockStatusProvider(
              'user-789',
            ).overrideWith((ref) async => false),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );

      await tester.pumpAndSettle();

      final businessTab = find.text('Business');
      await tester.tap(businessTab);
      await tester.pumpAndSettle();

      expect(
        find.text('Job details are hidden by privacy settings'),
        findsOneWidget,
      );
      expect(find.text('Classified Corp'), findsNothing);
    });
  });
}
