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
  }) = _Community;

  factory Community.fromJson(Map<String, dynamic> json) => _$CommunityFromJson(json);
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
    String? createdAt,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
