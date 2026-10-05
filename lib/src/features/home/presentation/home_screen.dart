import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/app_refresh_indicator.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import 'package:community_connect/src/common_widgets/linkified_text.dart';
import 'package:community_connect/src/utils/app_date_formatter.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/common_widgets/app_avatar.dart';
import '../../profile/data/profile_provider.dart';
import '../../profile/data/profile_models.dart';
import '../../community/data/community_provider.dart';
import '../../community/data/community_models.dart';
import '../data/home_provider.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myCommunitiesAsync = ref.watch(myCommunitiesControllerProvider);
    final currentCommunity = myCommunitiesAsync.value?.firstOrNull;
    final userName = ref.watch(
      profileControllerProvider.select(
        (state) => state.value?.profile?.fullName?.trim(),
      ),
    );
    final announcementsAsync = ref.watch(notificationsControllerProvider);
    final hasUnreadNotifications = ref.watch(hasUnreadNotificationsProvider);

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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TranslatedText(
                          'Welcome back',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.textMuted,
                          ),
                        ),
                        TranslatedText(
                          userName?.isNotEmpty == true ? userName! : 'User',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontSize: 18.sp,
                                color: AppColors.indigo,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () {
                      final commId = currentCommunity?.id ?? 'default';
                      final commName = Uri.encodeComponent(
                        currentCommunity?.name ?? 'Community Details',
                      );
                      context.push(
                        '/community_detail/$commId?name=$commName&tab=announcements',
                      );
                    },
                    child: Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                        color: AppColors.orangeLight,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.orange.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.campaign_rounded,
                            color: AppColors.orange,
                            size: 22.r,
                          ),
                          if (hasUnreadNotifications)
                            Positioned(
                              top: 6.h,
                              right: 6.w,
                              child: Container(
                                width: 8.r,
                                height: 8.r,
                                decoration: const BoxDecoration(
                                  color: AppColors.orange,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: GestureDetector(
                onTap: () => context.go(
                  '/search',
                  extra: {'tab': 0, 't': DateTime.now().millisecondsSinceEpoch},
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.border, width: 1.5),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: AppColors.textMuted,
                        size: 18.r,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TranslatedText(
                          'Search members, profession, city...',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: AppRefreshIndicator(
                onRefresh: () async {
                  await Future.wait([
                    ref.read(profileControllerProvider.notifier).refresh(),
                    ref
                        .read(notificationsControllerProvider.notifier)
                        .refresh(),
                    ref.refresh(myCommunitiesControllerProvider.future),
                    ref.refresh(recentMembersProvider.future),
                  ]);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _ProfileIncompleteBanner(),

                      // Recently Joined Members Section
                      ref
                          .watch(recentMembersProvider)
                          .when(
                            skipLoadingOnReload: true,
                            skipLoadingOnRefresh: true,
                            data: (members) {
                              if (members.isEmpty)
                                return const SizedBox.shrink();
                              return _AnimatedEntrance(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TranslatedText(
                                      'Recently Joined',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.indigo,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: members
                                            .map(
                                              (m) => _buildRecentMember(
                                                m.profilePhotoUrl,
                                                m.gender,
                                                m.fullName ?? 'Unknown',
                                                m.designation ?? 'Member',
                                                onTap: () => context.push(
                                                  '/profile_view',
                                                  extra: {'id': m.id},
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            loading: () => const SizedBox.shrink(),
                            error: (_, _) => const SizedBox.shrink(),
                          ),

                      SizedBox(height: 10.h),

                      TranslatedText(
                        'Quick Actions',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.indigo,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildQuickAction(
                              'assets/images/icon_family_tree.png',
                              'Family Tree',
                              () => context.go('/family_tree'),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: _buildQuickAction(
                              'assets/images/icon_matrimony.png',
                              'Find Match',
                              () => context.go(
                                '/search?tab=1',
                                extra: {
                                  'tab': 1,
                                  't': DateTime.now().millisecondsSinceEpoch,
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: _buildQuickAction(
                              'assets/images/business_icon.png',
                              'Find Business',
                              () => context.go(
                                '/search?tab=0',
                                extra: {
                                  'tab': 0,
                                  't': DateTime.now().millisecondsSinceEpoch,
                                },
                              ),
                              fallbackIcon: Icons.storefront_rounded,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      announcementsAsync.when(
                        skipLoadingOnReload: true,
                        skipLoadingOnRefresh: true,
                        data: (allAnnouncements) {
                          final announcements = allAnnouncements.toList();
                          if (announcements.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Community Announcements Section Header
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TranslatedText(
                                    'Community Announcements',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.indigo,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      final commId =
                                          currentCommunity?.id ?? 'default';
                                      final commName = Uri.encodeComponent(
                                        currentCommunity?.name ??
                                            'Community Details',
                                      );
                                      context.push(
                                        '/community_detail/$commId?name=$commName&tab=announcements',
                                      );
                                    },
                                    child: TranslatedText(
                                      'View All',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              ...announcements.take(3).map((ann) {
                                final isEvent = ann.source == 'ZINGGUP';
                                return _buildAnnouncementCard(
                                  title: ann.title ?? (isEvent ? 'Event' : 'Announcement'),
                                  subtitle: AppDateFormatter.formatRelativeTime(
                                    ann.createdAt,
                                  ),
                                  desc: ann.body,
                                  onTap: () {
                                    final commId =
                                        currentCommunity?.id ?? 'default';
                                    final commName = Uri.encodeComponent(
                                      currentCommunity?.name ??
                                          'Community Details',
                                    );
                                    final tab = isEvent ? 'events' : 'announcements';
                                    context.push(
                                      '/community_detail/$commId?name=$commName&tab=$tab',
                                    );
                                  },
                                );
                              }),
                              SizedBox(height: 20.h),
                            ],
                          );
                        },
                        loading: () => const SizedBox.shrink(),
                        error: (_, _) => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard({
    required String title,
    required String subtitle,
    String? desc,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(14.r),
            bottomRight: Radius.circular(14.r),
            topLeft: Radius.circular(4.r),
            bottomLeft: Radius.circular(4.r),
          ),
          border: Border(
            left: BorderSide(color: AppColors.indigo, width: 4.w),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TranslatedText(
                    title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                Icon(
                  Icons.campaign_outlined,
                  size: 18.r,
                  color: AppColors.orange,
                ),
              ],
            ),
            SizedBox(height: 3.h),
            TranslatedText(
              subtitle,
              style: TextStyle(fontSize: 11.sp, color: AppColors.textMuted),
            ),
            if (desc != null && desc.isNotEmpty) ...[
              SizedBox(height: 6.h),
              LinkifiedText(
                text: desc,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textMid,
                  height: 1.35,
                ),
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerRight,
                child: TranslatedText(
                  'Read More',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.orange,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRecentMember(
    String? photoUrl,
    String? gender,
    String name,
    String tag, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 100.w,
        margin: EdgeInsets.only(right: 10.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            AppAvatar(imageUrl: photoUrl, gender: gender, size: 28.r),
            SizedBox(height: 8.h),
            TranslatedText(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 2.h),
            TranslatedText(
              tag,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.sp, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(
    String assetPath,
    String title,
    VoidCallback onTap, {
    IconData? fallbackIcon,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            if (fallbackIcon != null)
              Icon(fallbackIcon, size: 32.r, color: AppColors.orange)
            else
              Image.asset(
                assetPath,
                width: 32.r,
                height: 32.r,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) =>
                    Icon(Icons.apps, size: 32.r, color: AppColors.orange),
              ),
            SizedBox(height: 8.h),
            TranslatedText(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileIncompleteBanner extends HookConsumerWidget {
  const _ProfileIncompleteBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileControllerProvider);
    final profile = profileState.value;
    if (profile == null || !profile.isProfileIncomplete) {
      return const SizedBox.shrink();
    }

    final percent = (profile.completionPercentage * 100).toInt();
    final missing = profile.missingFields.take(2).join(', ');

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.orange.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: AppColors.orange.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.orangeLight,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.assignment_late_outlined,
                  color: AppColors.orange,
                  size: 20.r,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TranslatedText(
                      'Complete Your Profile ($percent%)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    TranslatedText(
                      'Missing: $missing...',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => context.push('/edit_profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  minimumSize: Size(0, 34.h),
                ),
                child: TranslatedText(
                  'Complete',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: profile.completionPercentage,
              backgroundColor: AppColors.orangeLight,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.orange),
              minHeight: 5.h,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedEntrance extends StatelessWidget {
  final Widget child;

  const _AnimatedEntrance({required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: child,
    );
  }
}
