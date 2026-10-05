import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/translated_text.dart';
import '../../../common_widgets/slide_to_continue_button.dart';
import '../../exports/data/export_provider.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';

class MyQrCodeScreen extends HookConsumerWidget {
  final String? userId;
  final String? userName;
  final String? qrImageUrl;

  const MyQrCodeScreen({
    super.key,
    this.userId,
    this.userName,
    this.qrImageUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOtherMember = userId != null && userId!.isNotEmpty;
    final displayName = (userName != null && userName!.trim().isNotEmpty)
        ? userName!.trim()
        : 'Community Member';

    final cachedQr = (qrImageUrl != null && qrImageUrl!.isNotEmpty)
        ? qrImageUrl
        : ref.read(exportControllerProvider.notifier).getCachedQrCode(userId);

    useEffect(() {
      if (qrImageUrl != null && qrImageUrl!.isNotEmpty) {
        ref.read(exportControllerProvider.notifier).setCachedQrCode(userId, qrImageUrl!);
      }
      return null;
    }, [userId, qrImageUrl]);

    // Fetch QR Code via API only if not already cached
    final qrFuture = useMemoized(
      () async {
        if (cachedQr != null && cachedQr.isNotEmpty) {
          return cachedQr;
        }
        await Future.microtask(() {}); // Wait for build to finish
        return ref.read(exportControllerProvider.notifier).generateProfileQrCode(userId);
      },
      [userId, cachedQr],
    );
    final qrSnapshot = useFuture(qrFuture, initialData: cachedQr);

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: TranslatedText(
          isOtherMember ? '$displayName\'s QR' : 'My Access QR',
          style: const TextStyle(color: AppColors.textDark),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(28.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.indigo.withValues(alpha: 0.08),
                        blurRadius: 20.r,
                        offset: Offset(0, 10.h),
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
                            width: 50.r,
                            height: 50.r,
                            decoration: const BoxDecoration(
                              color: AppColors.orangeLight,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.person_rounded,
                              color: AppColors.orange,
                              size: 28.sp,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Flexible(
                            child: TranslatedText(
                              displayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 28.h),

                      // QR Code
                      Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppColors.border, width: 2),
                        ),
                        child: (qrSnapshot.hasData &&
                                qrSnapshot.data != null &&
                                qrSnapshot.data!.isNotEmpty)
                            ? _buildQrImage(qrSnapshot.data!)
                            : qrSnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? SizedBox(
                                    width: 200.r,
                                    height: 200.r,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : SizedBox(
                                    width: 200.r,
                                    height: 200.r,
                                    child: Center(
                                      child: Icon(
                                        Icons.qr_code,
                                        size: 64.sp,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ),
                      ),

                      SizedBox(height: 28.h),

                      TranslatedText(
                        'Show this QR code at community events to verify your membership.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textMuted,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Status Badge
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, color: Colors.green, size: 18.sp),
                        SizedBox(width: 8.w),
                        TranslatedText(
                          'Verified & Approved',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                if (!isOtherMember) ...[
                  SizedBox(height: 20.h),
                  SlideToContinueButton(
                    onSlideCompleted: () {
                      context.go('/home');
                    },
                    text: 'Slide to proceed to Home >>',
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQrImage(String qrData) {
    if (qrData.startsWith('data:image')) {
      try {
        final base64Str = qrData.split(',').last;
        final bytes = base64Decode(base64Str);
        return Image.memory(
          bytes,
          width: 200.r,
          height: 200.r,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => SizedBox(
            width: 200.r,
            height: 200.r,
            child: Center(
              child: Icon(
                Icons.qr_code,
                size: 64.sp,
                color: AppColors.textMuted,
              ),
            ),
          ),
        );
      } catch (_) {}
    }

    return Image.network(
      qrData,
      width: 200.r,
      height: 200.r,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => SizedBox(
        width: 200.r,
        height: 200.r,
        child: Center(
          child: Icon(
            Icons.qr_code,
            size: 64.sp,
            color: AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
