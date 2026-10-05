import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/app_avatar.dart';
import '../../../common_widgets/custom_buttons.dart';
import '../../../common_widgets/translated_text.dart';
import '../../../utils/responsive_ext.dart';
import '../../../utils/app_messenger.dart';
import '../data/profile_provider.dart';
import '../data/profile_repository.dart';
import '../data/profile_models.dart';

class BlockedUsersScreen extends HookConsumerWidget {
  const BlockedUsersScreen({super.key});

  Future<void> _confirmUnblock(
    BuildContext context,
    WidgetRef ref,
    UserProfile user,
  ) async {
    final userId = user.id;
    if (userId == null || userId.isEmpty) return;

    final name = user.profile?.fullName ?? 'this member';
    final shouldUnblock = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const TranslatedText('Unblock Member?'),
        content: TranslatedText(
          'Are you sure you want to unblock $name? Their profile details will become visible to you again.',
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

    if (shouldUnblock == true && context.mounted) {
      try {
        await ref.read(profileRepositoryProvider).unblockUser(userId);
        if (context.mounted) {
          AppMessenger.showSuccess('User unblocked successfully.');
        }
        ref.invalidate(blockedUsersProvider);
        ref.invalidate(blockStatusProvider(userId));
        ref.invalidate(memberProfileProvider(userId));
      } catch (e) {
        if (context.mounted) {
          AppMessenger.showError('Failed to unblock user. Please try again.');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockedUsersAsync = ref.watch(blockedUsersProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(onPressed: () => context.pop()),
        title: TranslatedText(
          'Blocked Users',
          style: TextStyle(
            color: AppColors.indigo,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: blockedUsersAsync.when(
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 48.r,
                  color: Colors.red,
                ),
                SizedBox(height: 16.h),
                TranslatedText(
                  'Failed to load blocked users.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textMuted,
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () => ref.refresh(blockedUsersProvider.future),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  child: const TranslatedText('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (users) {
          if (users.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => ref.refresh(blockedUsersProvider.future),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80.r,
                            height: 80.r,
                            decoration: BoxDecoration(
                              color: AppColors.indigo.withValues(alpha: 0.08),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person_off_outlined,
                              size: 40.r,
                              color: AppColors.indigo,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          TranslatedText(
                            'No Blocked Users',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.indigo,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TranslatedText(
                            'You have not blocked any members.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(blockedUsersProvider.future),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final name = user.profile?.fullName ??
                    user.mobileNumber ??
                    'Blocked Member';
                final city = user.profile?.city;
                final gotra = user.profile?.gotra;

                String subtitle = 'Blocked member';
                if (city != null && city.isNotEmpty && gotra != null && gotra.isNotEmpty) {
                  subtitle = '$city • $gotra';
                } else if (city != null && city.isNotEmpty) {
                  subtitle = city;
                } else if (gotra != null && gotra.isNotEmpty) {
                  subtitle = gotra;
                }

                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: () {
                      if (user.id != null && user.id!.isNotEmpty) {
                        context.push(
                          '/profile_view',
                          extra: {'id': user.id},
                        );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(14.w),
                      child: Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AppAvatar(
                                imageUrl: user.profile?.profilePhotoUrl,
                                size: 48.r,
                              ),
                              Positioned(
                                right: -2.w,
                                bottom: -2.h,
                                child: Container(
                                  padding: EdgeInsets.all(2.r),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.block,
                                    size: 10.r,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TranslatedText(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15.sp,
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
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.w),
                          OutlinedButton.icon(
                            onPressed: () => _confirmUnblock(context, ref, user),
                            icon: Icon(
                              Icons.lock_open_rounded,
                              size: 14.r,
                              color: AppColors.indigo,
                            ),
                            label: TranslatedText(
                              'Unblock',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.indigo,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 6.h,
                              ),
                              side: BorderSide(
                                color: AppColors.indigo.withValues(alpha: 0.5),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
