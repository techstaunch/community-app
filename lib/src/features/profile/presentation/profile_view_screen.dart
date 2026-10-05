import 'package:flutter/material.dart';
import 'package:community_connect/src/common_widgets/app_avatar.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/app_messenger.dart';
import '../../../utils/app_date_formatter.dart';
import '../../exports/data/export_provider.dart';
import '../data/profile_provider.dart';
import '../data/profile_models.dart';
import '../data/profile_repository.dart';
import 'package:dio/dio.dart';
import '../../family_tree/data/family_models.dart';
import '../../family_tree/data/family_provider.dart';
import '../../family_tree/presentation/widgets/edit_family_member_sheet.dart';

FamilyTreeNode? _findNodeById(FamilyTreeNode root, String id, {Set<String>? visited}) {
  visited ??= {};
  if (root.id == id) return root;
  if (root.id != null) {
    if (visited.contains(root.id!)) return null;
    visited.add(root.id!);
  }
  for (final p in root.parents) {
    final res = _findNodeById(p, id, visited: visited);
    if (res != null) return res;
  }
  for (final s in root.spouses) {
    final res = _findNodeById(s, id, visited: visited);
    if (res != null) return res;
  }
  for (final c in root.children) {
    final res = _findNodeById(c, id, visited: visited);
    if (res != null) return res;
  }
  for (final sib in root.siblings) {
    final res = _findNodeById(sib, id, visited: visited);
    if (res != null) return res;
  }
  return null;
}

class ProfileViewScreen extends HookConsumerWidget {
  final String? userId;
  final bool isFromMyFamilyTree;
  final FamilyTreeNode? familyNode;
  const ProfileViewScreen({super.key, this.userId, this.isFromMyFamilyTree = false, this.familyNode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (userId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('User ID is missing.')),
      );
    }

    final currentUserId = ref.watch(profileControllerProvider.select((p) => p.value?.id));
    final blockStatusAsync = ref.watch(blockStatusProvider(userId!));
    final profileAsync = ref.watch(memberProfileProvider(userId!));

    final isBlockedStatus = blockStatusAsync.value ?? false;
    bool isBlockedByError = false;
    if (profileAsync.hasError) {
      final err = profileAsync.error;
      if (err is DioException && err.response?.data != null) {
        final data = err.response!.data;
        final msg = (data is Map ? (data['message'] ?? data['error']) : data.toString())
            .toString()
            .toLowerCase();
        if (msg.contains('block')) {
          isBlockedByError = true;
        }
      }
    }
    final isBlocked = isBlockedStatus || isBlockedByError;
    
    // Find the latest family node if we are viewing someone from our own family tree
    FamilyTreeNode? currentNode = familyNode;
    if (isFromMyFamilyTree && familyNode != null && familyNode!.id != null) {
      final myTree = ref.watch(familyControllerProvider).value;
      if (myTree != null) {
        final latestNode = _findNodeById(myTree, familyNode!.id!);
        if (latestNode != null) {
          currentNode = latestNode;
        }
      }
    }

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
                  Row(
                    children: [
                      CustomBackButton(onPressed: () => context.pop()),
                      SizedBox(width: 14.w),
                      TranslatedText(
                        'Member Profile',
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              fontSize: 18.sp,
                              color: AppColors.indigo,
                            ),
                      ),
                    ],
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: AppColors.textDark,
                      size: 24.sp,
                    ),
                    onSelected: (value) {
                      if (value == 'edit_profile' && currentNode != null) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (ctx) => EditFamilyMemberSheet(node: currentNode!),
                        );
                      } else if (value == 'report_block' && userId != null) {
                        _showReportBlockDialog(context, ref, userId!);
                      } else if (value == 'unblock' && userId != null) {
                        _unblockUser(context, ref, userId!);
                      }
                    },
                    itemBuilder: (context) => [
                      if (isBlocked && userId != null && userId != currentUserId)
                        const PopupMenuItem(
                          value: 'unblock',
                          child: Row(
                            children: [
                              Icon(Icons.lock_open_rounded, size: 20, color: AppColors.indigo),
                              SizedBox(width: 8),
                              TranslatedText('Unblock User'),
                            ],
                          ),
                        ),
                      if (!isBlocked && userId != null && userId != currentUserId)
                        const PopupMenuItem(
                          value: 'report_block',
                          child: Row(
                            children: [
                              Icon(Icons.block, size: 20, color: Colors.red),
                              SizedBox(width: 8),
                              TranslatedText(
                                'Report & Block',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      if (isFromMyFamilyTree && currentNode != null)
                        const PopupMenuItem(
                          value: 'edit_profile',
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 20, color: AppColors.textDark),
                              SizedBox(width: 8),
                              TranslatedText('Edit Profile'),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: isBlocked
                  ? _buildBlockedView(
                      context: context,
                      ref: ref,
                      fullName: currentNode?.fullName ??
                          profileAsync.value?.profile?.fullName,
                      profilePhotoUrl: currentNode?.photoUrl ??
                          profileAsync.value?.profile?.profilePhotoUrl,
                    )
                  : RefreshIndicator(
                          onRefresh: () async {
                            ref.invalidate(blockStatusProvider(userId!));
                            ref.invalidate(memberProfileProvider(userId!));
                            await Future.wait([
                              ref.refresh(blockStatusProvider(userId!).future),
                              ref.refresh(memberProfileProvider(userId!).future),
                            ]);
                          },
                          child: profileAsync.when(
                skipLoadingOnReload: true,
                skipLoadingOnRefresh: true,
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) {
                  String errorMessage = 'Failed to load profile.';
                  try {
                    if (err is DioException && err.response?.data != null) {
                      final data = err.response!.data;
                      if (data is Map && data['message'] != null) {
                        errorMessage = data['message'];
                      }
                    } else {
                      errorMessage = err.toString();
                    }
                  } catch (_) {
                    errorMessage = err.toString();
                  }
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info_outline, size: 48.r, color: AppColors.textMuted),
                          SizedBox(height: 16.h),
                          TranslatedText(
                            errorMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                data: (profile) {
                  return SingleChildScrollView(
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
                                  color: AppColors.indigo,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 64.w,
                                          height: 64.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2.w,
                                            ),
                                          ),
                                          child: AppAvatar(
                                            imageUrl: profile
                                                .profile
                                                ?.profilePhotoUrl,
                                            size: 76
                                                .r, // Container size is 80, subtracting border
                                          ),
                                        ),
                                        SizedBox(width: 16.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TranslatedText(
                                                profile.profile?.fullName !=
                                                        null
                                                    ? (profile.profile?.title !=
                                                                  null &&
                                                              profile
                                                                  .profile!
                                                                  .title!
                                                                  .isNotEmpty
                                                          ? '${profile.profile!.title} ${profile.profile!.fullName}'
                                                          : profile
                                                                .profile!
                                                                .fullName!)
                                                    : 'Unknown',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(height: 6.h),
                                              Row(
                                                children: [
                                                  if (profile
                                                              .job
                                                              ?.designation !=
                                                          null &&
                                                      profile
                                                          .job!
                                                          .designation!
                                                          .isNotEmpty) ...[
                                                    _buildTag(
                                                      profile.job!.designation!,
                                                    ),
                                                    SizedBox(width: 8.w),
                                                  ] else if (profile.business?.businessName != null &&
                                                      profile.business!.businessName!.isNotEmpty) ...[
                                                    _buildTag(
                                                      profile.business!.businessName!,
                                                    ),
                                                    SizedBox(width: 8.w),
                                                  ],
                                                  if (profile.profile?.city !=
                                                          null &&
                                                      profile
                                                          .profile!
                                                          .city!
                                                          .isNotEmpty) ...[
                                                    _buildTag(
                                                      profile.profile!.city!,
                                                      icon: Icons
                                                          .location_on_outlined,
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Action Buttons (QR Code & Biodata PDF)
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
                                                  final qrUrl =
                                                      profile
                                                          .qrCode
                                                          ?.qrImageUrl ??
                                                      profile.qrCode?.code;
                                                  context.push(
                                                    '/my_qr_code',
                                                    extra: {
                                                      'userId': profile.id,
                                                      'userName': profile
                                                          .profile
                                                          ?.fullName,
                                                      'qrImageUrl': qrUrl,
                                                    },
                                                  );
                                                },
                                                constraints:
                                                    const BoxConstraints(),
                                                padding: EdgeInsets.all(8.w),
                                                tooltip: 'View QR Code',
                                              ),
                                              if (profile.privacySettings?.isFindmatch == true) ...[
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
                                                  final targetId =
                                                      profile.id ?? userId;
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
                                                      profile.pdfUrl ??
                                                      profile
                                                          .profile
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
                                                      if (context.mounted) {
                                                        AppMessenger.showError(
                                                          'We couldn\'t open the PDF right now. Please try again.',
                                                        );
                                                      }
                                                    }
                                                  }
                                                },
                                                constraints:
                                                    const BoxConstraints(),
                                                padding: EdgeInsets.all(8.w),
                                                tooltip: 'Download Biodata',
                                              ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ],
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
                                          _buildTab('About', 0, activeTab),
                                          _buildTab('Business', 1, activeTab),
                                          _buildTab('Family', 2, activeTab),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(20.w),
                                        child: activeTab.value == 0
                                            ? _buildAboutTab(profile)
                                            : activeTab.value == 1
                                            ? _buildBusinessTab(profile)
                                            : _buildFamilyTab(context, profile),
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
          ),
        ],
      ),
    ),
  );
}

  Future<void> _showReportBlockDialog(BuildContext context, WidgetRef ref, String targetUserId) async {
    final reasonController = TextEditingController();
    
    final shouldBlock = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const TranslatedText('Report & Block'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TranslatedText('Please provide a reason for reporting/blocking this member (optional):'),
            SizedBox(height: 12.h),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                hintText: 'Reason...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const TranslatedText('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const TranslatedText('Report & Block'),
          ),
        ],
      ),
    );

    if (shouldBlock == true && context.mounted) {
      try {
        final repo = ref.read(profileRepositoryProvider);
        await repo.blockUser(targetUserId, reason: reasonController.text.trim());
        if (context.mounted) {
          AppMessenger.showSuccess('User has been blocked successfully.');
          ref.invalidate(blockStatusProvider(targetUserId));
          ref.invalidate(memberProfileProvider(targetUserId));
          ref.invalidate(blockedUsersProvider);
          context.pop(); // Go back to previous screen
        }
      } catch (e) {
        if (context.mounted) {
          AppMessenger.showError('Failed to block user. Please try again.');
        }
      }
    }
  }

  Future<void> _unblockUser(BuildContext context, WidgetRef ref, String targetUserId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const TranslatedText('Unblock Member?'),
        content: const TranslatedText(
          'Are you sure you want to unblock this member? Their profile details will become visible to you again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const TranslatedText('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.indigo,
              foregroundColor: Colors.white,
            ),
            child: const TranslatedText('Unblock'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        final repo = ref.read(profileRepositoryProvider);
        await repo.unblockUser(targetUserId);
        if (context.mounted) {
          AppMessenger.showSuccess('User has been unblocked successfully.');
        }
        ref.invalidate(blockStatusProvider(targetUserId));
        ref.invalidate(memberProfileProvider(targetUserId));
        ref.invalidate(blockedUsersProvider);
      } catch (e) {
        if (context.mounted) {
          AppMessenger.showError('Failed to unblock user. Please try again.');
        }
      }
    }
  }

  Widget _buildBlockedView({
    required BuildContext context,
    required WidgetRef ref,
    required String? fullName,
    required String? profilePhotoUrl,
  }) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(blockStatusProvider(userId!));
        ref.invalidate(memberProfileProvider(userId!));
        await Future.wait([
          ref.refresh(blockStatusProvider(userId!).future),
          ref.refresh(memberProfileProvider(userId!).future),
        ]);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Top Hero Card (Minimal & Indicating Blocked)
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.w),
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.indigo,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 64.w,
                          height: 64.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.w,
                            ),
                          ),
                          child: AppAvatar(
                            imageUrl: profilePhotoUrl,
                            size: 76.r,
                          ),
                        ),
                        Positioned(
                          right: -2.w,
                          bottom: -2.h,
                          child: Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.block,
                              size: 14.r,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TranslatedText(
                            fullName != null && fullName.isNotEmpty
                                ? fullName
                                : 'Blocked Member',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                color: Colors.red.withValues(alpha: 0.5),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.shield_outlined,
                                  size: 12.r,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 4.w),
                                TranslatedText(
                                  'Blocked User',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Blocked Info Box
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 72.r,
                      height: 72.r,
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_off_rounded,
                        size: 38.r,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    TranslatedText(
                      'This Profile is Blocked',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.indigo,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: TranslatedText(
                        'You have blocked this member. Their personal information, contact details, work profile, matrimonial biodata, and family relations are hidden.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton.icon(
                        onPressed: () => _unblockUser(context, ref, userId!),
                        icon: Icon(
                          Icons.lock_open_rounded,
                          size: 20.r,
                          color: Colors.white,
                        ),
                        label: TranslatedText(
                          'Unblock Member',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.indigo,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, {IconData? icon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 10.r, color: Colors.white),
            SizedBox(width: 3.w),
          ],
          TranslatedText(
            text,
            style: TextStyle(fontSize: 10.sp, color: Colors.white),
          ),
        ],
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

  Widget _buildAboutTab(UserProfile profile) {
    // API `show*` fields: true = privacy is ON (field is PRIVATE/hidden)
    final isMobilePrivate = profile.privacySettings?.showMobileNumber ?? false;
    final isEmailPrivate = profile.privacySettings?.showEmail ?? false;
    final isGotraPrivate = profile.privacySettings?.showGotra ?? false;
    final isMaternalPrivate =
        profile.privacySettings?.showMaternalInfo ?? false;
    final hasLinkedin = profile.profile?.linkedin?.trim().isNotEmpty ?? false;
    final hasInstagram = profile.profile?.instagram?.trim().isNotEmpty ?? false;
    final hasFacebook = profile.profile?.facebook?.trim().isNotEmpty ?? false;
    final hasTwitter = profile.profile?.twitter?.trim().isNotEmpty ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TranslatedText(
          'Contact Info',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.indigo,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              _buildInfoRow(
                'Mobile',
                isMobilePrivate
                    ? 'Hidden by Privacy Settings'
                    : (profile.mobileNumber ?? 'N/A'),
              ),
              if (profile.email != null && profile.email!.trim().isNotEmpty)
                _buildInfoRow(
                  'Email',
                  isEmailPrivate
                      ? 'Hidden by Privacy Settings'
                      : profile.email!,
                ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        TranslatedText(
          'Basic Info',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.indigo,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              if (profile.profile?.dob != null &&
                  profile.profile!.dob!.isNotEmpty)
                _buildInfoRow(
                  'Date of Birth',
                  AppDateFormatter.formatDate(profile.profile!.dob),
                ),
              if (profile.profile?.timeOfBirth != null &&
                  profile.profile!.timeOfBirth!.isNotEmpty)
                _buildInfoRow(
                  'Time of Birth',
                  AppDateFormatter.formatTime(profile.profile!.timeOfBirth),
                ),
              if (profile.profile?.gender != null &&
                  profile.profile!.gender!.isNotEmpty)
                _buildInfoRow('Gender', profile.profile!.gender!),
              if (profile.profile?.manglik != null &&
                  profile.profile!.manglik!.isNotEmpty)
                _buildInfoRow('Manglik', profile.profile!.manglik!),
              if (profile.profile?.disability != null &&
                  profile.profile!.disability!.isNotEmpty)
                _buildInfoRow('Disability', profile.profile!.disability!),
              if (profile.profile?.gotra != null &&
                  profile.profile!.gotra!.isNotEmpty)
                _buildInfoRow(
                  'Gotra',
                  isGotraPrivate
                      ? 'Hidden by Privacy Settings'
                      : profile.profile!.gotra!,
                ),
              if (profile.profile?.nativeVillage != null &&
                  profile.profile!.nativeVillage!.isNotEmpty)
                _buildInfoRow('Native', profile.profile!.nativeVillage!),
              if (profile.profile?.maternalGotra != null &&
                  profile.profile!.maternalGotra!.isNotEmpty)
                _buildInfoRow(
                  'Maternal Gotra',
                  isMaternalPrivate
                      ? 'Hidden by Privacy Settings'
                      : profile.profile!.maternalGotra!,
                ),
              if (profile.profile?.maternalSurname != null &&
                  profile.profile!.maternalSurname!.isNotEmpty)
                _buildInfoRow(
                  'Maternal Surname',
                  isMaternalPrivate
                      ? 'Hidden by Privacy Settings'
                      : profile.profile!.maternalSurname!,
                ),
              if (profile.profile?.state != null &&
                  profile.profile!.state!.isNotEmpty)
                _buildInfoRow('State', profile.profile!.state!),
              if (profile.profile?.city != null &&
                  profile.profile!.city!.isNotEmpty)
                _buildInfoRow('City', profile.profile!.city!),
              if (profile.profile?.education != null &&
                  profile.profile!.education!.isNotEmpty)
                _buildInfoRow('Education', profile.profile!.education!),
              if (profile.profile?.address != null &&
                  profile.profile!.address!.isNotEmpty)
                _buildInfoRow('Address', profile.profile!.address!),
            ],
          ),
        ),
        if (profile.profile?.bio != null &&
            profile.profile!.bio!.isNotEmpty) ...[
          SizedBox(height: 20.h),
          TranslatedText(
            'Bio',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.indigo,
            ),
          ),
          SizedBox(height: 12.h),
          TranslatedText(
            profile.profile!.bio!,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.5,
              color: AppColors.textMid,
            ),
          ),
        ],
        if (hasLinkedin || hasInstagram || hasFacebook || hasTwitter) ...[
          SizedBox(height: 20.h),
          TranslatedText(
            'Social Links',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.indigo,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              if (hasLinkedin) _buildSocialIcon(Icons.link, 'LinkedIn'),
              if (hasInstagram)
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: _buildSocialIcon(Icons.camera_alt, 'Instagram'),
                ),
              if (hasFacebook)
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: _buildSocialIcon(Icons.facebook, 'Facebook'),
                ),
              if (hasTwitter)
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: _buildSocialIcon(Icons.alternate_email, 'Twitter'),
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.border),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.indigo, size: 24.r),
        ),
        SizedBox(height: 4.h),
        TranslatedText(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
        ),
      ],
    );
  }

  Widget _buildBusinessTab(UserProfile profile) {
    final business = profile.business;
    final job = profile.job;
    final isBusinessPrivate =
        profile.privacySettings?.showBusinessInfo ?? false;
    final isJobPrivate =
        profile.privacySettings?.showProfessionalInfo ?? false;

    final hasBusiness = business != null &&
        ((business.businessName?.trim().isNotEmpty ?? false) ||
            (business.category?.trim().isNotEmpty ?? false) ||
            (business.productsServices?.trim().isNotEmpty ?? false) ||
            (business.role?.trim().isNotEmpty ?? false));

    final hasJob = job != null &&
        ((job.designation?.trim().isNotEmpty ?? false) ||
            (job.companyName?.trim().isNotEmpty ?? false) ||
            (job.industry?.trim().isNotEmpty ?? false) ||
            job.yearsOfExperience != null);

    final showBusinessSection = hasBusiness || isBusinessPrivate;
    final showJobSection = hasJob || isJobPrivate;

    if (!showBusinessSection && !showJobSection) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: const TranslatedText(
            'No business or job details available',
            style: TextStyle(color: AppColors.textMuted),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showBusinessSection) ...[
          TranslatedText(
            'Business Profile',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.indigo,
            ),
          ),
          SizedBox(height: 12.h),
          if (isBusinessPrivate)
            _buildPrivacyLockedCard(
              'Business details are hidden by privacy settings',
            )
          else if (business != null)
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: AppColors.indigoLight,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.business_center,
                          size: 24.r,
                          color: AppColors.indigo,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                              business.businessName ?? 'N/A',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            if (business.category != null &&
                                business.category!.isNotEmpty)
                              TranslatedText(
                                business.category!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.textMuted,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Divider(color: AppColors.border),
                  ),
                  if (business.role != null && business.role!.isNotEmpty)
                    _buildInfoRow('Role', business.role!),
                  if (business.productsServices != null &&
                      business.productsServices!.isNotEmpty)
                    _buildInfoRow(
                      'Services',
                      business.productsServices!,
                    ),
                  if ((business.city != null && business.city!.isNotEmpty) ||
                      (business.state != null && business.state!.isNotEmpty))
                    _buildInfoRow(
                      'Location',
                      [
                        if (business.city != null && business.city!.isNotEmpty)
                          business.city,
                        if (business.state != null &&
                            business.state!.isNotEmpty)
                          business.state,
                      ].join(', '),
                    ),
                  if (business.website != null && business.website!.isNotEmpty)
                    _buildInfoRow('Website', business.website!),
                ],
              ),
            ),
        ],
        if (showBusinessSection && showJobSection) SizedBox(height: 20.h),
        if (showJobSection) ...[
          TranslatedText(
            'Job Profile',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.indigo,
            ),
          ),
          SizedBox(height: 12.h),
          if (isJobPrivate)
            _buildPrivacyLockedCard(
              'Job details are hidden by privacy settings',
            )
          else if (job != null)
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: AppColors.indigoLight,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.work_outline_rounded,
                          size: 24.r,
                          color: AppColors.indigo,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                              job.designation ?? 'N/A',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            if (job.companyName != null &&
                                job.companyName!.isNotEmpty)
                              TranslatedText(
                                job.companyName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.textMuted,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Divider(color: AppColors.border),
                  ),
                  if (job.companyName != null && job.companyName!.isNotEmpty)
                    _buildInfoRow('Company', job.companyName!),
                  if (job.designation != null && job.designation!.isNotEmpty)
                    _buildInfoRow('Designation', job.designation!),
                  if (job.industry != null && job.industry!.isNotEmpty)
                    _buildInfoRow('Industry', job.industry!),
                  if (job.yearsOfExperience != null)
                    _buildInfoRow(
                      'Experience',
                      '${job.yearsOfExperience} ${job.yearsOfExperience == 1 ? 'Year' : 'Years'}',
                    ),
                  if ((job.city != null && job.city!.isNotEmpty) ||
                      (job.state != null && job.state!.isNotEmpty))
                    _buildInfoRow(
                      'Location',
                      [
                        if (job.city != null && job.city!.isNotEmpty) job.city,
                        if (job.state != null && job.state!.isNotEmpty)
                          job.state,
                      ].join(', '),
                    ),
                ],
              ),
            ),
        ],
      ],
    );
  }

  Widget _buildPrivacyLockedCard(String message) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline, size: 20.r, color: AppColors.textMuted),
          SizedBox(width: 10.w),
          Expanded(
            child: TranslatedText(
              message,
              style: TextStyle(fontSize: 13.sp, color: AppColors.textMuted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: TranslatedText(
              label,
              style: TextStyle(fontSize: 13.sp, color: AppColors.textMuted),
            ),
          ),
          Expanded(
            child: TranslatedText(
              value,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyTab(BuildContext context, UserProfile profile) {
    final familyMembers = profile.ownedFamilyMembers ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TranslatedText(
          'Immediate Family',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.indigo,
          ),
        ),
        SizedBox(height: 12.h),
        if (familyMembers.isNotEmpty)
          SizedBox(
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: familyMembers.length,
              itemBuilder: (context, index) {
                final member = familyMembers[index];
                return _buildFamilyMemberCard(
                  context: context,
                  imageUrl: member.photoUrl,
                  gender: member.gender,
                  name: member.fullName ?? 'Unknown',
                  relation: member.relationshipType ?? 'Unknown',
                  linkedUserId: member.linkedUserId,
                );
              },
            ),
          )
        else
          Center(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: const TranslatedText(
                'No family details available',
                style: TextStyle(color: AppColors.textMuted),
              ),
            ),
          ),
        if (familyMembers.isNotEmpty) ...[
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                final targetUserId = profile.id ?? userId;
                if (targetUserId != null && targetUserId.isNotEmpty) {
                  context.push(
                    '/member_family_tree',
                    extra: {
                      'userId': targetUserId,
                      'userName': profile.profile?.fullName,
                    },
                  );
                } else {
                  AppMessenger.showInfo(
                    'Family tree is not available for this member.',
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.indigo,
                side: const BorderSide(color: AppColors.border, width: 1.5),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: TranslatedText(
                'View Full Family Tree',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFamilyMemberCard({
    required BuildContext context,
    String? imageUrl,
    String? gender,
    required String name,
    required String relation,
    String? linkedUserId,
  }) {
    final isLinked = linkedUserId != null && linkedUserId.isNotEmpty;
    return GestureDetector(
      onTap: () {
        if (isLinked) {
          context.push('/profile_view', extra: {'id': linkedUserId});
        } else {
          AppMessenger.showInfo(
            'This family member is not registered on the app.',
          );
        }
      },
      child: Container(
        width: 105.w,
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isLinked
                ? AppColors.indigo.withValues(alpha: 0.3)
                : AppColors.border,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppAvatar(imageUrl: imageUrl, gender: gender, size: 40.r),
            SizedBox(height: 8.h),
            TranslatedText(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            TranslatedText(
              relation,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 10.sp, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
