import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/translated_text.dart';
import '../../../common_widgets/slide_to_continue_button.dart';
import '../../exports/data/export_provider.dart';

class MyQrCodeScreen extends HookConsumerWidget {
  const MyQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch QR Code via API
    final qrFuture = useMemoized(() => ref.read(exportControllerProvider.notifier).generateProfileQrCode());
    final qrSnapshot = useFuture(qrFuture);

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const TranslatedText('My Access QR', style: TextStyle(color: AppColors.textDark)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.indigo.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // User Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: AppColors.orangeLight,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const TranslatedText('👨', style: TextStyle(fontSize: 24)),
                        ),
                        const SizedBox(width: 16),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                              'Community Member',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // QR Code
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border, width: 2),
                      ),
                      child: qrSnapshot.connectionState == ConnectionState.waiting
                          ? const SizedBox(
                              width: 200,
                              height: 200,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : qrSnapshot.hasError || qrSnapshot.data == null
                              ? const SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                    child: Icon(Icons.qr_code, size: 64, color: AppColors.textMuted),
                                  ),
                                )
                              : Image.memory(
                                  base64Decode(qrSnapshot.data!.split(',').last),
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => const SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: Center(
                                      child: Icon(Icons.qr_code, size: 64, color: AppColors.textMuted),
                                    ),
                                  ),
                                ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    const TranslatedText(
                      'Show this QR code at community events to verify your membership.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textMuted,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Status Badge
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified, color: Colors.green, size: 18),
                      SizedBox(width: 8),
                      TranslatedText(
                        'Verified & Approved',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Slide to Continue Button
              SlideToContinueButton(
                onSlideCompleted: () {
                  context.go('/home');
                },
                text: 'Slide to proceed to Home >>',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
