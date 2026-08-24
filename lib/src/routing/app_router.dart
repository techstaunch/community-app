import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/onboarding/presentation/splash_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/authentication/presentation/login_screen.dart';
import '../features/authentication/presentation/otp_screen.dart';
import '../features/authentication/presentation/register_screen.dart';
import '../features/authentication/presentation/pending_verification_screen.dart';
import '../features/authentication/data/auth_provider.dart';

import '../features/main_navigation/presentation/main_scaffold.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/search/presentation/search_screen.dart';
import '../features/search/presentation/biodata_screen.dart';
import '../features/family_tree/presentation/family_tree_screen.dart';
import '../features/family_tree/presentation/add_family_screen.dart';
import '../features/profile/presentation/my_profile_screen.dart';
import '../features/profile/presentation/profile_view_screen.dart';
import '../features/profile/presentation/work_profile_screen.dart';
import '../features/profile/presentation/my_qr_code_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/notifications/presentation/notifications_screen.dart';
import '../features/community/presentation/communities_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final shellNavigatorSearchKey = GlobalKey<NavigatorState>(debugLabel: 'shellSearch');
final shellNavigatorFamilyKey = GlobalKey<NavigatorState>(debugLabel: 'shellFamily');
final shellNavigatorProfileKey = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
final shellNavigatorSettingsKey = GlobalKey<NavigatorState>(debugLabel: 'shellSettings');

final goRouterProvider = Provider<GoRouter>((ref) {
  // Use a ValueNotifier for the refreshListenable so GoRouter doesn't get recreated entirely on state changes
  final authStateListenable = ValueNotifier<AuthState>(AuthState.loading);

  ref.listen<AuthState>(
    authControllerProvider,
    (previous, next) {
      authStateListenable.value = next;
    },
  );

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: authStateListenable,
    redirect: (context, state) {
      // Read the current state dynamically inside the redirect
      final authState = ref.read(authControllerProvider);
      
      final isAuthRoute = state.matchedLocation == '/login' || 
                          state.matchedLocation == '/otp' || 
                          state.matchedLocation == '/onboarding1' ||
                          state.matchedLocation == '/register';
      final isSplash = state.matchedLocation == '/';

      if (authState == AuthState.loading) {
        return isSplash ? null : '/'; // Show splash while loading
      }

      if (authState == AuthState.unauthenticated) {
        if (!isAuthRoute && !isSplash) {
          return '/onboarding1'; // Go to onboarding if trying to access secure routes
        }
      }

      if (authState == AuthState.verified) {
        if (isAuthRoute || isSplash) {
          return '/home'; // Redirect authenticated users to home
        }
      }

      if (authState == AuthState.onboarding) {
        if (state.matchedLocation != '/register') {
          return '/register';
        }
      }

      if (authState == AuthState.pendingVerification) {
        if (state.matchedLocation != '/otp') {
          return '/otp';
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding1',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/pending_verification',
        builder: (context, state) => const PendingVerificationScreen(),
      ),
      GoRoute(
        path: '/edit_profile',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const RegisterScreen(isEditing: true),
      ),
      GoRoute(
        path: '/my_qr_code',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const MyQrCodeScreen(),
      ),
      GoRoute(
        path: '/notifications',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/biodata',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const BiodataScreen(),
      ),
      GoRoute(
        path: '/profile_view',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ProfileViewScreen(),
      ),
      GoRoute(
        path: '/work_profile',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const WorkProfileScreen(),
      ),
      GoRoute(
        path: '/add_family',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const AddFamilyScreen(),
      ),
      GoRoute(
        path: '/communities',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const CommunitiesScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorSearchKey,
            routes: [
              GoRoute(
                path: '/search',
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorFamilyKey,
            routes: [
              GoRoute(
                path: '/family_tree',
                builder: (context, state) => const FamilyTreeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: '/my_profile',
                builder: (context, state) => const MyProfileScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: shellNavigatorSettingsKey,
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
