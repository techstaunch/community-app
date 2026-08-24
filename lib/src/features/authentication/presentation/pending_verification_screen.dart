import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';

class PendingVerificationScreen extends StatelessWidget {
  const PendingVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.orangeLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.orange, width: 2),
                ),
                child: const Center(
                  child: TranslatedText('⏳', style: TextStyle(fontSize: 40)),
                ),
              ),
              const SizedBox(height: 24),
              TranslatedText(
                'Profile Under Review',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.indigo,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const TranslatedText(
                'Your profile has been submitted and is waiting for administrator approval to ensure community trust. You will be notified once verified.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textMid, height: 1.5),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: () => context.go('/my_qr_code'), // Proceed to QR code screen
                child: const TranslatedText('Proceed (Admin Mock)'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.go('/login'),
                child: const TranslatedText('Back to Login', style: TextStyle(color: AppColors.textMuted)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
