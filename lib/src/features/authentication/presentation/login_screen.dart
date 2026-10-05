import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/api_endpoints.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import 'package:community_connect/src/utils/app_messenger.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import '../data/auth_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends HookConsumerWidget {
  final bool isLogin;
  const LoginScreen({super.key, this.isLogin = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final authState = ref.watch(authControllerProvider);

    final termsOfServiceRecognizer = useMemoized(
      () => TapGestureRecognizer()
        ..onTap = () async {
          final url = Uri.parse(ApiEndpoints.termsOfServiceUrl);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        },
    );

    final privacyPolicyRecognizer = useMemoized(
      () => TapGestureRecognizer()
        ..onTap = () async {
          final url = Uri.parse(ApiEndpoints.privacyPolicyUrl);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        },
    );

    useEffect(() {
      return () {
        termsOfServiceRecognizer.dispose();
        privacyPolicyRecognizer.dispose();
      };
    }, [termsOfServiceRecognizer, privacyPolicyRecognizer]);

    ref.listen(authControllerProvider, (previous, next) {
      if (next == AuthState.pendingVerification) {
        context.push('/otp');
      }
    });

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 44.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.orange, AppColors.orangeDark],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36.r),
                bottomRight: Radius.circular(36.r),
              ),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    height: 54.r,
                    width: 54.r,
                  ),
                ),
                SizedBox(height: 16.h),
                TranslatedText(
                  isLogin ? 'Welcome Back' : 'Welcome',
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(color: Colors.white),
                ),
                SizedBox(height: 4.h),
                TranslatedText(
                  isLogin ? 'Sign in to Marwadi Samaj Community' : 'Create a new account',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 16.h),
                  TranslatedText(
                    'Phone Number',
                    style: TextStyle(
                      color: AppColors.indigo,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: AppColors.border,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: TranslatedText(
                          '+91',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            hintText: 'Enter phone number',
                            counterText: '', // Hides the 0/10 text below the field
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  TranslatedText(
                    "We'll send you a 6-digit OTP to verify",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12.sp),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: authState == AuthState.loading
                        ? null
                        : () async {
                            final number = phoneController.text.trim();
                            if (number.isEmpty) {
                              AppMessenger.showError('Please enter your phone number.');
                              return;
                            }
                            if (number.length != 10 || !RegExp(r'^[6-9]\d{9}$').hasMatch(number)) {
                              AppMessenger.showError('Please enter a valid 10-digit mobile number starting with 6, 7, 8, or 9.');
                              return;
                            }
                            // Include country code assuming the user typed 10 digits
                            final formattedNumber = '+91$number';
                            try {
                              await ref.read(authControllerProvider.notifier).requestOtp(formattedNumber, purpose: isLogin ? 'Login' : 'Registration');
                            } catch (e) {
                              AppMessenger.showException(e, fallbackMessage: 'We couldn\'t send the OTP right now. Please try again.');
                            }
                          },
                    child: authState == AuthState.loading
                        ? SizedBox(
                            height: 20.r,
                            width: 20.r,
                            child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const TranslatedText('Send OTP '),
                  ),

                  const Spacer(),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11.sp,
                        height: 1.6,
                      ),
                      children: [
                        const TextSpan(text: 'By continuing, you agree to our\n'),
                        TextSpan(
                          text: 'Terms of Service',
                          style: const TextStyle(
                            color: AppColors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: termsOfServiceRecognizer,
                        ),
                        const TextSpan(text: ' & '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: const TextStyle(
                            color: AppColors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: privacyPolicyRecognizer,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextButton(
                    onPressed: () {
                      if (isLogin) {
                        context.push('/signup');
                      } else {
                        context.pop();
                      }
                    },
                    child: TranslatedText(
                      isLogin ? "Don't have an account? Register User" : "Already have an account? Login",
                      style: TextStyle(
                        color: AppColors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                      ],
                    ),
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
