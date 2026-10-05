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
    bool? isApproved,
    String? membershipStatus,
    String? createdAt,
    String? updatedAt,
    CoreProfile? profile,
    JobDetails? job,
    BusinessDetails? business,
    PrivacySettings? privacySettings,
    @JsonKey(readValue: readQrCodeDetails) QrCodeDetails? qrCode,
    @JsonKey(readValue: readPdfUrl) String? pdfUrl,
    @JsonKey(readValue: readFamilyMembers)
    List<OwnedFamilyMember>? ownedFamilyMembers,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
abstract class CoreProfile with _$CoreProfile {
  const factory CoreProfile({
    String? id,
    String? userId,
    String? title,
    String? fullName,
    String? dob,
    String? gender,
    String? profilePhotoUrl,
    String? state,
    String? city,
    String? nativeVillage,
    String? surname,
    String? gotra,
    String? address,
    String? bio,
    String? height,
    String? education,
    String? instagram,
    String? facebook,
    String? linkedin,
    String? twitter,
    String? subCaste,
    String? timeOfBirth,
    String? disability,
    String? manglik,
    String? maternalGrandfather,
    String? maternalGrandmother,
    String? maternalSurname,
    String? maternalGotra,
    String? maternalVillage,
    @JsonKey(readValue: readPdfUrl) String? biodataUrl,
    String? createdAt,
    String? updatedAt,
  }) = _CoreProfile;

  factory CoreProfile.fromJson(Map<String, dynamic> json) =>
      _$CoreProfileFromJson(json);
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
    String? state,
    String? city,
  }) = _JobDetails;

  factory JobDetails.fromJson(Map<String, dynamic> json) =>
      _$JobDetailsFromJson(json);
}

@freezed
abstract class BusinessDetails with _$BusinessDetails {
  const factory BusinessDetails({
    String? id,
    String? userId,
    String? businessName,
    String? category,
    String? productsServices,
    String? state,
    String? city,
    String? website,
    String? role,
  }) = _BusinessDetails;

  factory BusinessDetails.fromJson(Map<String, dynamic> json) =>
      _$BusinessDetailsFromJson(json);
}

@freezed
abstract class PrivacySettings with _$PrivacySettings {
  const factory PrivacySettings({
    String? id,
    String? userId,
    bool? showMobileNumber,
    bool? showEmail,
    bool? showGotra,
    bool? showFamilyInfo,
    bool? showMaternalInfo,
    bool? showBusinessInfo,
    bool? showProfessionalInfo,
    bool? showInstagram,
    bool? showFacebook,
    bool? showLinkedin,
    bool? showTwitter,
    bool? isFindmatch,
  }) = _PrivacySettings;

  factory PrivacySettings.fromJson(Map<String, dynamic> json) =>
      _$PrivacySettingsFromJson(json);
}

Object? readQrCodeDetails(Map json, String key) {
  final val = json['qrCode'] ?? json['qrCodeDetails'] ?? json['qr'];
  if (val is String) {
    return {'qrImageUrl': val, 'code': val};
  }
  if (val is Map) {
    return val;
  }
  if (json['qrImageUrl'] != null) {
    return {'qrImageUrl': json['qrImageUrl']};
  }
  return null;
}

Object? readQrUrl(Map json, String key) =>
    json['qrImageUrl'] ??
    json['qrCodeUrl'] ??
    (json['qrCode'] is String ? json['qrCode'] : null) ??
    json['url'];

Object? readPdfUrl(Map json, String key) =>
    json['pdfUrl'] ??
    json['biodataUrl'] ??
    json['biodataPdfUrl'] ??
    json['pdf'];

Object? readFamilyMembers(Map json, String key) =>
    json['ownedFamilyMembers'] ?? json['familyMembers'] ?? json['familyTree'];

@freezed
abstract class QrCodeDetails with _$QrCodeDetails {
  const factory QrCodeDetails({
    String? id,
    String? code,
    @JsonKey(readValue: readQrUrl) String? qrImageUrl,
  }) = _QrCodeDetails;

  factory QrCodeDetails.fromJson(Map<String, dynamic> json) =>
      _$QrCodeDetailsFromJson(json);
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
    String? qrImageUrl,
    String? linkedUserId,
  }) = _OwnedFamilyMember;

  factory OwnedFamilyMember.fromJson(Map<String, dynamic> json) =>
      _$OwnedFamilyMemberFromJson(json);
}

extension ProfileCompletenessX on UserProfile {
  bool get isProfileIncomplete {
    final core = profile;
    if (core == null) return true;
    final hasFullName =
        core.fullName != null && core.fullName!.trim().isNotEmpty;
    final hasDob = core.dob != null && core.dob!.trim().isNotEmpty;
    final hasCity = core.city != null && core.city!.trim().isNotEmpty;
    final hasGotra = core.gotra != null && core.gotra!.trim().isNotEmpty;
    final hasBio = core.bio != null && core.bio!.trim().isNotEmpty;
    final hasNativeVillage =
        core.nativeVillage != null && core.nativeVillage!.trim().isNotEmpty;
    return !hasFullName ||
        !hasDob ||
        !hasCity ||
        !hasGotra ||
        !hasBio ||
        !hasNativeVillage;
  }

  List<String> get missingFields {
    final list = <String>[];
    final core = profile;
    if (core == null) {
      return [
        'Full Name',
        'Date of Birth',
        'City',
        'Gotra',
        'Native Village',
        'Bio',
      ];
    }
    if (core.fullName == null || core.fullName!.trim().isEmpty) {
      list.add('Full Name');
    }
    if (core.dob == null || core.dob!.trim().isEmpty) list.add('Date of Birth');
    if (core.city == null || core.city!.trim().isEmpty) list.add('City');
    if (core.gotra == null || core.gotra!.trim().isEmpty) list.add('Gotra');
    if (core.nativeVillage == null || core.nativeVillage!.trim().isEmpty) {
      list.add('Native Village');
    }
    if (core.bio == null || core.bio!.trim().isEmpty) list.add('Bio');
    return list;
  }

  double get completionPercentage {
    const total = 6;
    final missing = missingFields.length;
    final completed = (total - missing).clamp(0, total);
    return completed / total;
  }
}

const List<String> kCommunityGotras = [
  'Agastya',
  'Airan',
  'Angirasa',
  'Atri',
  'Bansal',
  'Bharadwaj',
  'Bhrigu',
  'Bindal',
  'Dhananjaya',
  'Dharan',
  'Garg',
  'Gautam',
  'Goyal',
  'Harita',
  'Jamadagni',
  'Jindal',
  'Kansal',
  'Kashyap',
  'Kaushik',
  'Kucchal',
  'Madhukul',
  'Mangal',
  'Mittal',
  'Mudgal',
  'Nagal',
  'Parashar',
  'Sandil',
  'Shandilya',
  'Shaunak',
  'Singhal',
  'Tayal',
  'Tingal',
  'Upamanyu',
  'Vashisht',
  'Vatsa',
  'Vishwamitra',
];
