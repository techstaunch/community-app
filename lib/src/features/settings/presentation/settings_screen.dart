import 'package:flutter/material.dart';
import 'package:community_connect/src/utils/app_messenger.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/api_endpoints.dart';
import '../../authentication/data/auth_provider.dart';
import '../../translation/application/translation_provider.dart';
import '../../../common_widgets/translated_text.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: TranslatedText(
          'Settings',
          style: TextStyle(color: AppColors.indigo, fontSize: 18.sp,),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          TranslatedText(
            'Account',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.indigo,
            ),
          ),
          SizedBox(height: 8.h),
          _buildSettingsTile(
            Icons.person_outline,
            'Personal Information',
            () => context.go('/my_profile'),
          ),
          _buildSettingsTile(
            Icons.qr_code_2,
            'My Access QR Code',
            () => context.push('/my_qr_code'),
          ),
          _buildSettingsTile(
            Icons.language,
            'App Language',
            () => _showLanguageBottomSheet(context, ref),
          ),
          // _buildSettingsTile(
          //   Icons.groups,
          //   'Communities',
          //   () => context.push('/communities'),
          // ),
          // _buildSettingsTile(
          //   Icons.notifications_none,
          //   'Notification Preferences',
          //   () {},
          // ),
          _buildSettingsTile(Icons.security, 'Privacy Controls', () {
            context.go(
              '/my_profile?scrollToken=${DateTime.now().millisecondsSinceEpoch}',
            );
          }),
          _buildSettingsTile(
            Icons.block_outlined,
            'Blocked Users',
            () => context.push('/blocked_users'),
          ),

          SizedBox(height: 24.h),
          TranslatedText(
            'About & Legal',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.indigo,
            ),
          ),
          SizedBox(height: 8.h),
          _buildSettingsTile(
            Icons.description_outlined,
            'Terms of Service',
            () async {
              final url = Uri.parse(ApiEndpoints.termsOfServiceUrl);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
          ),
          _buildSettingsTile(
            Icons.privacy_tip_outlined,
            'Privacy Policy',
            () async {
              final url = Uri.parse(ApiEndpoints.privacyPolicyUrl);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
          ),

          SizedBox(height: 24.h),
          TranslatedText(
            'Danger Zone',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.red,
            ),
          ),
          SizedBox(height: 8.h),
          _buildSettingsTile(Icons.logout, 'Log Out', () {
            _showLogoutDialog(context, ref);
          }, color: AppColors.textDark),
          _buildSettingsTile(Icons.delete_forever, 'Delete Account', () {
            _showDeleteDialog(context, ref);
          }, color: AppColors.red),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color color = AppColors.textDark,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: const BorderSide(color: AppColors.border),
        ),
        clipBehavior: Clip.hardEdge,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          leading: Icon(icon, color: color, size: 22.sp),
          title: TranslatedText(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: AppColors.textMuted,
            size: 20.sp,
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        contentPadding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 20.h),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60.r,
              height: 60.r,
              decoration: BoxDecoration(
                color: AppColors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout_rounded,
                size: 28.sp,
                color: AppColors.red,
              ),
            ),
            SizedBox(height: 18.h),
            TranslatedText(
              'Log Out',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 8.h),
            TranslatedText(
              'Are you sure you want to log out of your account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textMid,
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textDark,
                      side: const BorderSide(color: AppColors.border),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: TranslatedText(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ref.read(authControllerProvider.notifier).logout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: TranslatedText(
                      'Log Out',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _DeleteAccountDialog(ref: ref),
    );
  }

  void _showLanguageBottomSheet(BuildContext screenContext, WidgetRef ref) {
    final currentLang = ref.read(targetLanguageProvider);

    final languages = [
      {'name': 'English', 'lang': TranslateLanguage.english},
      {'name': 'हिंदी (Hindi)', 'lang': TranslateLanguage.hindi},
      {'name': 'मराठी (Marathi)', 'lang': TranslateLanguage.marathi},
      {'name': 'ગુજરાતી (Gujarati)', 'lang': TranslateLanguage.gujarati},
      {'name': 'বাংলা (Bengali)', 'lang': TranslateLanguage.bengali},
      {'name': 'தமிழ் (Tamil)', 'lang': TranslateLanguage.tamil},
      {'name': 'తెలుగు (Telugu)', 'lang': TranslateLanguage.telugu},
      {'name': 'ಕನ್ನಡ (Kannada)', 'lang': TranslateLanguage.kannada},
    ];

    showModalBottomSheet(
      context: screenContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) {
        return Container(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select App Language',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.indigo,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Selecting a new language may take a few seconds to download the language model (~30MB).',
                style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: languages.length,
                  itemBuilder: (listContext, index) {
                    final item = languages[index];
                    final name = item['name'] as String;
                    final lang = item['lang'] as TranslateLanguage;
                    final isSelected = lang == currentLang;

                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                      title: Text(
                        name,
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: AppColors.textDark,
                          fontSize: 15.sp,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check,
                              color: AppColors.orange,
                              size: 20.sp,
                            )
                          : null,
                      onTap: () async {
                        Navigator.pop(sheetContext); // Close bottom sheet

                        await Future.delayed(const Duration(milliseconds: 100));
                        if (!screenContext.mounted) return;

                        // Show the progress dialog
                        showDialog(
                          context: screenContext,
                          barrierDismissible: false,
                          builder: (_) => _LanguageDownloadDialog(
                            lang: lang,
                            langName: name,
                          ),
                        ).then((result) {
                          if (result == false && screenContext.mounted) {
                            AppMessenger.showError(
                              'We couldn\'t download the language model. Please check your internet and try again.',
                            );
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Confirmation dialog for account deletion with loading state.
class _DeleteAccountDialog extends HookWidget {
  final WidgetRef ref;

  const _DeleteAccountDialog({required this.ref});

  @override
  Widget build(BuildContext context) {
    final isDeleting = useState(false);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      contentPadding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 20.h),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60.r,
            height: 60.r,
            decoration: BoxDecoration(
              color: AppColors.red.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.delete_forever_rounded,
              size: 28.sp,
              color: AppColors.red,
            ),
          ),
          SizedBox(height: 18.h),
          TranslatedText(
            'Delete Account?',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          TranslatedText(
            'This action is irreversible. All your personal data, family tree links, and business information will be permanently deleted.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textMid,
              height: 1.4,
            ),
          ),
          SizedBox(height: 24.h),
          if (isDeleting.value)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.red,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  TranslatedText(
                    'Deleting account...',
                    style: TextStyle(fontSize: 14.sp, color: AppColors.textMid),
                  ),
                ],
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textDark,
                      side: const BorderSide(color: AppColors.border),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: TranslatedText(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      isDeleting.value = true;
                      try {
                        await ref
                            .read(authControllerProvider.notifier)
                            .deleteAccount();
                        // GoRouter auto-redirects to /welcome on AuthState.unauthenticated
                      } catch (e) {
                        isDeleting.value = false;
                        if (context.mounted) {
                          Navigator.pop(context);
                          AppMessenger.showError(
                            'Failed to delete account. Please try again.',
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: TranslatedText(
                      'Delete',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// A beautiful step-based progress dialog for language model download.
class _LanguageDownloadDialog extends HookConsumerWidget {
  final TranslateLanguage lang;
  final String langName;

  const _LanguageDownloadDialog({required this.lang, required this.langName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = useState<int>(0);
    final totalSteps = useState<int>(4);
    final statusMessage = useState<String>('Preparing...');
    final isDone = useState<bool>(false);
    final hasError = useState<bool>(false);

    useEffect(() {
      Future<void> startDownload() async {
        try {
          await ref
              .read(targetLanguageProvider.notifier)
              .setLanguage(
                lang,
                onProgress: (step, total, message) {
                  if (context.mounted) {
                    currentStep.value = step;
                    totalSteps.value = total;
                    statusMessage.value = message;
                  }
                },
              );

          if (context.mounted) {
            isDone.value = true;
            currentStep.value = totalSteps.value;
            statusMessage.value = 'Language set to $langName ✓';

            await Future.delayed(const Duration(milliseconds: 800));
            if (context.mounted) {
              Navigator.of(context, rootNavigator: true).pop(true);
            }
          }
        } catch (e) {
          if (context.mounted) {
            hasError.value = true;
            String errorMsg = e.toString();
            if (errorMsg.contains('Exception: ')) {
              errorMsg = errorMsg.split('Exception: ').last;
            }
            if (errorMsg.endsWith(')')) {
              errorMsg = errorMsg.substring(0, errorMsg.length - 1);
            }
            statusMessage.value = errorMsg.trim();

            await Future.delayed(const Duration(seconds: 2));
            if (context.mounted) {
              Navigator.of(context, rootNavigator: true).pop(false);
            }
          }
        }
      }

      startDownload();
      return null;
    }, []);

    final progress = totalSteps.value > 0
        ? currentStep.value / totalSteps.value
        : 0.0;

    return PopScope(
      canPop: false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        contentPadding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 20.h),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header icon
            Container(
              width: 56.r,
              height: 56.r,
              decoration: BoxDecoration(
                color: hasError.value
                    ? AppColors.red.withValues(alpha: 0.1)
                    : isDone.value
                    ? Colors.green.withValues(alpha: 0.1)
                    : AppColors.orange.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                hasError.value
                    ? Icons.error_outline
                    : isDone.value
                    ? Icons.check_circle_outline
                    : Icons.translate,
                size: 28.sp,
                color: hasError.value
                    ? AppColors.red
                    : isDone.value
                    ? Colors.green
                    : AppColors.orange,
              ),
            ),
            SizedBox(height: 16.h),

            // Title
            Text(
              hasError.value
                  ? 'Download Failed'
                  : isDone.value
                  ? 'Done!'
                  : 'Setting Up $langName',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 16.h),

            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: hasError.value ? 1.0 : value,
                    minHeight: 8.h,
                    backgroundColor: AppColors.border,
                    color: hasError.value
                        ? AppColors.red
                        : isDone.value
                        ? Colors.green
                        : AppColors.orange,
                  );
                },
              ),
            ),
            SizedBox(height: 8.h),

            // Step counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hasError.value
                      ? 'Error'
                      : 'Step ${currentStep.value} of ${totalSteps.value}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: hasError.value ? AppColors.red : AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: hasError.value ? AppColors.red : AppColors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Status message
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: (hasError.value ? AppColors.red : AppColors.indigo)
                    .withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  if (!isDone.value && !hasError.value)
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: SizedBox(
                        width: 14.r,
                        height: 14.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                  if (isDone.value)
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Icon(
                        Icons.check,
                        size: 14.sp,
                        color: Colors.green,
                      ),
                    ),
                  if (hasError.value)
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Icon(
                        Icons.close,
                        size: 14.sp,
                        color: AppColors.red,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      statusMessage.value,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: hasError.value
                            ? AppColors.red
                            : AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
