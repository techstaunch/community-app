import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../theme/app_theme.dart';
import '../../../../utils/app_messenger.dart';
import '../../../../common_widgets/app_avatar.dart';
import '../../../../common_widgets/translated_text.dart';
import 'package:community_connect/src/features/profile/data/profile_provider.dart';
import '../../data/family_models.dart';
import '../../data/family_provider.dart';
import '../../data/relation_display_helper.dart';
import 'edit_family_member_sheet.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import 'package:community_connect/src/utils/app_date_formatter.dart';

class FamilyNodeActionsSheet extends ConsumerWidget {
  final FamilyTreeNode node;

  const FamilyNodeActionsSheet({
    super.key,
    required this.node,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = (node.title != null && node.title!.isNotEmpty)
        ? '${node.title} ${node.fullName ?? 'Unknown'}'
        : (node.fullName ?? 'Unknown');
    final relation = RelationDisplayHelper.resolve(
        relationshipToViewer: node.relationshipToViewer,
        directRelationship: node.directRelationship,
        relationshipType: node.relationshipType,
    );
    final isDeceased = node.isDeceased == true || (node.title != null && node.title!.toLowerCase() == 'late');
    final isRegistered = node.isRegisteredUser == true ||
        (node.linkedUserId != null && node.linkedUserId!.isNotEmpty);
    final targetProfileId = node.linkedUserId ??
        (node.isRegisteredUser == true ? node.id : null);

    bool checkIsMinor() {
      if (node.isMinor == true) return true;
      if (node.dob != null && node.dob!.isNotEmpty) {
        final d = AppDateFormatter.tryParseDate(node.dob);
        if (d != null) {
          final now = DateTime.now();
          var age = now.year - d.year;
          if (now.month < d.month || (now.month == d.month && now.day < d.day)) {
            age--;
          }
          return age < 18;
        }
      }
      return false;
    }

    final isMinor = checkIsMinor();

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        left: 20.w,
        right: 20.w,
        top: 12.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Member Header Card
          Row(
            children: [
              AppAvatar(
                imageUrl: node.photoUrl,
                gender: node.gender,
                size: 56.r,
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
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
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 4.h,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cream,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            relation,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                        if (isMinor)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.child_care, size: 12.sp, color: Colors.amber.shade900),
                                SizedBox(width: 3.w),
                                Text(
                                  'Minor',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber.shade900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (isDeceased)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'Deceased',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (node.linkedMobile != null && node.linkedMobile!.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.phone_outlined, size: 12.sp, color: AppColors.textMuted),
                          SizedBox(width: 4.w),
                          Text(
                            node.linkedMobile!,
                            style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isRegistered
                      ? const Color(0xFF10B981).withValues(alpha: 0.12)
                      : Colors.grey.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isRegistered
                        ? const Color(0xFF10B981).withValues(alpha: 0.3)
                        : AppColors.border,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isRegistered ? Icons.link : Icons.shield_outlined,
                      size: 13.sp,
                      color: isRegistered
                          ? const Color(0xFF10B981)
                          : AppColors.textMuted,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      isRegistered ? 'Linked' : 'Unverified',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: isRegistered
                            ? const Color(0xFF10B981)
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          const Divider(color: AppColors.border, height: 1),
          SizedBox(height: 12.h),

          // Option 1: View Profile (if registered)
          if (isRegistered && targetProfileId != null) ...[
            _buildActionTile(
              icon: Icons.person_outline,
              iconColor: AppColors.indigo,
              title: 'View Profile',
              subtitle: 'Open ${node.fullName}\'s community profile',
              onTap: () {
                Navigator.of(context).pop();
                context.push('/profile_view', extra: {
                  'id': targetProfileId,
                  'isFromMyFamilyTree': true,
                  'node': node,
                });
              },
            ),
            SizedBox(height: 8.h),
          ],

          // Option 2: Edit Details (full editable details)
          _buildActionTile(
            icon: Icons.edit_outlined,
            iconColor: AppColors.orange,
            title: 'Edit Family Member',
            subtitle: 'Update name, relation, mobile, and other details',
            onTap: () {
              Navigator.of(context).pop();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (ctx) => EditFamilyMemberSheet(node: node),
              );
            },
          ),
          SizedBox(height: 8.h),

          // Option 3: Remove from Tree
          _buildActionTile(
            icon: Icons.delete_outline,
            iconColor: Colors.red,
            title: 'Remove from Family Tree',
            subtitle: 'Delete this relative from your family tree',
            isDestructive: true,
            onTap: () => _confirmDelete(context, ref),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isDestructive
                ? Colors.red.withValues(alpha: 0.04)
                : AppColors.cream.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isDestructive
                  ? Colors.red.withValues(alpha: 0.2)
                  : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20.sp, color: iconColor),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TranslatedText(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: isDestructive ? Colors.red : AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    TranslatedText(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isDestructive
                            ? Colors.red.withValues(alpha: 0.7)
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 18.sp,
                color: isDestructive ? Colors.red : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    final name = node.fullName ?? 'this member';
    final relation = node.relationshipType ??
        node.directRelationship ??
        node.relationshipToViewer ??
        'relative';

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: TranslatedText(
          'Remove from Tree?',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        content: TranslatedText(
          'Are you sure you want to remove $name ($relation) from your family tree? This action cannot be undone.',
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: TranslatedText(
              'Cancel',
              style: TextStyle(color: AppColors.textMuted, fontSize: 14.sp),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            onPressed: () async {
              Navigator.of(dialogCtx).pop(); // Close dialog
              Navigator.of(context).pop(); // Close sheet

              final memberId = node.id;
              if (memberId == null || memberId.isEmpty) {
                AppMessenger.showInfo('Cannot modify mock or unsaved family member.');
                return;
              }

              try {
                await ref
                    .read(familyControllerProvider.notifier)
                    .deleteFamilyMember(memberId);
                ref.invalidate(profileControllerProvider);
                AppMessenger.showSuccess('$name removed from family tree.');
              } on DioException catch (e) {
                final resData = e.response?.data;
                if (resData is Map && resData['message'] != null) {
                  AppMessenger.showError(resData['message'].toString());
                } else {
                  AppMessenger.showError(e.message ?? 'Failed to delete family member.');
                }
              } catch (e) {
                AppMessenger.showError(e.toString());
              }
            },
            child: TranslatedText('Remove', style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}
