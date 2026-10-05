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
  isApproved: json['isApproved'] as bool?,
  membershipStatus: json['membershipStatus'] as String?,
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
  qrCode: readQrCodeDetails(json, 'qrCode') == null
      ? null
      : QrCodeDetails.fromJson(
          readQrCodeDetails(json, 'qrCode') as Map<String, dynamic>,
        ),
  pdfUrl: readPdfUrl(json, 'pdfUrl') as String?,
  ownedFamilyMembers:
      (readFamilyMembers(json, 'ownedFamilyMembers') as List<dynamic>?)
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
      'isApproved': instance.isApproved,
      'membershipStatus': instance.membershipStatus,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'profile': instance.profile,
      'job': instance.job,
      'business': instance.business,
      'privacySettings': instance.privacySettings,
      'qrCode': instance.qrCode,
      'pdfUrl': instance.pdfUrl,
      'ownedFamilyMembers': instance.ownedFamilyMembers,
    };

_CoreProfile _$CoreProfileFromJson(Map<String, dynamic> json) => _CoreProfile(
  id: json['id'] as String?,
  userId: json['userId'] as String?,
  title: json['title'] as String?,
  fullName: json['fullName'] as String?,
  dob: json['dob'] as String?,
  gender: json['gender'] as String?,
  profilePhotoUrl: json['profilePhotoUrl'] as String?,
  state: json['state'] as String?,
  city: json['city'] as String?,
  nativeVillage: json['nativeVillage'] as String?,
  surname: json['surname'] as String?,
  gotra: json['gotra'] as String?,
  address: json['address'] as String?,
  bio: json['bio'] as String?,
  height: json['height'] as String?,
  education: json['education'] as String?,
  instagram: json['instagram'] as String?,
  facebook: json['facebook'] as String?,
  linkedin: json['linkedin'] as String?,
  twitter: json['twitter'] as String?,
  subCaste: json['subCaste'] as String?,
  timeOfBirth: json['timeOfBirth'] as String?,
  disability: json['disability'] as String?,
  manglik: json['manglik'] as String?,
  maternalGrandfather: json['maternalGrandfather'] as String?,
  maternalGrandmother: json['maternalGrandmother'] as String?,
  maternalSurname: json['maternalSurname'] as String?,
  maternalGotra: json['maternalGotra'] as String?,
  maternalVillage: json['maternalVillage'] as String?,
  biodataUrl: readPdfUrl(json, 'biodataUrl') as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$CoreProfileToJson(_CoreProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'fullName': instance.fullName,
      'dob': instance.dob,
      'gender': instance.gender,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'state': instance.state,
      'city': instance.city,
      'nativeVillage': instance.nativeVillage,
      'surname': instance.surname,
      'gotra': instance.gotra,
      'address': instance.address,
      'bio': instance.bio,
      'height': instance.height,
      'education': instance.education,
      'instagram': instance.instagram,
      'facebook': instance.facebook,
      'linkedin': instance.linkedin,
      'twitter': instance.twitter,
      'subCaste': instance.subCaste,
      'timeOfBirth': instance.timeOfBirth,
      'disability': instance.disability,
      'manglik': instance.manglik,
      'maternalGrandfather': instance.maternalGrandfather,
      'maternalGrandmother': instance.maternalGrandmother,
      'maternalSurname': instance.maternalSurname,
      'maternalGotra': instance.maternalGotra,
      'maternalVillage': instance.maternalVillage,
      'biodataUrl': instance.biodataUrl,
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
  state: json['state'] as String?,
  city: json['city'] as String?,
);

Map<String, dynamic> _$JobDetailsToJson(_JobDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'companyName': instance.companyName,
      'designation': instance.designation,
      'industry': instance.industry,
      'yearsOfExperience': instance.yearsOfExperience,
      'state': instance.state,
      'city': instance.city,
    };

_BusinessDetails _$BusinessDetailsFromJson(Map<String, dynamic> json) =>
    _BusinessDetails(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      businessName: json['businessName'] as String?,
      category: json['category'] as String?,
      productsServices: json['productsServices'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      website: json['website'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$BusinessDetailsToJson(_BusinessDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'businessName': instance.businessName,
      'category': instance.category,
      'productsServices': instance.productsServices,
      'state': instance.state,
      'city': instance.city,
      'website': instance.website,
      'role': instance.role,
    };

_PrivacySettings _$PrivacySettingsFromJson(Map<String, dynamic> json) =>
    _PrivacySettings(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      showMobileNumber: json['showMobileNumber'] as bool?,
      showEmail: json['showEmail'] as bool?,
      showGotra: json['showGotra'] as bool?,
      showFamilyInfo: json['showFamilyInfo'] as bool?,
      showMaternalInfo: json['showMaternalInfo'] as bool?,
      showBusinessInfo: json['showBusinessInfo'] as bool?,
      showProfessionalInfo: json['showProfessionalInfo'] as bool?,
      showInstagram: json['showInstagram'] as bool?,
      showFacebook: json['showFacebook'] as bool?,
      showLinkedin: json['showLinkedin'] as bool?,
      showTwitter: json['showTwitter'] as bool?,
      isFindmatch: json['isFindmatch'] as bool?,
    );

Map<String, dynamic> _$PrivacySettingsToJson(_PrivacySettings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'showMobileNumber': instance.showMobileNumber,
      'showEmail': instance.showEmail,
      'showGotra': instance.showGotra,
      'showFamilyInfo': instance.showFamilyInfo,
      'showMaternalInfo': instance.showMaternalInfo,
      'showBusinessInfo': instance.showBusinessInfo,
      'showProfessionalInfo': instance.showProfessionalInfo,
      'showInstagram': instance.showInstagram,
      'showFacebook': instance.showFacebook,
      'showLinkedin': instance.showLinkedin,
      'showTwitter': instance.showTwitter,
      'isFindmatch': instance.isFindmatch,
    };

_QrCodeDetails _$QrCodeDetailsFromJson(Map<String, dynamic> json) =>
    _QrCodeDetails(
      id: json['id'] as String?,
      code: json['code'] as String?,
      qrImageUrl: readQrUrl(json, 'qrImageUrl') as String?,
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
      qrImageUrl: json['qrImageUrl'] as String?,
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
      'qrImageUrl': instance.qrImageUrl,
      'linkedUserId': instance.linkedUserId,
    };
