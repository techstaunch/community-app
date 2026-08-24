import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../data/profile_provider.dart';
import '../data/profile_models.dart';
import '../../exports/data/export_provider.dart';

class MyProfileScreen extends HookConsumerWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TranslatedText(
                    'My Profile & Settings',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 22,
                          color: AppColors.indigo,
                        ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.qr_code, color: AppColors.indigo),
                        onPressed: () => context.push('/my_qr_code'),
                        constraints: const BoxConstraints(minWidth: 40),
                      ),
                      IconButton(
                        icon: const Icon(Icons.picture_as_pdf, color: AppColors.indigo),
                        onPressed: () async {
                          final userId = profileState.value?.id;
                          if (userId != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Generating PDF...')),
                            );
                            final url = await ref.read(exportControllerProvider.notifier).exportPdfBiodata(userId);
                            if (url != null && context.mounted) {
                              final uri = Uri.parse(url);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Could not open PDF')),
                                );
                              }
                            }
                          }
                        },
                        constraints: const BoxConstraints(minWidth: 40),
                      ),
                      TextButton(
                        onPressed: () => context.push('/edit_profile'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.orange,
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const TranslatedText('Edit',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: profileState.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
                data: (profile) {
                  final core = profile?.profile;
                  final name = core?.fullName ?? 'Setup Profile';
                  final subtitle = '${core?.city ?? 'City'} • ${core?.gotra ?? 'Gotra'}';

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        // Header Section
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppColors.indigoLight,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final picker = ImagePicker();
                                        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                        if (image != null) {
                                          ref.read(profileControllerProvider.notifier).uploadProfilePhoto(image.path);
                                        }
                                      },
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: Alignment.center,
                                            child: core?.profilePhotoUrl != null 
                                                ? ClipOval(child: Image.network(core!.profilePhotoUrl!, width: 60, height: 60, fit: BoxFit.cover))
                                                : const TranslatedText('👨', style: TextStyle(fontSize: 30)),
                                          ),
                                          Positioned(
                                            bottom: -4,
                                            right: -4,
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                color: AppColors.orange,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.edit, size: 12, color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TranslatedText(
                                            name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textDark,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          TranslatedText(
                                            subtitle,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textDark
                                                  .withValues(alpha: 0.7),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Tabs and Content wrapped in HookBuilder
                              HookBuilder(
                                builder: (context) {
                                  final activeTab = useState(0);
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          _buildTab('Personal', 0, activeTab),
                                          _buildTab('Family', 1, activeTab),
                                          _buildTab('Work', 2, activeTab),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: activeTab.value == 0
                                            ? _buildPersonalTab(profile)
                                            : activeTab.value == 1
                                                ? _buildFamilyTab(context)
                                                : _buildWorkTab(context, profile),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index, ValueNotifier<int> activeTab) {
    final isActive = activeTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => activeTab.value = index,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? AppColors.indigo : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: TranslatedText(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
              color: isActive ? AppColors.indigo : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalTab(UserProfile? profile) {
    final core = profile?.profile;
    final privacy = profile?.privacySettings;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TranslatedText(
          'Privacy Settings',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 12),
        _buildPrivacyField('Phone Number', profile?.mobileNumber ?? 'Setup required', privacy?.showMobileNumber ?? false),
        _buildPrivacyField('Date of Birth', core?.dob ?? 'Setup required', false),
        _buildPrivacyField('Native Village', core?.nativeVillage ?? 'Setup required', true),
      ],
    );
  }

  Widget _buildFamilyTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPrivacyField('Family Tree Visibility', 'Public', true),
        const SizedBox(height: 24),
        const TranslatedText(
          'Linked Family',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.cream,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const TranslatedText('👨', style: TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TranslatedText('Sanjay Patil',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark)),
                    TranslatedText('Father',
                        style:
                            TextStyle(fontSize: 12, color: AppColors.textMid)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        OutlinePrimaryButton(
          text: '+ Add Family Member',
          onPressed: () => context.push('/add_family'),
        ),
      ],
    );
  }

  Widget _buildWorkTab(BuildContext context, UserProfile? profile) {
    final job = profile?.job;
    final privacy = profile?.privacySettings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPrivacyField('Work Details Visibility', 'Public', privacy?.showProfessionalInfo ?? false),
        const SizedBox(height: 24),
        const TranslatedText(
          'Current Profile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TranslatedText(job?.designation ?? 'Not Set',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.textDark)),
                  GestureDetector(
                    onTap: () => context.push('/work_profile'),
                    child: const Icon(Icons.edit,
                        size: 18, color: AppColors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              TranslatedText('${job?.companyName ?? ''} • ${job?.yearsOfExperience ?? 0} Years Experience',
                  style: const TextStyle(color: AppColors.textMid, fontSize: 13)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          text: 'Add Business / Job',
          onPressed: () => context.push('/work_profile'),
        ),
      ],
    );
  }

  Widget _buildPrivacyField(String label, String value, bool isPublic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TranslatedText(label,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textMuted)),
                const SizedBox(height: 4),
                TranslatedText(value,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(isPublic ? Icons.public : Icons.lock,
                      size: 14,
                      color: isPublic ? AppColors.green : AppColors.textMuted),
                  const SizedBox(width: 4),
                  TranslatedText(isPublic ? 'Public' : 'Private',
                      style: TextStyle(
                          fontSize: 11,
                          color: isPublic
                              ? AppColors.green
                              : AppColors.textMuted)),
                ],
              ),
              Switch(
                value: isPublic,
                onChanged: (v) {},
                activeThumbColor: AppColors.orange,
              ),
            ],
          )
        ],
      ),
    );
  }
}
