import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_models.freezed.dart';
part 'family_models.g.dart';

@freezed
abstract class FamilyMember with _$FamilyMember {
  const factory FamilyMember({
    String? id,
    String? fullName,
    String? gender,
    String? dob,
    String? relationshipType,
    bool? isDeceased,
    String? photoUrl,
    String? linkedMobile,
  }) = _FamilyMember;

  factory FamilyMember.fromJson(Map<String, dynamic> json) => _$FamilyMemberFromJson(json);
}

@freezed
abstract class FamilyTreeNode with _$FamilyTreeNode {
  const factory FamilyTreeNode({
    String? id,
    String? fullName,
    String? relationshipType,
    bool? isDeceased,
    String? photoUrl,
    @Default([]) List<FamilyTreeNode> children,
  }) = _FamilyTreeNode;

  factory FamilyTreeNode.fromJson(Map<String, dynamic> json) => _$FamilyTreeNodeFromJson(json);
}
