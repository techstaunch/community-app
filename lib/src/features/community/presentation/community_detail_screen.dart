import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/app_refresh_indicator.dart';
import '../../../common_widgets/translated_text.dart';
import '../../../common_widgets/linkified_text.dart';
import 'package:community_connect/src/utils/responsive_ext.dart';
import '../../../utils/app_date_formatter.dart';
import '../data/community_provider.dart';

class CommunityDetailScreen extends HookConsumerWidget {
  final String communityId;
  final String communityName;
  final int initialTabIndex;

  const CommunityDetailScreen({
    super.key,
    required this.communityId,
    required this.communityName,
    this.initialTabIndex = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(
      initialLength: 2,
      initialIndex: initialTabIndex,
    );

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.indigo,
            size: 20.r,
          ),
          onPressed: () => context.pop(),
        ),
        title: TranslatedText(
          communityName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.indigo,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          labelColor: AppColors.orange,
          unselectedLabelColor: AppColors.textMuted,
          indicatorColor: AppColors.orange,
          tabs: const [
            Tab(text: 'Announcements'),
            Tab(text: 'Events'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          _AnnouncementsTab(communityId: communityId),
          _EventsTab(communityId: communityId),
        ],
      ),
    );
  }
}

class _AnnouncementsTab extends HookConsumerWidget {
  final String communityId;
  const _AnnouncementsTab({required this.communityId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsControllerProvider);
    return state.when(
      skipLoadingOnReload: true,
      skipLoadingOnRefresh: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
      data: (all) {
        final announcements = all.where((n) => n.source != 'ZINGGUP').toList();
        if (announcements.isEmpty) {
          return Center(
            child: AppRefreshIndicator(
              onRefresh: () =>
                  ref.read(notificationsControllerProvider.notifier).refresh(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 120.h),
                  const Center(
                    child: TranslatedText(
                      'No announcements yet.',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return AppRefreshIndicator(
          onRefresh: () =>
              ref.read(notificationsControllerProvider.notifier).refresh(),
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            itemCount: announcements.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final ann = announcements[index];
              return _ExpandableNotificationCard(
                key: ValueKey(ann.id),
                title: ann.title ?? 'Announcement',
                body: ann.body ?? '',
                isRead: ann.isRead,
                createdAt: ann.createdAt,
                onExpanded: () {
                  if (!ann.isRead) {
                    ref
                        .read(notificationsControllerProvider.notifier)
                        .markAsRead(ann.id);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _ExpandableNotificationCard extends HookConsumerWidget {
  final String title;
  final String body;
  final bool isRead;
  final String? createdAt;
  final VoidCallback? onExpanded;
  final Future<void> Function()? footerAction;

  const _ExpandableNotificationCard({
    super.key,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
    this.onExpanded,
    this.footerAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState(false);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: !isRead
              ? AppColors.orange.withValues(alpha: 0.5)
              : AppColors.border,
          width: !isRead ? 1.5 : 1.0,
        ),
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
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              if (!isRead)
                Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: const BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          AnimatedSize(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: LinkifiedText(
              text: body,
              maxLines: isExpanded.value ? null : 3,
              overflow: isExpanded.value ? null : TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.textDark,
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (createdAt != null)
                TranslatedText(
                  AppDateFormatter.formatRelativeTime(createdAt),
                  style: TextStyle(fontSize: 12.sp, color: AppColors.textMuted),
                )
              else
                const SizedBox.shrink(),
              if (body.isNotEmpty)
                TextButton.icon(
                  onPressed: () {
                    if (!isExpanded.value) {
                      onExpanded?.call();
                    }
                    isExpanded.value = !isExpanded.value;
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: AppColors.orangeDark,
                  ),
                  icon: Icon(
                    isExpanded.value
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 18.r,
                  ),
                  label: TranslatedText(
                    isExpanded.value ? 'Show less' : 'Show more',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          if (footerAction != null)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: InkWell(
                  onTap: footerAction,
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.orangeLight,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.orange.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.open_in_new_rounded,
                          size: 16.r,
                          color: AppColors.orangeDark,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Participate via ZiingUp',
                          style: TextStyle(
                            color: AppColors.orangeDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EventsTab extends HookConsumerWidget {
  final String communityId;
  const _EventsTab({required this.communityId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsControllerProvider);
    return state.when(
      skipLoadingOnReload: true,
      skipLoadingOnRefresh: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
      data: (all) {
        final events = all.where((n) => n.source == 'ZINGGUP').toList();
        if (events.isEmpty) {
          return Center(
            child: AppRefreshIndicator(
              onRefresh: () =>
                  ref.read(notificationsControllerProvider.notifier).refresh(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 120.h),
                  const Center(
                    child: TranslatedText(
                      'No events yet.',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return AppRefreshIndicator(
          onRefresh: () =>
              ref.read(notificationsControllerProvider.notifier).refresh(),
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            itemCount: events.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final event = events[index];
              final url = event.ziingupEventUrl;
              return _ExpandableNotificationCard(
                key: ValueKey(event.id),
                title: event.title ?? 'New Event',
                body: event.body ?? '',
                isRead: event.isRead,
                createdAt: event.createdAt,
                onExpanded: () {
                  if (!event.isRead) {
                    ref
                        .read(notificationsControllerProvider.notifier)
                        .markAsRead(event.id);
                  }
                },
                footerAction: url == null
                    ? null
                    : () async {
                        if (!event.isRead) {
                          ref
                              .read(notificationsControllerProvider.notifier)
                              .markAsRead(event.id);
                        }
                        try {
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        } catch (_) {}
                      },
              );
            },
          ),
        );
      },
    );
  }
}
