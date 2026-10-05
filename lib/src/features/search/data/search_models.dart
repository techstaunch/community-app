import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_models.freezed.dart';
part 'search_models.g.dart';

@freezed
abstract class SearchResult with _$SearchResult {
  const factory SearchResult({
    String? id,
    String? fullName,
    String? profilePhotoUrl,
    String? city,
    String? gender,
    String? dob,
    String? designation,
    String? companyName,
    String? businessName,
    String? mobileNumber,
    int? familyMembersCount,
    bool? isApproved,
    String? membershipStatus,
    bool? isVerified,
  }) = _SearchResult;

  const SearchResult._();

  int? get calculatedAge {
    if (dob == null || dob!.isEmpty) return null;
    try {
      final birthDate = DateTime.parse(dob!);
      final now = DateTime.now();
      int age = now.year - birthDate.year;
      if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }
      return age >= 0 ? age : null;
    } catch (_) {
      return null;
    }
  }

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    String? clean(dynamic v) {
      if (v == null) return null;
      final s = v.toString().trim();
      return s.isNotEmpty ? s : null;
    }

    final profile = json['profile'] as Map<String, dynamic>?;
    final business = json['business'] as Map<String, dynamic>?;
    final job = json['job'] as Map<String, dynamic>?;

    int? familyCount = json['familyMembersCount'] as int? ??
        json['familyCount'] as int? ??
        json['familyTreeCount'] as int?;

    if (familyCount == null) {
      if (json['ownedFamilyMembers'] is List) {
        familyCount = (json['ownedFamilyMembers'] as List).length;
      } else if (json['familyMembers'] is List) {
        familyCount = (json['familyMembers'] as List).length;
      }
    }

    final isVerified = json['isVerified'] as bool? ?? profile?['isVerified'] as bool?;

    final statusStr = clean(json['membershipStatus']) ?? clean(json['status']);
    final isApproved = json['isApproved'] as bool? ??
        (statusStr != null ? statusStr.toLowerCase() == 'approved' : null) ??
        profile?['isApproved'] as bool? ??
        (json['isActive'] == false ? false : true);

    final membershipStatus = statusStr ?? (isApproved ? 'Approved' : 'Pending');

    final bName = clean(business?['businessName']) ??
        clean(business?['companyName']) ??
        clean(json['businessName']);
    final jCompany = clean(job?['companyName']) ?? clean(json['companyName']);
    final effectiveCompanyName = bName ?? jCompany;

    final jDesignation = clean(job?['designation']) ?? clean(json['designation']);
    final bRole = clean(business?['role']) ?? clean(business?['designation']);
    final effectiveDesignation = jDesignation ?? bRole;

    final pCity = clean(profile?['city']) ?? clean(json['city']);
    final bCity = clean(business?['city']);
    final jCity = clean(job?['city']);
    final effectiveCity = pCity ?? bCity ?? jCity;

    return SearchResult(
      id: clean(json['id']) ?? clean(json['_id']),
      fullName: clean(profile?['fullName']) ?? clean(json['fullName']),
      profilePhotoUrl: clean(profile?['profilePhotoUrl']) ?? clean(json['profilePhotoUrl']),
      city: effectiveCity,
      gender: clean(profile?['gender']) ?? clean(json['gender']),
      dob: clean(profile?['dob']) ?? clean(json['dob']),
      designation: effectiveDesignation,
      companyName: effectiveCompanyName,
      businessName: bName,
      mobileNumber: clean(json['mobileNumber']) ?? clean(profile?['mobileNumber']),
      familyMembersCount: familyCount,
      isApproved: isApproved,
      membershipStatus: membershipStatus,
      isVerified: isVerified,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'profilePhotoUrl': profilePhotoUrl,
    'city': city,
    'gender': gender,
    'dob': dob,
    'designation': designation,
    'companyName': companyName,
    'businessName': businessName,
    'mobileNumber': mobileNumber,
    'familyMembersCount': familyMembersCount,
    'isApproved': isApproved,
    'membershipStatus': membershipStatus,
    'isVerified': isVerified,
  };
}

@freezed
abstract class SearchResponse with _$SearchResponse {
  const factory SearchResponse({
    required bool success,
    required String message,
    required List<SearchResult> data,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);
}
