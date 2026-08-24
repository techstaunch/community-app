import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'notification_repository.dart';
import 'notification_models.dart';

part 'notification_provider.g.dart';

@riverpod
class NotificationController extends _$NotificationController {
  @override
  FutureOr<List<AppNotification>> build() async {
    return _fetchNotifications();
  }

  Future<List<AppNotification>> _fetchNotifications() async {
    final repo = ref.read(notificationRepositoryProvider);
    return await repo.getNotifications();
  }

  Future<void> markAsRead(String id) async {
    final repo = ref.read(notificationRepositoryProvider);
    await repo.markAsRead(id);
    // Refresh list locally
    final currentList = state.value ?? [];
    state = AsyncValue.data(
      currentList.map((n) {
        if (n.id == id) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList(),
    );
  }
}
