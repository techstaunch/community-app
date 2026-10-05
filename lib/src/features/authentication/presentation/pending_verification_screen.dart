import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';

class PendingVerificationScreen extends StatelessWidget {
  const PendingVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100.r,
                height: 100.r,
                decoration: BoxDecoration(
                  color: AppColors.orangeLight,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.orange, width: 2),
                ),
                child: Center(
                  child: Icon(Icons.hourglass_top_rounded, color: AppColors.orange, size: 44.r),
                ),
              ),
              SizedBox(height: 24.h),
              TranslatedText(
                'Profile Under Review',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.indigo,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              TranslatedText(
                'Your profile has been submitted and is waiting for administrator approval to ensure community trust. You will be notified once verified.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textMid, height: 1.5, fontSize: 14.sp),
              ),
              SizedBox(height: 32.h),
              OutlinedButton(
                onPressed: () => context.go('/my_qr_code'), // Proceed to QR code screen
                child: const TranslatedText('Proceed (Admin Mock)'),
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: () => context.go('/login'),
                child: TranslatedText('Back to Login', style: TextStyle(color: AppColors.textMuted, fontSize: 14.sp)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
