import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../data/auth_provider.dart';

class OtpScreen extends HookConsumerWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final authNotifier = ref.read(authControllerProvider.notifier);
    
    // Manage 6 text controllers for the OTP input
    final controllers = List.generate(6, (index) => useTextEditingController());
    final focusNodes = List.generate(6, (index) => useFocusNode());

    ref.listen(authControllerProvider, (previous, next) {
      if (next == AuthState.onboarding) {
        // If it's a new user, they go to profile setup / registration
        context.pushReplacement('/register');
      } else if (next == AuthState.verified) {
        // If already registered, go to home
        context.go('/home');
      } else if (next == AuthState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid OTP. Please try again.')),
        );
      }
    });

    final currentNumber = authNotifier.currentMobileNumber ?? '';

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 44),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.orange, AppColors.orangeDark],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackButton(
                  dark: false,
                ),
                const SizedBox(height: 16),
                TranslatedText(
                  'Verify OTP',
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                TranslatedText(
                  'Code sent to $currentNumber',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      6,
                      (index) => SizedBox(
                        width: 44,
                        height: 52,
                        child: TextField(
                          controller: controllers[index],
                          focusNode: focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.border,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              focusNodes[index + 1].requestFocus();
                            } else if (value.isEmpty && index > 0) {
                              focusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(text: 'Resend OTP in '),
                        TextSpan(
                          text: '28 sec',
                          style: TextStyle(
                            color: AppColors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  authState == AuthState.loading
                      ? const Center(child: CircularProgressIndicator())
                      : PrimaryButton(
                          text: 'Verify',
                          onPressed: () {
                            final code = controllers.map((c) => c.text).join();
                            if (code.length == 6 && currentNumber.isNotEmpty) {
                              authNotifier.verifyOtp(currentNumber, code);
                            }
                          },
                        ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const TranslatedText(
                      'Edit phone number',
                      style: TextStyle(color: AppColors.textMuted),
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
