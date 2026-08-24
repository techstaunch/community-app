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
