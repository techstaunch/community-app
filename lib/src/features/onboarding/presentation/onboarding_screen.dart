import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../theme/app_theme.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final currentPage = useState(0);

    final pages = [
      _OnboardPageData(
        title: 'Know Your Roots',
        description:
            'Map your complete family tree across generations. Add ancestors, siblings, in-laws and connect to their profiles.',
        emojiArt: '👨‍👩‍👧‍👦',
      ),
      _OnboardPageData(
        title: 'Find & Connect',
        description:
            'Search members by name, gotra, or profession. Exchange biodata for marriage alliances within your samaj.',
        emojiArt: '🤝',
      ),
      _OnboardPageData(
        title: 'Grow Together',
        description:
            'Discover businesses and professionals within your samaj. Network for career and business opportunities.',
        emojiArt: '💼',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) => currentPage.value = index,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                final page = pages[index];
                return Column(
                  children: [
                    _AnimatedHeroSection(emojiArt: page.emojiArt),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(36.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                              page.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(color: AppColors.indigo),
                            ),
                            const SizedBox(height: 16),
                            TranslatedText(
                              page.description,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(height: 1.6),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  child: const TranslatedText(
                    'Skip',
                    style: TextStyle(color: AppColors.textMuted),
                  ),
                ),
                Row(
                  children: List.generate(
                    pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: currentPage.value == index ? 20 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: currentPage.value == index
                            ? AppColors.orange
                            : AppColors.border,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (currentPage.value < pages.length - 1) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      context.go('/login');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: TranslatedText(
                    currentPage.value == pages.length - 1
                        ? 'Get Started '
                        : 'Next ',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Dedicated StatefulWidget for the animated hero section.
/// Using a proper StatefulWidget with TickerProviderStateMixin guarantees
/// the animation controller lifecycle is managed correctly on real devices
/// in both debug and release builds.
class _AnimatedHeroSection extends StatefulWidget {
  final String emojiArt;
  const _AnimatedHeroSection({required this.emojiArt});

  @override
  State<_AnimatedHeroSection> createState() => _AnimatedHeroSectionState();
}

class _AnimatedHeroSectionState extends State<_AnimatedHeroSection>
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final v = _controller.value;
        return Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // Move the gradient start/end points significantly to create a "sweeping" or "breathing" effect
              begin: Alignment(-1.5 + v, -1.0),
              end: Alignment(1.5 - v, 1.0),
              colors: [
                // Interpolate all the way to 1.0, and mix in a hint of gold/indigo for a dynamic sheen
                Color.lerp(AppColors.orange, AppColors.orangeDark, v)!,
                Color.lerp(AppColors.orangeDark, AppColors.orange, v)!,
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          child: Stack(
            children: [
              // Main emoji with gentle float + subtle scale pulse
              Center(
                child: Transform.translate(
                  offset: Offset(0, -12 + (v * 24)),
                  child: Transform.scale(
                    scale: 1.0 + (math.sin(v * math.pi) * 0.08),
                    child: Text(
                      widget.emojiArt,
                      style: const TextStyle(fontSize: 80),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OnboardPageData {
  final String title;
  final String description;
  final String emojiArt;

  _OnboardPageData({
    required this.title,
    required this.description,
    required this.emojiArt,
  });
}
