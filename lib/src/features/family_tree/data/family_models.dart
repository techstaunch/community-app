import 'package:freezed_annotation/freezed_annotation.dart';
import '../../profile/data/profile_models.dart';

part 'family_models.freezed.dart';
part 'family_models.g.dart';

@freezed
abstract class FamilyMember with _$FamilyMember {
  const factory FamilyMember({
    String? id,
    String? title,
    String? fullName,
    String? gender,
    String? dob,
    @JsonKey(readValue: readRelationship) String? relationshipType,
    String? directRelationship,
    String? relationshipToViewer,
    bool? isDeceased,
    bool? isMinor,
    bool? isRegisteredUser,
    String? photoUrl,
    String? qrImageUrl,
    String? linkedMobile,
    String? linkedUserId,
    String? ownerUserId,
    bool? privacyProtected,
    PrivacySettings? privacySettings,
    String? state,
    String? city,
    String? nativeVillage,
    String? surname,
    String? gotra,
    String? subCaste,
    String? timeOfBirth,
    String? disability,
    String? manglik,
    String? maternalSurname,
    String? maternalGotra,
    String? address,
    String? bio,
    String? education,
    String? email,
    String? height,
    String? instagram,
    String? facebook,
    String? linkedin,
    String? twitter,
    Map<String, dynamic>? job,
    Map<String, dynamic>? business,
  }) = _FamilyMember;

  factory FamilyMember.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberFromJson(json);
}

Object? readRelationship(Map json, String key) {
  return json['relationshipType'] ??
      json['relationshipToViewer'] ??
      json['directRelationship'];
}

Object? readUserId(Map json, String key) {
  if (json['linkedUserId'] != null) return json['linkedUserId'];
  if (json['userId'] != null) return json['userId'];
  if (json['linkedUser'] != null) {
    if (json['linkedUser'] is Map) {
      return json['linkedUser']['_id'] ?? json['linkedUser']['id'];
    } else if (json['linkedUser'] is String) {
      return json['linkedUser'];
    }
  }
  if (json['isRegisteredUser'] == true && json['id'] != null) {
    return json['id'];
  }
  return null;
}

@freezed
abstract class FamilyTreeNode with _$FamilyTreeNode {
  const factory FamilyTreeNode({
    String? id,
    String? title,
    String? fullName,
    String? gender,
    String? dob,
    @JsonKey(readValue: readRelationship) String? relationshipType,
    String? directRelationship,
    String? relationshipToViewer,
    bool? isDeceased,
    bool? isMinor,
    bool? isRegisteredUser,
    String? photoUrl,
    String? qrImageUrl,
    String? linkedMobile,
    String? ownerUserId,
    @JsonKey(readValue: readUserId) String? linkedUserId,
    bool? privacyProtected,
    PrivacySettings? privacySettings,
    String? state,
    String? city,
    String? nativeVillage,
    String? surname,
    String? gotra,
    String? subCaste,
    String? timeOfBirth,
    String? disability,
    String? manglik,
    String? maternalSurname,
    String? maternalGotra,
    String? address,
    String? bio,
    String? education,
    String? email,
    String? height,
    String? instagram,
    String? facebook,
    String? linkedin,
    String? twitter,
    Map<String, dynamic>? job,
    Map<String, dynamic>? business,
    @Default([]) List<FamilyTreeNode> parents,
    @Default([]) List<FamilyTreeNode> spouses,
    @Default([]) List<FamilyTreeNode> siblings,
    @Default([]) List<FamilyTreeNode> children,
  }) = _FamilyTreeNode;

  factory FamilyTreeNode.fromJson(Map<String, dynamic> json) =>
      _$FamilyTreeNodeFromJson(json);
}
