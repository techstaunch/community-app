import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import 'package:community_connect/src/common_widgets/line_grid_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final v = _controller.value;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0 + v * 0.2, -1.0 + v * 0.2),
                end: Alignment(1.0 - v * 0.2, 1.0 - v * 0.2),
                colors: [
                  Color.lerp(AppColors.orange, AppColors.orangeDark, v * 0.5)!,
                  Color.lerp(AppColors.orangeDark, AppColors.indigo, v * 0.5)!,
                  Color.lerp(AppColors.indigo, AppColors.orange, v * 0.5)!,
                ],
              ),
            ),
        child: Stack(
          children: [
            const Positioned.fill(
              child: LineGridAnimation(opacity: 0.08),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.people_alt,
                      color: Colors.white,
                      size: 44,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TranslatedText(
                    'SamajConnect',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  TranslatedText(
                    'Your Community, Connected',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.75),
                          letterSpacing: 1.1,
                        ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 40,
              right: 40,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.go('/onboarding1');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                      elevation: 0,
                    ),
                    child: const TranslatedText(
                      'Get Started ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TranslatedText(
                    'Patil Samaj Community',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
          );
        },
      ),
    );
  }
}
