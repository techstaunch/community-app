import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/profile/data/profile_models.dart';
import 'package:community_connect/src/features/profile/data/profile_provider.dart';
import 'package:community_connect/src/features/profile/presentation/profile_view_screen.dart';

void main() {
  group('ProfileViewScreen Export Buttons Tests', () {
    late UserProfile dummyMemberProfile;

    setUp(() {
        dummyMemberProfile = const UserProfile(
        id: 'member-101',
        mobileNumber: '9876543210',
        qrCode: QrCodeDetails(qrImageUrl: 'https://example.com/qr101.png'),
        pdfUrl: 'https://example.com/biodata101.pdf',
        privacySettings: PrivacySettings(isFindmatch: true),
        profile: CoreProfile(
          fullName: 'Ananya Agarwal',
          gender: 'Female',
          city: 'Mumbai',
        ),
      );
    });

    testWidgets(
      'ProfileViewScreen renders QR Code and Biodata PDF buttons in header',
      (tester) async {
        tester.view.physicalSize = const Size(1200, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        Map<String, dynamic>? qrRouteExtra;

        final router = GoRouter(
          initialLocation: '/profile_view',
          routes: [
            GoRoute(
              path: '/profile_view',
              builder: (context, state) =>
                  const ProfileViewScreen(userId: 'member-101'),
            ),
            GoRoute(
              path: '/my_qr_code',
              builder: (context, state) {
                qrRouteExtra = state.extra as Map<String, dynamic>?;
                return Scaffold(
                  body: Text('QR for: ${qrRouteExtra?['userName']}'),
                );
              },
            ),
          ],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              memberProfileProvider(
                'member-101',
              ).overrideWith((ref) async => dummyMemberProfile),
              blockStatusProvider(
                'member-101',
              ).overrideWith((ref) async => false),
            ],
            child: MaterialApp.router(routerConfig: router),
          ),
        );

        await tester.pumpAndSettle();

        // Check member name is rendered
        expect(find.text('Ananya Agarwal'), findsOneWidget);

        // Verify QR Code button exists
        final qrBtn = find.byTooltip('View QR Code');
        expect(qrBtn, findsOneWidget);

        // Verify Biodata PDF button exists
        final pdfIcon = find.byIcon(Icons.picture_as_pdf_rounded);
        expect(pdfIcon, findsOneWidget);

        // Tap QR Code button and verify navigation
        await tester.tap(qrBtn);
        await tester.pumpAndSettle();

        expect(qrRouteExtra?['userId'], 'member-101');
        expect(qrRouteExtra?['userName'], 'Ananya Agarwal');
        expect(qrRouteExtra?['qrImageUrl'], 'https://example.com/qr101.png');
        expect(find.text('QR for: Ananya Agarwal'), findsOneWidget);
      },
    );

    testWidgets(
      'ProfileViewScreen hides full family tree when no family details exist',
      (tester) async {
        final router = GoRouter(
          initialLocation: '/profile_view',
          routes: [
            GoRoute(
              path: '/profile_view',
              builder: (context, state) =>
                  const ProfileViewScreen(userId: 'member-101'),
            ),
          ],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              memberProfileProvider(
                'member-101',
              ).overrideWith((ref) async => dummyMemberProfile),
              blockStatusProvider(
                'member-101',
              ).overrideWith((ref) async => false),
            ],
            child: MaterialApp.router(routerConfig: router),
          ),
        );

        await tester.pumpAndSettle();
        await tester.tap(find.text('Family'));
        await tester.pumpAndSettle();

        expect(find.text('No family details available'), findsOneWidget);
        expect(find.text('View Full Family Tree'), findsNothing);
      },
    );

    testWidgets(
      'ProfileViewScreen hides social links section when no links exist',
      (tester) async {
        final router = GoRouter(
          initialLocation: '/profile_view',
          routes: [
            GoRoute(
              path: '/profile_view',
              builder: (context, state) =>
                  const ProfileViewScreen(userId: 'member-101'),
            ),
          ],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              memberProfileProvider(
                'member-101',
              ).overrideWith((ref) async => dummyMemberProfile),
              blockStatusProvider(
                'member-101',
              ).overrideWith((ref) async => false),
            ],
            child: MaterialApp.router(routerConfig: router),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Social Links'), findsNothing);
      },
    );

    testWidgets(
      'ProfileViewScreen shows the social link label for an existing link',
      (tester) async {
        final profileWithLinkedin = dummyMemberProfile.copyWith(
          profile: dummyMemberProfile.profile!.copyWith(
            linkedin: 'https://linkedin.com/in/ananya',
          ),
        );
        final router = GoRouter(
          initialLocation: '/profile_view',
          routes: [
            GoRoute(
              path: '/profile_view',
              builder: (context, state) =>
                  const ProfileViewScreen(userId: 'member-101'),
            ),
          ],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              memberProfileProvider(
                'member-101',
              ).overrideWith((ref) async => profileWithLinkedin),
              blockStatusProvider(
                'member-101',
              ).overrideWith((ref) async => false),
            ],
            child: MaterialApp.router(routerConfig: router),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Social Links'), findsOneWidget);
        expect(find.text('LinkedIn'), findsOneWidget);
        expect(find.text('Hidden by Privacy Settings'), findsNothing);
      },
    );
  });
}
