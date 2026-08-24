import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import '../../../theme/app_theme.dart';
import '../../translation/application/translation_provider.dart';

import '../../../common_widgets/translated_text.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const TranslatedText('Settings', style: TextStyle(color: AppColors.textDark)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TranslatedText('Account', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.indigo)),
          const SizedBox(height: 8),
          _buildSettingsTile(Icons.person_outline, 'Personal Information', () {}),
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
          _buildSettingsTile(Icons.notifications_none, 'Notification Preferences', () {}),
          _buildSettingsTile(Icons.security, 'Privacy Controls', () {}),
          
          const SizedBox(height: 24),
          const TranslatedText('Support', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.indigo)),
          const SizedBox(height: 8),
          _buildSettingsTile(Icons.help_outline, 'Help & FAQ', () {}),
          _buildSettingsTile(Icons.contact_support_outlined, 'Contact Admin', () {}),
          
          const SizedBox(height: 24),
          const TranslatedText('Danger Zone', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.red)),
          const SizedBox(height: 8),
          _buildSettingsTile(Icons.logout, 'Log Out', () => context.go('/login'), color: AppColors.textDark),
          _buildSettingsTile(Icons.delete_forever, 'Delete Account', () {
            _showDeleteDialog(context);
          }, color: AppColors.red),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, VoidCallback onTap, {Color color = AppColors.textDark}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: TranslatedText(title, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
        onTap: onTap,
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Account?'),
        content: const Text('This action is irreversible. All your personal data, family tree links, and business information will be permanently deleted.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.go('/login');
            }, 
            child: const Text('Delete Permanently', style: TextStyle(color: AppColors.red)),
          ),
        ],
      ),
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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select App Language', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.indigo)),
              const SizedBox(height: 8),
              const Text('Selecting a new language may take a few seconds to download the language model (~30MB).', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
              const SizedBox(height: 16),
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
                      title: Text(name, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: AppColors.textDark)),
                      trailing: isSelected ? const Icon(Icons.check, color: AppColors.orange) : null,
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
                            ScaffoldMessenger.of(screenContext).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to download language model. Please check your internet and try again.'),
                                backgroundColor: AppColors.red,
                                duration: Duration(seconds: 4),
                              ),
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

/// A beautiful step-based progress dialog for language model download.
class _LanguageDownloadDialog extends HookConsumerWidget {
  final TranslateLanguage lang;
  final String langName;

  const _LanguageDownloadDialog({
    required this.lang,
    required this.langName,
  });

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

    final progress = totalSteps.value > 0 ? currentStep.value / totalSteps.value : 0.0;

    return PopScope(
      canPop: false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header icon
            Container(
              width: 56,
              height: 56,
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
                size: 28,
                color: hasError.value
                    ? AppColors.red
                    : isDone.value
                        ? Colors.green
                        : AppColors.orange,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              hasError.value
                  ? 'Download Failed'
                  : isDone.value
                      ? 'Done!'
                      : 'Setting Up $langName',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 16),

            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                builder: (context, value, _) {
                  return LinearProgressIndicator(
                    value: hasError.value ? 1.0 : value,
                    minHeight: 8,
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
            const SizedBox(height: 8),

            // Step counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  hasError.value
                      ? 'Error'
                      : 'Step ${currentStep.value} of ${totalSteps.value}',
                  style: TextStyle(
                    fontSize: 12,
                    color: hasError.value ? AppColors.red : AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 12,
                    color: hasError.value ? AppColors.red : AppColors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Status message
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: (hasError.value ? AppColors.red : AppColors.indigo)
                    .withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  if (!isDone.value && !hasError.value)
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.orange,
                        ),
                      ),
                    ),
                  if (isDone.value)
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.check, size: 14, color: Colors.green),
                    ),
                  if (hasError.value)
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.close, size: 14, color: AppColors.red),
                    ),
                  Expanded(
                    child: Text(
                      statusMessage.value,
                      style: TextStyle(
                        fontSize: 13,
                        color: hasError.value ? AppColors.red : AppColors.textDark,
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
