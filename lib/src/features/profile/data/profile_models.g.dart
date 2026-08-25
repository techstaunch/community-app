// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  id: json['id'] as String?,
  mobileNumber: json['mobileNumber'] as String?,
  email: json['email'] as String?,
  isVerified: json['isVerified'] as bool?,
  isActive: json['isActive'] as bool?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  profile: json['profile'] == null
      ? null
      : CoreProfile.fromJson(json['profile'] as Map<String, dynamic>),
  job: json['job'] == null
      ? null
      : JobDetails.fromJson(json['job'] as Map<String, dynamic>),
  business: json['business'] == null
      ? null
      : BusinessDetails.fromJson(json['business'] as Map<String, dynamic>),
  privacySettings: json['privacySettings'] == null
      ? null
      : PrivacySettings.fromJson(
          json['privacySettings'] as Map<String, dynamic>,
        ),
  qrCode: json['qrCode'] == null
      ? null
      : QrCodeDetails.fromJson(json['qrCode'] as Map<String, dynamic>),
  ownedFamilyMembers: (json['ownedFamilyMembers'] as List<dynamic>?)
      ?.map((e) => OwnedFamilyMember.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'isVerified': instance.isVerified,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'profile': instance.profile,
      'job': instance.job,
      'business': instance.business,
      'privacySettings': instance.privacySettings,
      'qrCode': instance.qrCode,
      'ownedFamilyMembers': instance.ownedFamilyMembers,
    };

_CoreProfile _$CoreProfileFromJson(Map<String, dynamic> json) => _CoreProfile(
  id: json['id'] as String?,
  userId: json['userId'] as String?,
  fullName: json['fullName'] as String?,
  dob: json['dob'] as String?,
  gender: json['gender'] as String?,
  profilePhotoUrl: json['profilePhotoUrl'] as String?,
  city: json['city'] as String?,
  nativeVillage: json['nativeVillage'] as String?,
  surname: json['surname'] as String?,
  gotra: json['gotra'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$CoreProfileToJson(_CoreProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'fullName': instance.fullName,
      'dob': instance.dob,
      'gender': instance.gender,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'city': instance.city,
      'nativeVillage': instance.nativeVillage,
      'surname': instance.surname,
      'gotra': instance.gotra,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_JobDetails _$JobDetailsFromJson(Map<String, dynamic> json) => _JobDetails(
  id: json['id'] as String?,
  userId: json['userId'] as String?,
  companyName: json['companyName'] as String?,
  designation: json['designation'] as String?,
  industry: json['industry'] as String?,
  yearsOfExperience: (json['yearsOfExperience'] as num?)?.toInt(),
);

Map<String, dynamic> _$JobDetailsToJson(_JobDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'companyName': instance.companyName,
      'designation': instance.designation,
      'industry': instance.industry,
      'yearsOfExperience': instance.yearsOfExperience,
    };

_BusinessDetails _$BusinessDetailsFromJson(Map<String, dynamic> json) =>
    _BusinessDetails(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      businessName: json['businessName'] as String?,
      category: json['category'] as String?,
      productsServices: json['productsServices'] as String?,
      address: json['address'] as String?,
      website: json['website'] as String?,
    );

Map<String, dynamic> _$BusinessDetailsToJson(_BusinessDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'businessName': instance.businessName,
      'category': instance.category,
      'productsServices': instance.productsServices,
      'address': instance.address,
      'website': instance.website,
    };

_PrivacySettings _$PrivacySettingsFromJson(Map<String, dynamic> json) =>
    _PrivacySettings(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      showMobileNumber: json['showMobileNumber'] as bool?,
      showEmail: json['showEmail'] as bool?,
      showFamilyInfo: json['showFamilyInfo'] as bool?,
      showBusinessInfo: json['showBusinessInfo'] as bool?,
      showProfessionalInfo: json['showProfessionalInfo'] as bool?,
    );

Map<String, dynamic> _$PrivacySettingsToJson(_PrivacySettings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'showMobileNumber': instance.showMobileNumber,
      'showEmail': instance.showEmail,
      'showFamilyInfo': instance.showFamilyInfo,
      'showBusinessInfo': instance.showBusinessInfo,
      'showProfessionalInfo': instance.showProfessionalInfo,
    };

_QrCodeDetails _$QrCodeDetailsFromJson(Map<String, dynamic> json) =>
    _QrCodeDetails(
      id: json['id'] as String?,
      code: json['code'] as String?,
      qrImageUrl: json['qrImageUrl'] as String?,
    );

Map<String, dynamic> _$QrCodeDetailsToJson(_QrCodeDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'qrImageUrl': instance.qrImageUrl,
    };

_OwnedFamilyMember _$OwnedFamilyMemberFromJson(Map<String, dynamic> json) =>
    _OwnedFamilyMember(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] as String?,
      relationshipType: json['relationshipType'] as String?,
      isDeceased: json['isDeceased'] as bool?,
      photoUrl: json['photoUrl'] as String?,
      linkedUserId: json['linkedUserId'] as String?,
    );

Map<String, dynamic> _$OwnedFamilyMemberToJson(_OwnedFamilyMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'dob': instance.dob,
      'relationshipType': instance.relationshipType,
      'isDeceased': instance.isDeceased,
      'photoUrl': instance.photoUrl,
      'linkedUserId': instance.linkedUserId,
    };
