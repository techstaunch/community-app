import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    String? id,
    String? mobileNumber,
    String? email,
    bool? isVerified,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    CoreProfile? profile,
    JobDetails? job,
    BusinessDetails? business,
    PrivacySettings? privacySettings,
    QrCodeDetails? qrCode,
    List<OwnedFamilyMember>? ownedFamilyMembers,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

@freezed
abstract class CoreProfile with _$CoreProfile {
  const factory CoreProfile({
    String? id,
    String? userId,
    String? fullName,
    String? dob,
    String? gender,
    String? profilePhotoUrl,
    String? city,
    String? nativeVillage,
    String? surname,
    String? gotra,
    String? createdAt,
    String? updatedAt,
  }) = _CoreProfile;

  factory CoreProfile.fromJson(Map<String, dynamic> json) => _$CoreProfileFromJson(json);
}

@freezed
abstract class JobDetails with _$JobDetails {
  const factory JobDetails({
    String? id,
    String? userId,
    String? companyName,
    String? designation,
    String? industry,
    int? yearsOfExperience,
  }) = _JobDetails;

  factory JobDetails.fromJson(Map<String, dynamic> json) => _$JobDetailsFromJson(json);
}

@freezed
abstract class BusinessDetails with _$BusinessDetails {
  const factory BusinessDetails({
    String? id,
    String? userId,
    String? businessName,
    String? category,
    String? productsServices,
    String? address,
    String? website,
  }) = _BusinessDetails;

  factory BusinessDetails.fromJson(Map<String, dynamic> json) => _$BusinessDetailsFromJson(json);
}

@freezed
abstract class PrivacySettings with _$PrivacySettings {
  const factory PrivacySettings({
    String? id,
    String? userId,
    bool? showMobileNumber,
    bool? showEmail,
    bool? showFamilyInfo,
    bool? showBusinessInfo,
    bool? showProfessionalInfo,
  }) = _PrivacySettings;

  factory PrivacySettings.fromJson(Map<String, dynamic> json) => _$PrivacySettingsFromJson(json);
}

@freezed
abstract class QrCodeDetails with _$QrCodeDetails {
  const factory QrCodeDetails({
    String? id,
    String? code,
    String? qrImageUrl,
  }) = _QrCodeDetails;

  factory QrCodeDetails.fromJson(Map<String, dynamic> json) => _$QrCodeDetailsFromJson(json);
}

@freezed
abstract class OwnedFamilyMember with _$OwnedFamilyMember {
  const factory OwnedFamilyMember({
    String? id,
    String? fullName,
    String? gender,
    String? dob,
    String? relationshipType,
    bool? isDeceased,
    String? photoUrl,
    String? linkedUserId,
  }) = _OwnedFamilyMember;

  factory OwnedFamilyMember.fromJson(Map<String, dynamic> json) => _$OwnedFamilyMemberFromJson(json);
}
