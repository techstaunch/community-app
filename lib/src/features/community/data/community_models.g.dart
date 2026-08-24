// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Community _$CommunityFromJson(Map<String, dynamic> json) => _Community(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  logoUrl: json['logoUrl'] as String?,
  inviteCode: json['inviteCode'] as String?,
);

Map<String, dynamic> _$CommunityToJson(_Community instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'logoUrl': instance.logoUrl,
      'inviteCode': instance.inviteCode,
    };

_CommunityMember _$CommunityMemberFromJson(Map<String, dynamic> json) =>
    _CommunityMember(
      membershipId: json['membershipId'] as String?,
      userId: json['userId'] as String?,
      fullName: json['fullName'] as String?,
      role: json['role'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CommunityMemberToJson(_CommunityMember instance) =>
    <String, dynamic>{
      'membershipId': instance.membershipId,
      'userId': instance.userId,
      'fullName': instance.fullName,
      'role': instance.role,
      'status': instance.status,
    };
