import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/translated_text.dart';
import '../data/community_provider.dart';

class CommunityDetailScreen extends HookConsumerWidget {
  final String communityId;
  final String communityName;

  const CommunityDetailScreen({
    super.key,
    required this.communityId,
    required this.communityName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.indigo, size: 20),
            onPressed: () => context.pop(),
          ),
          title: TranslatedText(
            communityName,
            style: const TextStyle(
              color: AppColors.indigo,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            labelColor: AppColors.orange,
            unselectedLabelColor: AppColors.textMuted,
            indicatorColor: AppColors.orange,
            tabs: [
              Tab(text: 'Announcements'),
              Tab(text: 'Events'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _AnnouncementsTab(communityId: communityId),
            _EventsTab(communityId: communityId),
          ],
        ),
      ),
    );
  }
}

class _AnnouncementsTab extends HookConsumerWidget {
  final String communityId;
  const _AnnouncementsTab({required this.communityId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcementsState = ref.watch(communityAnnouncementsProvider(communityId));

    return announcementsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) { String msg = 'An error occurred.'; if (error is DioException && error.response?.data != null && error.response!.data is Map) { msg = error.response!.data['message'] ?? msg; } return Center(child: Text(msg, style: const TextStyle(color: Colors.red))); },
      data: (announcements) {
        if (announcements.isEmpty) {
          return const Center(child: TranslatedText('No announcements available.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: announcements.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final ann = announcements[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TranslatedText(
                    ann.title ?? 'Announcement',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TranslatedText(
                    ann.content ?? '',
                    style: const TextStyle(color: AppColors.textDark, fontSize: 14),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _EventsTab extends HookConsumerWidget {
  final String communityId;
  const _EventsTab({required this.communityId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsState = ref.watch(communityEventsProvider(communityId));

    return eventsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) { String msg = 'An error occurred.'; if (error is DioException && error.response?.data != null && error.response!.data is Map) { msg = error.response!.data['message'] ?? msg; } return Center(child: Text(msg, style: const TextStyle(color: Colors.red))); },
      data: (events) {
        if (events.isEmpty) {
          return const Center(child: TranslatedText('No events available.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: events.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final event = events[index];
            
            String formattedDate = event.eventDate ?? '';
            if (formattedDate.isNotEmpty) {
              try {
                final dt = DateTime.parse(formattedDate).toLocal();
                final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                final ampm = dt.hour >= 12 ? 'PM' : 'AM';
                final hour = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);
                final min = dt.minute.toString().padLeft(2, '0');
                formattedDate = '${months[dt.month - 1]} ${dt.day}, ${dt.year} • $hour:$min $ampm';
              } catch (_) {}
            }

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TranslatedText(
                    event.title ?? 'Event',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  if (event.eventDate != null)
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14, color: AppColors.orange),
                        const SizedBox(width: 6),
                        TranslatedText(
                          formattedDate,
                          style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                        ),
                      ],
                    ),
                  if (event.location != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: AppColors.orange),
                        const SizedBox(width: 6),
                        TranslatedText(
                          event.location!,
                          style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 8),
                  TranslatedText(
                    event.description ?? '',
                    style: const TextStyle(color: AppColors.textDark, fontSize: 14),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
