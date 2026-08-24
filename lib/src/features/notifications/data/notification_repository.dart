import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import 'notification_models.dart';

part 'notification_repository.g.dart';

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepository(ref.watch(apiClientProvider));
}

class NotificationRepository {
  final Dio _dio;

  NotificationRepository(this._dio);

  Future<List<AppNotification>> getNotifications() async {
    final response = await _dio.get(ApiEndpoints.notifications);
    final data = response.data['data'] as List;
    return data.map((e) => AppNotification.fromJson(e)).toList();
  }

  Future<void> markAsRead(String id) async {
    await _dio.post('${ApiEndpoints.notifications}/$id/read');
  }
}
