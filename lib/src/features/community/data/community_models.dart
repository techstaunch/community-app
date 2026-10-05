import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_models.freezed.dart';
part 'community_models.g.dart';

@freezed
abstract class Community with _$Community {
  const factory Community({
    String? id,
    String? name,
    String? description,
    String? logoUrl,
    String? inviteCode,
    String? membershipStatus,
  }) = _Community;

  factory Community.fromJson(Map<String, dynamic> json) => _$CommunityFromJson(json);
}

@freezed
abstract class CommunityMembership with _$CommunityMembership {
  const factory CommunityMembership({
    String? id,
    String? communityId,
    String? userId,
    String? role,
    String? status,
    Community? community,
  }) = _CommunityMembership;

  factory CommunityMembership.fromJson(Map<String, dynamic> json) => _$CommunityMembershipFromJson(json);
}

@freezed
abstract class CommunityMember with _$CommunityMember {
  const factory CommunityMember({
    String? membershipId,
    String? userId,
    String? fullName,
    String? role,
    String? status,
  }) = _CommunityMember;

  factory CommunityMember.fromJson(Map<String, dynamic> json) => _$CommunityMemberFromJson(json);
}

@freezed
abstract class Announcement with _$Announcement {
  const factory Announcement({
    String? id,
    String? communityId,
    String? title,
    String? content,
    String? createdAt,
  }) = _Announcement;

  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);
}

@freezed
abstract class Event with _$Event {
  const factory Event({
    String? id,
    String? communityId,
    String? title,
    String? description,
    String? eventDate,
    String? location,
    String? ziingupEventId,
    String? ziingupEventUrl,
    String? createdAt,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

class AppNotification {
  final String id;
  final String? userId;
  final String? type;
  final String? source;
  final String? title;
  final String? body;
  final bool isRead;
  final String? createdAt;

  const AppNotification({
    required this.id,
    this.userId,
    this.type,
    this.source,
    this.title,
    this.body,
    this.isRead = false,
    this.createdAt,
  });

  String? get content => body;
  String? get description => body;

  AppNotification copyWith({
    String? id,
    String? userId,
    String? type,
    String? source,
    String? title,
    String? body,
    bool? isRead,
    String? createdAt,
  }) {
    return AppNotification(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      source: source ?? this.source,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String? get ziingupEventUrl {
    if (body == null) return null;
    final match = RegExp(r'https?://[^\s]+').firstMatch(body!);
    return match?.group(0);
  }

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString(),
      type: json['type']?.toString(),
      source: json['source']?.toString(),
      title: json['title']?.toString(),
      body: json['body']?.toString(),
      isRead: json['isRead'] == true,
      createdAt: json['createdAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'type': type,
    'source': source,
    'title': title,
    'body': body,
    'isRead': isRead,
    'createdAt': createdAt,
  };
}
