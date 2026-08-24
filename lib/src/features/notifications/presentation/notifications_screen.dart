import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../theme/app_theme.dart';
import '../../../common_widgets/custom_buttons.dart';
import 'package:community_connect/src/common_widgets/translated_text.dart';
import '../data/notification_provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  CustomBackButton(
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: 16),
                  TranslatedText(
                    'Notifications',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 22,
                          color: AppColors.indigo,
                        ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final notificationsState = ref.watch(notificationControllerProvider);

                  return notificationsState.when(
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(child: Text('Error: $err')),
                    data: (notifications) {
                      if (notifications.isEmpty) {
                        return const Center(child: TranslatedText('No notifications', style: TextStyle(color: AppColors.textMuted)));
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          final notification = notifications[index];

                          if (notification.title?.toLowerCase().contains('request') == true) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildRequestCard(
                                notification.title ?? 'Request',
                                notification.message ?? '',
                                'Recently', // You'd format notification.createdAt here
                              ),
                            );
                          }

                          return _buildNotificationCard(
                            Icons.notifications,
                            AppColors.indigo,
                            notification.title ?? 'Notification',
                            notification.message ?? '',
                            'Recently',
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCard(String title, String desc, String time) {
    return Container(
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
              TranslatedText(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              TranslatedText(
                time,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TranslatedText(
            desc,
            style: const TextStyle(fontSize: 13, color: AppColors.textMid),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: 'Accept',
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinePrimaryButton(
                  text: 'Decline',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
    IconData icon,
    Color color,
    String title,
    String desc,
    String time,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TranslatedText(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.textDark,
                      ),
                    ),
                    TranslatedText(
                      time,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                TranslatedText(
                  desc,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMid,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
