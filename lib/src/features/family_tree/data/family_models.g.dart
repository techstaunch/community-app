// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FamilyMember _$FamilyMemberFromJson(Map<String, dynamic> json) =>
    _FamilyMember(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      relationshipType: json['relationshipType'] as String?,
      isDeceased: json['isDeceased'] as bool?,
      photoUrl: json['photoUrl'] as String?,
      linkedMobile: json['linkedMobile'] as String?,
    );

Map<String, dynamic> _$FamilyMemberToJson(_FamilyMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'dob': instance.dob,
      'relationshipType': instance.relationshipType,
      'isDeceased': instance.isDeceased,
      'photoUrl': instance.photoUrl,
      'linkedMobile': instance.linkedMobile,
    };

_FamilyTreeNode _$FamilyTreeNodeFromJson(Map<String, dynamic> json) =>
    _FamilyTreeNode(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      relationshipType: json['relationshipType'] as String?,
      isDeceased: json['isDeceased'] as bool?,
      photoUrl: json['photoUrl'] as String?,
      children:
          (json['children'] as List<dynamic>?)
              ?.map((e) => FamilyTreeNode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FamilyTreeNodeToJson(_FamilyTreeNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'relationshipType': instance.relationshipType,
      'isDeceased': instance.isDeceased,
      'photoUrl': instance.photoUrl,
      'children': instance.children,
    };
