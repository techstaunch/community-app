import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import 'package:community_connect/src/utils/app_messenger.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import '../data/auth_provider.dart';

class OtpScreen extends HookConsumerWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final authNotifier = ref.read(authControllerProvider.notifier);
    
    // Manage single text controller for the OTP input
    final otpController = useTextEditingController();

    // Timer state
    final timerValue = useState(30);
    final canResend = useState(false);

    useEffect(() {
      if (canResend.value) return null;
      
      final timer = Timer.periodic(const Duration(seconds: 1), (t) {
        if (timerValue.value > 0) {
          timerValue.value--;
        } else {
          canResend.value = true;
          t.cancel();
        }
      });
      return timer.cancel;
    }, [canResend.value]);

    ref.listen(authControllerProvider, (previous, next) {
      if (next == AuthState.onboarding) {
        // If it's a new user, they go to profile setup / registration
        context.pushReplacement('/register');
      } else if (next == AuthState.verified) {
        // If already registered, go to home
        context.go('/home');
      }
    });

    final currentNumber = authNotifier.currentMobileNumber ?? '';

    void handleBackToLogin() {
      authNotifier.resetToLogin();
      context.go('/login');
    }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(
                      dark: false,
                      onPressed: handleBackToLogin,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        'assets/images/app_logo.png',
                        height: 40.r,
                        width: 40.r,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                TranslatedText(
                  'Verify OTP',
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(color: Colors.white),
                ),
                SizedBox(height: 4.h),
                TranslatedText(
                  'Code sent to $currentNumber',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.h),
                  Pinput(
                    length: 6,
                    controller: otpController,
                    defaultPinTheme: PinTheme(
                      width: 44.w,
                      height: 52.h,
                      textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border, width: 2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 44.w,
                      height: 52.h,
                      textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.orange, width: 2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onCompleted: (pin) async {
                      if (pin.length == 6 && currentNumber.isNotEmpty) {
                        try {
                          await authNotifier.verifyOtp(currentNumber, pin);
                        } catch (e) {
                          AppMessenger.showException(e, fallbackMessage: 'That OTP doesn\'t seem quite right. Please try again.');
                        }
                      }
                    },
                  ),
                  SizedBox(height: 24.h),
                  canResend.value
                      ? Center(
                          child: TextButton(
                            onPressed: () async {
                              if (currentNumber.isNotEmpty) {
                                try {
                                  await authNotifier.requestOtp(currentNumber);
                                  canResend.value = false;
                                  timerValue.value = 30;
                                } catch (e) {
                                  AppMessenger.showException(e, fallbackMessage: 'We couldn\'t resend the OTP right now.');
                                }
                              }
                            },
                            child: TranslatedText(
                              'Resend OTP',
                              style: TextStyle(
                                color: AppColors.indigo,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        )
                      : Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 13.sp,
                            ),
                            children: [
                              const TextSpan(text: 'Resend OTP in '),
                              TextSpan(
                                text: '${timerValue.value} sec',
                                style: const TextStyle(
                                  color: AppColors.indigo,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(height: 24.h),
                  authState == AuthState.loading
                      ? const Center(child: CircularProgressIndicator())
                      : PrimaryButton(
                          text: 'Verify',
                          onPressed: () async {
                            final code = otpController.text;
                            if (code.length == 6 && currentNumber.isNotEmpty) {
                              try {
                                await authNotifier.verifyOtp(currentNumber, code);
                              } catch (e) {
                                AppMessenger.showException(e, fallbackMessage: 'That OTP doesn\'t seem quite right. Please try again.');
                              }
                            }
                          },
                        ),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: handleBackToLogin,
                    child: TranslatedText(
                      'Edit phone number',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
