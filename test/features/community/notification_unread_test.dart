import 'package:community_connect/src/features/community/data/community_models.dart';
import 'package:community_connect/src/features/community/data/community_provider.dart';
import 'package:community_connect/src/features/community/data/community_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FakeCommunityRepository implements CommunityRepository {
  List<AppNotification> notifications;
  final List<String> markedReadIds = [];

  FakeCommunityRepository(this.notifications);

  @override
  Future<List<AppNotification>> getNotifications({String source = 'ALL'}) async {
    return notifications;
  }

  @override
  Future<void> markNotificationAsRead(String id) async {
    markedReadIds.add(id);
    notifications = notifications.map((n) {
      if (n.id == id) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('Notification Unread & Mark as Read Tests', () {
    test('AppNotification.fromJson parses isRead correctly from postman payload', () {
      final json = {
        'id': '2bb532cb-d82c-4f7c-b523-e7a48201c2c7',
        'userId': 'd4b425a1-0bd6-4f58-ab00-9dbb59c4bf10',
        'type': 'ProfileReminder',
        'source': 'SYSTEM',
        'title': 'Complete Your Profile',
        'body': 'Please complete your basic profile, job, or business details to get the most out of the community!',
        'isRead': false,
        'createdAt': '2026-09-20T00:00:13.765Z',
      };

      final notification = AppNotification.fromJson(json);
      expect(notification.id, '2bb532cb-d82c-4f7c-b523-e7a48201c2c7');
      expect(notification.title, 'Complete Your Profile');
      expect(notification.isRead, isFalse);
    });

    test('hasUnreadNotificationsProvider is true when unread items exist, false when all read', () async {
      final fakeRepo = FakeCommunityRepository([
        const AppNotification(
          id: '1',
          title: 'Complete Profile',
          isRead: false,
        ),
        const AppNotification(
          id: '2',
          title: 'Navratri Celebration',
          isRead: true,
        ),
      ]);

      final container = ProviderContainer(
        overrides: [
          communityRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );

      // Wait for notifications to load
      await container.read(notificationsControllerProvider.future);

      // Should be true because item 1 is unread
      expect(container.read(hasUnreadNotificationsProvider), isTrue);

      // Mark item 1 as read
      await container.read(notificationsControllerProvider.notifier).markAsRead('1');

      // Now all items are read -> hasUnreadNotificationsProvider must be false
      expect(container.read(hasUnreadNotificationsProvider), isFalse);
      expect(fakeRepo.markedReadIds, contains('1'));

      container.dispose();
    });

    test('hasUnreadNotificationsProvider is false when notifications list is empty', () async {
      final fakeRepo = FakeCommunityRepository([]);

      final container = ProviderContainer(
        overrides: [
          communityRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );

      await container.read(notificationsControllerProvider.future);
      expect(container.read(hasUnreadNotificationsProvider), isFalse);

      container.dispose();
    });
  });
}
