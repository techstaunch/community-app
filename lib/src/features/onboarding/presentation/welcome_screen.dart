import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/responsive_ext.dart';
import '../../../theme/app_theme.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import 'package:community_connect/src/common_widgets/line_grid_animation.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
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
                const Positioned.fill(child: LineGridAnimation(opacity: 0.08)),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80.r,
                        height: 80.r,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(22.r),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: Image.asset(
                            'assets/images/app_logo.png',
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.low,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      TranslatedText(
                        'Parichay',
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      TranslatedText(
                        'Your Community, Connected',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.75),
                          letterSpacing: 1.1,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 50.h,
                  left: 40.w,
                  right: 40.w,
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
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                        ),
                        child: TranslatedText(
                          'Get Started ',
                          style: TextStyle(color: Colors.white, fontSize: 15.sp),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      TranslatedText(
                        'Marwadi Samaj Community',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 11.sp,
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
