import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:community_connect/src/common_widgets/app_avatar.dart';
import 'package:community_connect/src/utils/app_messenger.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/app_refresh_indicator.dart';
import '../../../common_widgets/custom_buttons.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../data/profile_provider.dart';
import '../data/profile_models.dart';
import '../../exports/data/export_provider.dart';
import '../../../utils/app_date_formatter.dart';

String _formatDate(String? isoString) =>
    AppDateFormatter.formatDate(isoString, fallback: 'Setup required');

class MyProfileScreen extends HookConsumerWidget {
  final String? scrollToken;
  const MyProfileScreen({super.key, this.scrollToken});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileControllerProvider);
    final localPhotoBytes = useState<Uint8List?>(null);
    final isUploadingPhoto = useState<bool>(false);
    final privacyKey = useMemoized(() => GlobalKey());

    useEffect(() {
      if (scrollToken != null && scrollToken!.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 500), () {
            if (privacyKey.currentContext != null) {
              Scrollable.ensureVisible(
                privacyKey.currentContext!,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          });
        });
      }
      return null;
    }, [scrollToken, profileState.value]);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Container(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TranslatedText(
                    'Profile',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 22.sp,
                      color: AppColors.indigo,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => context.push('/edit_profile'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.orange,
                          padding: EdgeInsets.zero,
                          minimumSize: Size(50.w, 30.h),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const TranslatedText(
                          'Edit',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert_rounded,
                          color: AppColors.indigo,
                          size: 24.r,
                        ),
                        onSelected: (value) async {
                          if (value == 'biodata') {
                            final currentProfile = profileState.value;
                            final userId = currentProfile?.id;
                            if (userId != null) {
                              final cachedPdf = ref
                                      .read(exportControllerProvider.notifier)
                                      .getCachedPdfUrl(userId) ??
                                  currentProfile?.pdfUrl ??
                                  currentProfile?.profile?.biodataUrl;
                              if (cachedPdf == null || cachedPdf.isEmpty) {
                                AppMessenger.showInfo(
                                  'We are generating your PDF. Just a moment...',
                                );
                              }
                              final url = await ref
                                  .read(exportControllerProvider.notifier)
                                  .exportPdfBiodata(userId, forceRefresh: true);
                              if (url != null && context.mounted) {
                                final uri = Uri.parse(url);
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(
                                    uri,
                                    mode: LaunchMode.externalApplication,
                                  );
                                } else {
                                  if (context.mounted) {
                                    AppMessenger.showError(
                                      'We couldn\'t open the PDF right now. Please try again.',
                                    );
                                  }
                                }
                              }
                            }
                          } else if (value == 'blocked_users') {
                            context.push('/blocked_users');
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'biodata',
                            child: TranslatedText('Share my biodata'),
                          ),
                          const PopupMenuItem(
                            value: 'blocked_users',
                            child: TranslatedText('Blocked Users'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: profileState.when(
                skipLoadingOnReload: true,
                skipLoadingOnRefresh: true,
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
                data: (profile) {
                  final core = profile?.profile;
                  final fullName = core?.fullName;
                  final title = core?.title;
                  final String name = fullName != null
                      ? ((title != null && title.isNotEmpty)
                            ? '$title $fullName'
                            : fullName)
                      : 'Setup Profile';
                  final subtitle =
                      '${core?.city ?? 'City'} • ${core?.gotra ?? 'Gotra'}';

                  return AppRefreshIndicator(
                    onRefresh: () =>
                        ref.read(profileControllerProvider.notifier).refresh(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          // Header Section
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.indigoLight,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: Row(
                                    children: [
                                      AppAvatar(
                                        imageUrl: core?.profilePhotoUrl,
                                        memoryBytes: localPhotoBytes.value,
                                        size: 60.r,
                                        isUploading: isUploadingPhoto.value,
                                        fallbackWidget: Icon(
                                          Icons.person_rounded,
                                          size: 34.r,
                                          color: AppColors.orange,
                                        ),
                                        onEdit: () async {
                                          final bool hasExistingPhoto =
                                              (core?.profilePhotoUrl != null &&
                                                  core!
                                                      .profilePhotoUrl!
                                                      .isNotEmpty) ||
                                              localPhotoBytes.value != null;
                                          if (hasExistingPhoto) {
                                            showModalBottomSheet(
                                              context: context,
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                      top: Radius.circular(
                                                        16.r,
                                                      ),
                                                    ),
                                              ),
                                              builder: (ctx) => SafeArea(
                                                child: Wrap(
                                                  children: [
                                                    ListTile(
                                                      leading: const Icon(Icons.camera_alt_outlined, color: AppColors.indigo),
                                                      title: const TranslatedText('Take Photo'),
                                                      onTap: () async {
                                                        Navigator.pop(ctx);
                                                        final picker = ImagePicker();
                                                        final XFile? image = await picker.pickImage(source: ImageSource.camera);
                                                        if (image != null) {
                                                          final bytes = await image.readAsBytes();
                                                          localPhotoBytes.value = bytes;
                                                          isUploadingPhoto.value = true;
                                                          try {
                                                            await ref.read(profileControllerProvider.notifier).uploadProfilePhoto(image.path);
                                                          } finally {
                                                            if (context.mounted) isUploadingPhoto.value = false;
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(Icons.photo_library_outlined, color: AppColors.indigo),
                                                      title: const TranslatedText('Choose from Gallery'),
                                                      onTap: () async {
                                                        Navigator.pop(ctx);
                                                        final picker = ImagePicker();
                                                        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                                        if (image != null) {
                                                          final bytes =
                                                              await image
                                                                  .readAsBytes();
                                                          localPhotoBytes
                                                                  .value =
                                                              bytes;
                                                          isUploadingPhoto
                                                                  .value =
                                                              true;
                                                          try {
                                                            await ref
                                                                .read(
                                                                  profileControllerProvider
                                                                      .notifier,
                                                                )
                                                                .uploadProfilePhoto(
                                                                  image.path,
                                                                );
                                                          } finally {
                                                            if (context
                                                                .mounted) {
                                                              isUploadingPhoto
                                                                      .value =
                                                                  false;
                                                            }
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.red,
                                                      ),
                                                      title:
                                                          const TranslatedText(
                                                            'Remove Photo',
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                      onTap: () async {
                                                        Navigator.pop(ctx);
                                                        isUploadingPhoto.value =
                                                            true;
                                                        try {
                                                          await ref
                                                              .read(
                                                                profileControllerProvider
                                                                    .notifier,
                                                              )
                                                              .deleteProfilePhoto();
                                                          localPhotoBytes
                                                                  .value =
                                                              null;
                                                        } finally {
                                                          if (context.mounted) {
                                                            isUploadingPhoto
                                                                    .value =
                                                                false;
                                                          }
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            showModalBottomSheet(
                                              context: context,
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                                              builder: (ctx) => SafeArea(
                                                child: Wrap(
                                                  children: [
                                                    ListTile(
                                                      leading: const Icon(Icons.camera_alt_outlined, color: AppColors.indigo),
                                                      title: const TranslatedText('Take Photo'),
                                                      onTap: () async {
                                                        Navigator.pop(ctx);
                                                        final picker = ImagePicker();
                                                        final XFile? image = await picker.pickImage(source: ImageSource.camera);
                                                        if (image != null) {
                                                          final bytes = await image.readAsBytes();
                                                          localPhotoBytes.value = bytes;
                                                          isUploadingPhoto.value = true;
                                                          try {
                                                            await ref.read(profileControllerProvider.notifier).uploadProfilePhoto(image.path);
                                                          } finally {
                                                            if (context.mounted) isUploadingPhoto.value = false;
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(Icons.photo_library_outlined, color: AppColors.indigo),
                                                      title: const TranslatedText('Choose from Gallery'),
                                                      onTap: () async {
                                                        Navigator.pop(ctx);
                                                        final picker = ImagePicker();
                                                        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                                        if (image != null) {
                                                          final bytes = await image.readAsBytes();
                                                          localPhotoBytes.value = bytes;
                                                          isUploadingPhoto.value = true;
                                                          try {
                                                            await ref.read(profileControllerProvider.notifier).uploadProfilePhoto(image.path);
                                                          } finally {
                                                            if (context.mounted) isUploadingPhoto.value = false;
                                                          }
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TranslatedText(
                                              name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textDark,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            TranslatedText(
                                              subtitle,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: AppColors.textDark
                                                    .withValues(alpha: 0.7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Action Buttons
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.6,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.qr_code_rounded,
                                                color: AppColors.indigo,
                                                size: 22.r,
                                              ),
                                              onPressed: () {
                                                final currentProfile =
                                                    profileState.value;
                                                final qrUrl =
                                                    currentProfile
                                                        ?.qrCode
                                                        ?.qrImageUrl ??
                                                    currentProfile
                                                        ?.qrCode
                                                        ?.code;
                                                context.push(
                                                  '/my_qr_code',
                                                  extra: {
                                                    'userId':
                                                        currentProfile?.id,
                                                    'userName': currentProfile
                                                        ?.profile
                                                        ?.fullName,
                                                    'qrImageUrl': qrUrl,
                                                  },
                                                );
                                              },
                                              constraints:
                                                  const BoxConstraints(),
                                              padding: EdgeInsets.all(8.w),
                                              tooltip: 'My QR Code',
                                            ),
                                            if (profileState.value?.privacySettings?.isFindmatch == true) ...[
                                              Container(
                                                width: 1.w,
                                                height: 20.h,
                                                color: AppColors.indigo
                                                    .withValues(alpha: 0.2),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.picture_as_pdf_rounded,
                                                  color: AppColors.indigo,
                                                  size: 22.r,
                                                ),
                                                onPressed: () async {
                                                  final currentProfile =
                                                      profileState.value;
                                                  final targetId =
                                                      currentProfile?.id;
                                                  if (targetId == null ||
                                                      targetId.isEmpty) {
                                                    AppMessenger.showError(
                                                      'User ID not found for exporting PDF.',
                                                    );
                                                    return;
                                                  }
                                                  final cachedPdf =
                                                      ref
                                                          .read(
                                                            exportControllerProvider
                                                                .notifier,
                                                          )
                                                          .getCachedPdfUrl(
                                                            targetId,
                                                          ) ??
                                                      currentProfile
                                                          ?.profile
                                                          ?.biodataUrl;
                                                  if (cachedPdf == null ||
                                                      cachedPdf.isEmpty) {
                                                    AppMessenger.showInfo(
                                                      'We are generating the PDF. Just a moment...',
                                                    );
                                                  }
                                                  final url = await ref
                                                      .read(
                                                        exportControllerProvider
                                                            .notifier,
                                                      )
                                                      .exportPdfBiodata(
                                                        targetId,
                                                        forceRefresh: true,
                                                      );
                                                  if (url != null &&
                                                      context.mounted) {
                                                    final uri = Uri.parse(url);
                                                    if (await canLaunchUrl(
                                                      uri,
                                                    )) {
                                                      await launchUrl(
                                                        uri,
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    } else {
                                                      AppMessenger.showError(
                                                        'Could not open PDF viewer.',
                                                      );
                                                    }
                                                  }
                                                },
                                                constraints:
                                                    const BoxConstraints(),
                                                padding: EdgeInsets.all(8.w),
                                                tooltip: 'View Biodata',
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 20.h),

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
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 20.h,
                                          ),
                                          child: activeTab.value == 0
                                              ? _buildPersonalTab(profile, ref, privacyKey)
                                              : activeTab.value == 1
                                              ? _buildFamilyTab(
                                                  context,
                                                  ref,
                                                  profile,
                                                )
                                              : _buildWorkTab(
                                                  context,
                                                  profile,
                                                  ref,
                                                ),
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
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? AppColors.indigo : Colors.transparent,
                width: 2.h,
              ),
            ),
          ),
          child: TranslatedText(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
              color: isActive ? AppColors.indigo : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalTab(UserProfile? profile, WidgetRef ref, GlobalKey privacyKey) {
    final core = profile?.profile;
    final privacy = profile?.privacySettings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (core?.bio != null && core!.bio!.isNotEmpty) ...[
          TranslatedText(
            'About Me',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 8.h),
          TranslatedText(
            core.bio!,
            style: TextStyle(color: AppColors.textMid, fontSize: 14.sp),
          ),
          SizedBox(height: 24.h),
        ],
        TranslatedText(
          'Personal Details',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              _buildDetailRow('Date of Birth', _formatDate(core?.dob)),
              if (core?.timeOfBirth != null &&
                  core!.timeOfBirth!.isNotEmpty) ...[
                Divider(color: AppColors.border, height: 24.h),
                _buildDetailRow(
                  'Time of Birth',
                  AppDateFormatter.formatTime(core.timeOfBirth),
                ),
              ],
              Divider(color: AppColors.border, height: 24.h),
              _buildDetailRow('Gender', core?.gender ?? 'Not set'),
              if (core?.manglik != null && core!.manglik!.isNotEmpty) ...[
                Divider(color: AppColors.border, height: 24.h),
                _buildDetailRow('Manglik', core.manglik!),
              ],
              if (core?.disability != null && core!.disability!.isNotEmpty) ...[
                Divider(color: AppColors.border, height: 24.h),
                _buildDetailRow('Disability', core.disability!),
              ],
              Divider(color: AppColors.border, height: 24.h),
              _buildDetailRow('Gotra', core?.gotra ?? 'Not set'),
              Divider(color: AppColors.border, height: 24.h),
              _buildDetailRow(
                'Native Village',
                core?.nativeVillage ?? 'Not set',
              ),
              if (core?.maternalGotra != null &&
                  core!.maternalGotra!.isNotEmpty) ...[
                Divider(color: AppColors.border, height: 24.h),
                _buildDetailRow('Maternal Gotra', core.maternalGotra!),
              ],
              if (core?.maternalSurname != null &&
                  core!.maternalSurname!.isNotEmpty) ...[
                Divider(color: AppColors.border, height: 24.h),
                _buildDetailRow('Maternal Surname', core.maternalSurname!),
              ],
              if (core?.state != null && core!.state!.isNotEmpty) ...[
                Divider(color: AppColors.border, height: 24.h),
                _buildDetailRow('State', core.state!),
              ],
              if (core?.city != null && core!.city!.isNotEmpty) ...[
                Divider(color: AppColors.border, height: 24.h),
                _buildDetailRow('City', core.city!),
              ],
              Divider(color: AppColors.border, height: 24.h),
              _buildDetailRow('Height', core?.height ?? 'Not set'),
              Divider(color: AppColors.border, height: 24.h),
              _buildDetailRow('Education', core?.education ?? 'Not set'),
              Divider(color: AppColors.border, height: 24.h),
              _buildDetailRow('Address', core?.address ?? 'Not set'),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        if ((core?.instagram != null && core!.instagram!.isNotEmpty) ||
            (core?.facebook != null && core!.facebook!.isNotEmpty) ||
            (core?.linkedin != null && core!.linkedin!.isNotEmpty) ||
            (core?.twitter != null && core!.twitter!.isNotEmpty)) ...[
          TranslatedText(
            'Social Links',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                if (core.instagram != null && core.instagram!.isNotEmpty)
                  _buildSocialRow(
                    'Instagram',
                    core.instagram!,
                    Icons.camera_alt,
                  ),
                if (core.facebook != null && core.facebook!.isNotEmpty) ...[
                  if (core.instagram != null && core.instagram!.isNotEmpty)
                    Divider(color: AppColors.border, height: 24.h),
                  _buildSocialRow('Facebook', core.facebook!, Icons.facebook),
                ],
                if (core.linkedin != null && core.linkedin!.isNotEmpty) ...[
                  if ((core.instagram != null && core.instagram!.isNotEmpty) ||
                      (core.facebook != null && core.facebook!.isNotEmpty))
                    Divider(color: AppColors.border, height: 24.h),
                  _buildSocialRow('LinkedIn', core.linkedin!, Icons.work),
                ],
                if (core.twitter != null && core.twitter!.isNotEmpty) ...[
                  if ((core.instagram != null && core.instagram!.isNotEmpty) ||
                      (core.facebook != null && core.facebook!.isNotEmpty) ||
                      (core.linkedin != null && core.linkedin!.isNotEmpty))
                    Divider(color: AppColors.border, height: 24.h),
                  _buildSocialRow(
                    'Twitter',
                    core.twitter!,
                    Icons.alternate_email,
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
        TranslatedText(
          'Privacy Settings',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TranslatedText(
                      'Find Match Visibility',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TranslatedText(
                      'Show my profile in the Find Match directory',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: privacy?.isFindmatch ?? false,
                onChanged: (val) {
                  ref
                      .read(profileControllerProvider.notifier)
                      .updatePrivacySettings({'isFindmatch': val});
                },
                activeThumbColor: AppColors.orange,
              ),
            ],
          ),
        ),
        Container(
          key: privacyKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              TranslatedText(
                'Privacy Settings',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: 12.h),
              _buildPrivacyField(
                'Phone Number',
          profile?.mobileNumber ?? 'Setup required',
          privacy?.showMobileNumber ?? false,
          onChanged: (val) {
            ref.read(profileControllerProvider.notifier).updatePrivacySettings({
              'showMobileNumber': val,
            });
          },
        ),
        if (profile?.email != null && profile!.email!.trim().isNotEmpty)
          _buildPrivacyField(
            'Email Address',
            profile.email!,
            privacy?.showEmail ?? false,
            onChanged: (val) {
              ref
                  .read(profileControllerProvider.notifier)
                  .updatePrivacySettings({'showEmail': val});
            },
          ),

        _buildPrivacyField(
          'Gotra',
          core?.gotra ?? 'Setup required',
          privacy?.showGotra ?? false,
          onChanged: (val) {
            ref.read(profileControllerProvider.notifier).updatePrivacySettings({
              'showGotra': val,
            });
          },
        ),
        _buildPrivacyField(
          'Maternal Details',
          core?.maternalGotra ?? core?.maternalVillage ?? 'Setup required',
          privacy?.showMaternalInfo ?? false,
          onChanged: (val) {
            ref.read(profileControllerProvider.notifier).updatePrivacySettings({
              'showMaternalInfo': val,
            });
          },
        ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: TranslatedText(
            label,
            style: TextStyle(color: AppColors.textMuted, fontSize: 13.sp),
          ),
        ),
        Expanded(
          flex: 3,
          child: TranslatedText(
            value,
            style: TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialRow(String platform, String username, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20.r, color: AppColors.indigo),
        SizedBox(width: 12.w),
        Expanded(
          child: TranslatedText(
            platform,
            style: TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
        TranslatedText(
          username,
          style: TextStyle(color: AppColors.orange, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildFamilyTab(
    BuildContext context,
    WidgetRef ref,
    UserProfile? profile,
  ) {
    final familyMembers = profile?.ownedFamilyMembers ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPrivacyField(
          'Family Tree Visibility',
          (profile?.privacySettings?.showFamilyInfo ?? false)
              ? 'Private'
              : 'Public',
          profile?.privacySettings?.showFamilyInfo ?? false,
          onChanged: (val) {
            ref.read(profileControllerProvider.notifier).updatePrivacySettings({
              'showFamilyInfo': val,
            });
          },
        ),
        SizedBox(height: 24.h),
        TranslatedText(
          'Linked Family',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        if (familyMembers.isEmpty)
          Container(
            padding: EdgeInsets.all(16.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.border),
            ),
            child: const TranslatedText(
              'No family members added yet.',
              style: TextStyle(color: AppColors.textMuted),
            ),
          )
        else
          ...familyMembers.map((member) {
            final isLinked =
                member.linkedUserId != null && member.linkedUserId!.isNotEmpty;
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isLinked
                      ? AppColors.indigo.withValues(alpha: 0.3)
                      : AppColors.border,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16.r),
                  onTap: () {
                    if (isLinked) {
                      if (member.linkedUserId == profile?.id) {
                        return;
                      }
                      context.push(
                        '/profile_view',
                        extra: {'id': member.linkedUserId},
                      );
                    } else {
                      AppMessenger.showInfo(
                        'This family member is not registered on the app.',
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      children: [
                        AppAvatar(
                          imageUrl: member.photoUrl,
                          gender: member.gender,
                          size: 40.r,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TranslatedText(
                                member.fullName ?? 'Unknown',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              TranslatedText(
                                '${member.relationshipType ?? 'Relative'}${member.isDeceased == true ? ' • (Deceased)' : ''}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (member.qrImageUrl != null &&
                            member.qrImageUrl!.isNotEmpty) ...[
                          IconButton(
                            icon: Icon(
                              Icons.qr_code_rounded,
                              color: AppColors.indigo,
                              size: 20.r,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              context.push(
                                '/my_qr_code',
                                extra: {
                                  'userId': member.id,
                                  'userName': member.fullName,
                                  'qrImageUrl': member.qrImageUrl,
                                },
                              );
                            },
                          ),
                          SizedBox(width: 4.w),
                        ],
                        if (isLinked) ...[
                          Icon(
                            Icons.check_circle,
                            color: AppColors.green,
                            size: 20.r,
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.chevron_right,
                            color: AppColors.textMuted,
                            size: 18.r,
                          ),
                        ] else
                          Icon(
                            Icons.link_off,
                            color: AppColors.textMuted,
                            size: 20.r,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        SizedBox(height: 20.h),
        PrimaryButton(
          text: 'Add Family Member',
          onPressed: () => context.push('/add_family'),
        ),
      ],
    );
  }

  Widget _buildWorkTab(
    BuildContext context,
    UserProfile? profile,
    WidgetRef ref,
  ) {
    final job = profile?.job;
    final business = profile?.business;
    final privacy = profile?.privacySettings;

    final bool hasJob = job != null && job.id != null;
    final bool hasBusiness = business != null && business.id != null;
    final bool hasWork = hasJob || hasBusiness;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasJob)
          _buildPrivacyField(
            'Job Details Visibility',
            (privacy?.showProfessionalInfo ?? false) ? 'Private' : 'Public',
            privacy?.showProfessionalInfo ?? false,
            onChanged: (val) {
              ref
                  .read(profileControllerProvider.notifier)
                  .updatePrivacySettings({'showProfessionalInfo': val});
            },
          ),
        if (hasBusiness)
          _buildPrivacyField(
            'Business Details Visibility',
            (privacy?.showBusinessInfo ?? false) ? 'Private' : 'Public',
            privacy?.showBusinessInfo ?? false,
            onChanged: (val) {
              ref
                  .read(profileControllerProvider.notifier)
                  .updatePrivacySettings({'showBusinessInfo': val});
            },
          ),
        SizedBox(height: 24.h),
        TranslatedText(
          'Current Profile',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        if (hasBusiness)
          _buildWorkCard(
            context,
            title: business.businessName ?? 'Business',
            subtitle:
                '${business.category ?? ''} • ${business.city ?? ''}, ${business.state ?? ''}',
            isBusiness: true,
          ),
        if (hasBusiness && hasJob) SizedBox(height: 12.h),
        if (hasJob)
          _buildWorkCard(
            context,
            title: job.designation ?? 'Job',
            subtitle:
                '${job.companyName ?? ''} • ${job.yearsOfExperience ?? 0} Years Experience',
            isBusiness: false,
          ),
        if (!hasWork) ...[
          _buildWorkCard(
            context,
            title: 'Not Set',
            subtitle: '0 Years Experience',
            isBusiness: false,
            isEmpty: true,
          ),
          SizedBox(height: 20.h),
          PrimaryButton(
            text: 'Add Business / Job',
            onPressed: () => context.push('/work_profile'),
          ),
        ],
        if (hasWork && (!hasBusiness || !hasJob)) ...[
          SizedBox(height: 20.h),
          PrimaryButton(
            text: !hasBusiness ? 'Add Business' : 'Add Job',
            onPressed: () => context.push(
              '/work_profile',
              extra: {'isBusiness': !hasBusiness},
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildWorkCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool isBusiness,
    bool isEmpty = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isEmpty) ...[
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(
                    isBusiness
                        ? 'assets/images/business_icon.png'
                        : 'assets/images/job_icon.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!isEmpty)
                      TranslatedText(
                        isBusiness ? 'BUSINESS' : 'EMPLOYMENT',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange,
                          letterSpacing: 1.2,
                        ),
                      )
                    else
                      const SizedBox(),
                    GestureDetector(
                      onTap: () => context.push(
                        '/work_profile',
                        extra: {'isBusiness': isBusiness},
                      ),
                      child: Icon(
                        isEmpty ? Icons.add : Icons.edit,
                        size: 18.r,
                        color: AppColors.orange,
                      ),
                    ),
                  ],
                ),
                if (!isEmpty) SizedBox(height: 4.h),
                TranslatedText(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 4.h),
                TranslatedText(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.textMid, fontSize: 13.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a privacy toggle field.
  /// [isPrivacyActive] maps directly to the API `show*` fields:
  ///   `true`  → privacy is ON → field is **Private** (hidden from others)
  ///   `false` → privacy is OFF → field is **Public** (visible to others)
  Widget _buildPrivacyField(
    String label,
    String value,
    bool isPrivacyActive, {
    ValueChanged<bool>? onChanged,
  }) {
    final isPublic = !isPrivacyActive;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TranslatedText(
                  label,
                  style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
                ),
                SizedBox(height: 4.h),
                TranslatedText(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          if (onChanged != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      isPublic ? Icons.public : Icons.lock,
                      size: 14.r,
                      color: isPublic ? AppColors.green : AppColors.textMuted,
                    ),
                    SizedBox(width: 4.w),
                    TranslatedText(
                      isPublic ? 'Public' : 'Private',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: isPublic ? AppColors.green : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: isPrivacyActive,
                  onChanged: (value == 'Setup required' || value.isEmpty)
                      ? null
                      : onChanged,
                  activeThumbColor: AppColors.orange,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
