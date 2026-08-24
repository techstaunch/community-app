import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_models.freezed.dart';
part 'notification_models.g.dart';

@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    String? id,
    String? title,
    String? message,
    bool? isRead,
    String? createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
}
