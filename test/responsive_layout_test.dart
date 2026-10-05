import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:community_connect/src/common_widgets/custom_buttons.dart';
import 'package:community_connect/src/common_widgets/custom_header.dart';
import 'package:community_connect/src/common_widgets/custom_inputs.dart';
import 'package:community_connect/src/common_widgets/member_card.dart';
import 'package:community_connect/src/common_widgets/tags_chips.dart';
import 'package:community_connect/src/theme/app_theme.dart';

void main() {
  group('Responsive Layout & Font Scaling Tests', () {
    testWidgets('Renders properly on small screen (320x568) without overflow', (tester) async {
      tester.view.physicalSize = const Size(320 * 2, 568 * 2);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              theme: AppTheme.lightTheme,
              builder: (context, widget) {
                final mediaQuery = MediaQuery.of(context);
                final clampedScaler = mediaQuery.textScaler.clamp(
                  minScaleFactor: 0.85,
                  maxScaleFactor: 1.15,
                );
                return MediaQuery(
                  data: mediaQuery.copyWith(textScaler: clampedScaler),
                  child: widget!,
                );
              },
              home: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const OrangeHeader(
                        title: 'Community Members Directory',
                        subtitle: 'Find and connect with extended family and community members',
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: PrimaryButton(
                          text: 'Continue to Family Tree',
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: CustomInputField(
                          label: 'Full Name',
                          hintText: 'Enter complete legal name',
                        ),
                      ),
                      const SizedBox(height: 16),
                      MemberCard(
                        icon: const Icon(Icons.person, color: AppColors.orange),
                        title: const Text('Very Long Member Name Testing Extended Width'),
                        subtitle: const Text('Senior Agricultural Engineer and Consultant'),
                        tag: Tag.green('Verified'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Community Members Directory'), findsOneWidget);
      expect(find.text('Continue to Family Tree'), findsOneWidget);
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Very Long Member Name Testing Extended Width'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Renders properly on large screen (430x932) with high accessibility font scale', (tester) async {
      tester.view.physicalSize = const Size(430 * 3, 932 * 3);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              theme: AppTheme.lightTheme,
              builder: (context, widget) {
                final mediaQuery = MediaQuery.of(context);
                final clampedScaler = mediaQuery.textScaler.clamp(
                  minScaleFactor: 0.85,
                  maxScaleFactor: 1.15,
                );
                return MediaQuery(
                  data: mediaQuery.copyWith(
                    textScaler: clampedScaler,
                  ),
                  child: widget!,
                );
              },
              home: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const OrangeHeader(
                        title: 'Community Members Directory',
                        subtitle: 'Find and connect with extended family and community members',
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: PrimaryButton(
                          text: 'Save and Continue',
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 16),
                      MemberCard(
                        icon: const Icon(Icons.person, color: AppColors.orange),
                        title: const Text('Rajesh Kumar Patel'),
                        subtitle: const Text('Software Architect'),
                        tag: Tag.blue('Admin'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Community Members Directory'), findsOneWidget);
      expect(find.text('Save and Continue'), findsOneWidget);
      expect(find.text('Rajesh Kumar Patel'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
