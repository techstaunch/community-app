// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FamilyMember _$FamilyMemberFromJson(Map<String, dynamic> json) =>
    _FamilyMember(
      id: json['id'] as String?,
      title: json['title'] as String?,
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      relationshipType: readRelationship(json, 'relationshipType') as String?,
      directRelationship: json['directRelationship'] as String?,
      relationshipToViewer: json['relationshipToViewer'] as String?,
      isDeceased: json['isDeceased'] as bool?,
      isMinor: json['isMinor'] as bool?,
      isRegisteredUser: json['isRegisteredUser'] as bool?,
      photoUrl: json['photoUrl'] as String?,
      qrImageUrl: json['qrImageUrl'] as String?,
      linkedMobile: json['linkedMobile'] as String?,
      linkedUserId: json['linkedUserId'] as String?,
      ownerUserId: json['ownerUserId'] as String?,
      privacyProtected: json['privacyProtected'] as bool?,
      privacySettings: json['privacySettings'] == null
          ? null
          : PrivacySettings.fromJson(
              json['privacySettings'] as Map<String, dynamic>,
            ),
      state: json['state'] as String?,
      city: json['city'] as String?,
      nativeVillage: json['nativeVillage'] as String?,
      surname: json['surname'] as String?,
      gotra: json['gotra'] as String?,
      subCaste: json['subCaste'] as String?,
      timeOfBirth: json['timeOfBirth'] as String?,
      disability: json['disability'] as String?,
      manglik: json['manglik'] as String?,
      maternalSurname: json['maternalSurname'] as String?,
      maternalGotra: json['maternalGotra'] as String?,
      address: json['address'] as String?,
      bio: json['bio'] as String?,
      education: json['education'] as String?,
      email: json['email'] as String?,
      height: json['height'] as String?,
      instagram: json['instagram'] as String?,
      facebook: json['facebook'] as String?,
      linkedin: json['linkedin'] as String?,
      twitter: json['twitter'] as String?,
      job: json['job'] as Map<String, dynamic>?,
      business: json['business'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$FamilyMemberToJson(_FamilyMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'dob': instance.dob,
      'relationshipType': instance.relationshipType,
      'directRelationship': instance.directRelationship,
      'relationshipToViewer': instance.relationshipToViewer,
      'isDeceased': instance.isDeceased,
      'isMinor': instance.isMinor,
      'isRegisteredUser': instance.isRegisteredUser,
      'photoUrl': instance.photoUrl,
      'qrImageUrl': instance.qrImageUrl,
      'linkedMobile': instance.linkedMobile,
      'linkedUserId': instance.linkedUserId,
      'ownerUserId': instance.ownerUserId,
      'privacyProtected': instance.privacyProtected,
      'privacySettings': instance.privacySettings,
      'state': instance.state,
      'city': instance.city,
      'nativeVillage': instance.nativeVillage,
      'surname': instance.surname,
      'gotra': instance.gotra,
      'subCaste': instance.subCaste,
      'timeOfBirth': instance.timeOfBirth,
      'disability': instance.disability,
      'manglik': instance.manglik,
      'maternalSurname': instance.maternalSurname,
      'maternalGotra': instance.maternalGotra,
      'address': instance.address,
      'bio': instance.bio,
      'education': instance.education,
      'email': instance.email,
      'height': instance.height,
      'instagram': instance.instagram,
      'facebook': instance.facebook,
      'linkedin': instance.linkedin,
      'twitter': instance.twitter,
      'job': instance.job,
      'business': instance.business,
    };

_FamilyTreeNode _$FamilyTreeNodeFromJson(Map<String, dynamic> json) =>
    _FamilyTreeNode(
      id: json['id'] as String?,
      title: json['title'] as String?,
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      relationshipType: readRelationship(json, 'relationshipType') as String?,
      directRelationship: json['directRelationship'] as String?,
      relationshipToViewer: json['relationshipToViewer'] as String?,
      isDeceased: json['isDeceased'] as bool?,
      isMinor: json['isMinor'] as bool?,
      isRegisteredUser: json['isRegisteredUser'] as bool?,
      photoUrl: json['photoUrl'] as String?,
      qrImageUrl: json['qrImageUrl'] as String?,
      linkedMobile: json['linkedMobile'] as String?,
      ownerUserId: json['ownerUserId'] as String?,
      linkedUserId: readUserId(json, 'linkedUserId') as String?,
      privacyProtected: json['privacyProtected'] as bool?,
      privacySettings: json['privacySettings'] == null
          ? null
          : PrivacySettings.fromJson(
              json['privacySettings'] as Map<String, dynamic>,
            ),
      state: json['state'] as String?,
      city: json['city'] as String?,
      nativeVillage: json['nativeVillage'] as String?,
      surname: json['surname'] as String?,
      gotra: json['gotra'] as String?,
      subCaste: json['subCaste'] as String?,
      timeOfBirth: json['timeOfBirth'] as String?,
      disability: json['disability'] as String?,
      manglik: json['manglik'] as String?,
      maternalSurname: json['maternalSurname'] as String?,
      maternalGotra: json['maternalGotra'] as String?,
      address: json['address'] as String?,
      bio: json['bio'] as String?,
      education: json['education'] as String?,
      email: json['email'] as String?,
      height: json['height'] as String?,
      instagram: json['instagram'] as String?,
      facebook: json['facebook'] as String?,
      linkedin: json['linkedin'] as String?,
      twitter: json['twitter'] as String?,
      job: json['job'] as Map<String, dynamic>?,
      business: json['business'] as Map<String, dynamic>?,
      parents:
          (json['parents'] as List<dynamic>?)
              ?.map((e) => FamilyTreeNode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      spouses:
          (json['spouses'] as List<dynamic>?)
              ?.map((e) => FamilyTreeNode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      siblings:
          (json['siblings'] as List<dynamic>?)
              ?.map((e) => FamilyTreeNode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      children:
          (json['children'] as List<dynamic>?)
              ?.map((e) => FamilyTreeNode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FamilyTreeNodeToJson(_FamilyTreeNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'dob': instance.dob,
      'relationshipType': instance.relationshipType,
      'directRelationship': instance.directRelationship,
      'relationshipToViewer': instance.relationshipToViewer,
      'isDeceased': instance.isDeceased,
      'isMinor': instance.isMinor,
      'isRegisteredUser': instance.isRegisteredUser,
      'photoUrl': instance.photoUrl,
      'qrImageUrl': instance.qrImageUrl,
      'linkedMobile': instance.linkedMobile,
      'ownerUserId': instance.ownerUserId,
      'linkedUserId': instance.linkedUserId,
      'privacyProtected': instance.privacyProtected,
      'privacySettings': instance.privacySettings,
      'state': instance.state,
      'city': instance.city,
      'nativeVillage': instance.nativeVillage,
      'surname': instance.surname,
      'gotra': instance.gotra,
      'subCaste': instance.subCaste,
      'timeOfBirth': instance.timeOfBirth,
      'disability': instance.disability,
      'manglik': instance.manglik,
      'maternalSurname': instance.maternalSurname,
      'maternalGotra': instance.maternalGotra,
      'address': instance.address,
      'bio': instance.bio,
      'education': instance.education,
      'email': instance.email,
      'height': instance.height,
      'instagram': instance.instagram,
      'facebook': instance.facebook,
      'linkedin': instance.linkedin,
      'twitter': instance.twitter,
      'job': instance.job,
      'business': instance.business,
      'parents': instance.parents,
      'spouses': instance.spouses,
      'siblings': instance.siblings,
      'children': instance.children,
    };
