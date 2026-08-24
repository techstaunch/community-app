import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    String? id,
    String? mobileNumber,
    String? email,
    CoreProfile? profile,
    JobDetails? job,
    BusinessDetails? business,
    PrivacySettings? privacySettings,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

@freezed
abstract class CoreProfile with _$CoreProfile {
  const factory CoreProfile({
    String? fullName,
    String? dob,
    String? gender,
    String? profilePhotoUrl,
    String? city,
    String? nativeVillage,
    String? surname,
    String? gotra,
  }) = _CoreProfile;

  factory CoreProfile.fromJson(Map<String, dynamic> json) => _$CoreProfileFromJson(json);
}

@freezed
abstract class JobDetails with _$JobDetails {
  const factory JobDetails({
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
    bool? showMobileNumber,
    bool? showEmail,
    bool? showFamilyInfo,
    bool? showBusinessInfo,
    bool? showProfessionalInfo,
  }) = _PrivacySettings;

  factory PrivacySettings.fromJson(Map<String, dynamic> json) => _$PrivacySettingsFromJson(json);
}
