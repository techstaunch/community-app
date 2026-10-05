import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/notifications/local_notification_service.dart';
import 'community_repository.dart';
import 'community_models.dart';

part 'community_provider.g.dart';

@riverpod
class MyCommunitiesController extends _$MyCommunitiesController {
  @override
  FutureOr<List<Community>> build() async {
    return _fetchMemberships();
  }

  Future<List<Community>> _fetchMemberships() async {
    final repo = ref.read(communityRepositoryProvider);
    return await repo.getMyMemberships();
  }

  Future<void> joinCommunity(String inviteCode) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(communityRepositoryProvider);
      await repo.joinCommunity(inviteCode);
      state = AsyncValue.data(await _fetchMemberships());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}



final internalAnnouncementsProvider = FutureProvider<List<AppNotification>>((
  ref,
) async {
  final repo = ref.watch(communityRepositoryProvider);
  final notifications = await repo.getNotifications(source: 'INTERNAL');
  await LocalNotificationService.showUnread(notifications);
  return notifications;
});

final zingupEventsProvider = FutureProvider<List<AppNotification>>((ref) async {
  final repo = ref.watch(communityRepositoryProvider);
  final notifications = await repo.getNotifications(source: 'ZINGGUP');
  await LocalNotificationService.showUnread(notifications);
  return notifications;
});

class NotificationsController extends AsyncNotifier<List<AppNotification>> {
  @override
  FutureOr<List<AppNotification>> build() async {
    final repo = ref.watch(communityRepositoryProvider);
    final notifications = await repo.getNotifications(source: 'ALL');
    await LocalNotificationService.showUnread(notifications);
    return notifications;
  }

  Future<void> markAsRead(String id) async {
    final previousState = state;
    if (state.hasValue) {
      final updatedList = state.value!.map((n) {
        if (n.id == id) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();
      state = AsyncValue.data(updatedList);
    }

    try {
      final repo = ref.read(communityRepositoryProvider);
      await repo.markNotificationAsRead(id);
      ref.invalidate(internalAnnouncementsProvider);
      ref.invalidate(zingupEventsProvider);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> refresh() async {
    final repo = ref.read(communityRepositoryProvider);
    final freshList = await repo.getNotifications(source: 'ALL');
    await LocalNotificationService.showUnread(freshList);
    state = AsyncValue.data(freshList);
  }
}

final notificationsControllerProvider =
    AsyncNotifierProvider<NotificationsController, List<AppNotification>>(
      NotificationsController.new,
    );

final allNotificationsProvider = notificationsControllerProvider;

final hasUnreadNotificationsProvider = Provider<bool>((ref) {
  final notificationsAsync = ref.watch(notificationsControllerProvider);
  return notificationsAsync.maybeWhen(
    data: (notifications) => notifications.any((n) => !n.isRead),
    orElse: () => false,
  );
});

@riverpod
Future<String> currentUserMembershipStatus(Ref ref) async {
  try {
    final communities = await ref.watch(myCommunitiesControllerProvider.future);
    if (communities.isEmpty) {
      return 'Pending';
    }
    for (final c in communities) {
      final status = c.membershipStatus?.toLowerCase() ?? '';
      if (status == 'approved') {
        return 'Approved';
      }
    }
    for (final c in communities) {
      final status = c.membershipStatus?.toLowerCase() ?? '';
      if (status == 'pending') {
        return 'Pending';
      }
    }
    return communities.first.membershipStatus ?? 'Pending';
  } catch (_) {
    return 'Pending';
  }
}
