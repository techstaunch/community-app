import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'routing/app_router.dart';
import 'theme/app_theme.dart';
import 'features/authentication/data/auth_provider.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next != AuthState.loading) {
        FlutterNativeSplash.remove();
      }
    });

    final goRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'CommunityConnect',
      theme: AppTheme.lightTheme,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
