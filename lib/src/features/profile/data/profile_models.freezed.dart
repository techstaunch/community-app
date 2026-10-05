// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {

 String? get id; String? get mobileNumber; String? get email; bool? get isVerified; bool? get isActive; bool? get isApproved; String? get membershipStatus; String? get createdAt; String? get updatedAt; CoreProfile? get profile; JobDetails? get job; BusinessDetails? get business; PrivacySettings? get privacySettings;@JsonKey(readValue: readQrCodeDetails) QrCodeDetails? get qrCode;@JsonKey(readValue: readPdfUrl) String? get pdfUrl;@JsonKey(readValue: readFamilyMembers) List<OwnedFamilyMember>? get ownedFamilyMembers;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.membershipStatus, membershipStatus) || other.membershipStatus == membershipStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.job, job) || other.job == job)&&(identical(other.business, business) || other.business == business)&&(identical(other.privacySettings, privacySettings) || other.privacySettings == privacySettings)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode)&&(identical(other.pdfUrl, pdfUrl) || other.pdfUrl == pdfUrl)&&const DeepCollectionEquality().equals(other.ownedFamilyMembers, ownedFamilyMembers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,email,isVerified,isActive,isApproved,membershipStatus,createdAt,updatedAt,profile,job,business,privacySettings,qrCode,pdfUrl,const DeepCollectionEquality().hash(ownedFamilyMembers));

@override
String toString() {
  return 'UserProfile(id: $id, mobileNumber: $mobileNumber, email: $email, isVerified: $isVerified, isActive: $isActive, isApproved: $isApproved, membershipStatus: $membershipStatus, createdAt: $createdAt, updatedAt: $updatedAt, profile: $profile, job: $job, business: $business, privacySettings: $privacySettings, qrCode: $qrCode, pdfUrl: $pdfUrl, ownedFamilyMembers: $ownedFamilyMembers)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String? id, String? mobileNumber, String? email, bool? isVerified, bool? isActive, bool? isApproved, String? membershipStatus, String? createdAt, String? updatedAt, CoreProfile? profile, JobDetails? job, BusinessDetails? business, PrivacySettings? privacySettings,@JsonKey(readValue: readQrCodeDetails) QrCodeDetails? qrCode,@JsonKey(readValue: readPdfUrl) String? pdfUrl,@JsonKey(readValue: readFamilyMembers) List<OwnedFamilyMember>? ownedFamilyMembers
});


$CoreProfileCopyWith<$Res>? get profile;$JobDetailsCopyWith<$Res>? get job;$BusinessDetailsCopyWith<$Res>? get business;$PrivacySettingsCopyWith<$Res>? get privacySettings;$QrCodeDetailsCopyWith<$Res>? get qrCode;

}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? mobileNumber = freezed,Object? email = freezed,Object? isVerified = freezed,Object? isActive = freezed,Object? isApproved = freezed,Object? membershipStatus = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? profile = freezed,Object? job = freezed,Object? business = freezed,Object? privacySettings = freezed,Object? qrCode = freezed,Object? pdfUrl = freezed,Object? ownedFamilyMembers = freezed,}) {
  return _then(UserProfile(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isVerified: freezed == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isApproved: freezed == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool?,membershipStatus: freezed == membershipStatus ? _self.membershipStatus : membershipStatus // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CoreProfile?,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as JobDetails?,business: freezed == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as BusinessDetails?,privacySettings: freezed == privacySettings ? _self.privacySettings : privacySettings // ignore: cast_nullable_to_non_nullable
as PrivacySettings?,qrCode: freezed == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as QrCodeDetails?,pdfUrl: freezed == pdfUrl ? _self.pdfUrl : pdfUrl // ignore: cast_nullable_to_non_nullable
as String?,ownedFamilyMembers: freezed == ownedFamilyMembers ? _self.ownedFamilyMembers : ownedFamilyMembers // ignore: cast_nullable_to_non_nullable
as List<OwnedFamilyMember>?,
  ));
}
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoreProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $CoreProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobDetailsCopyWith<$Res>? get job {
    if (_self.job == null) {
    return null;
  }

  return $JobDetailsCopyWith<$Res>(_self.job!, (value) {
    return _then(_self.copyWith(job: value));
  });
}/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessDetailsCopyWith<$Res>? get business {
    if (_self.business == null) {
    return null;
  }

  return $BusinessDetailsCopyWith<$Res>(_self.business!, (value) {
    return _then(_self.copyWith(business: value));
  });
}/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrivacySettingsCopyWith<$Res>? get privacySettings {
    if (_self.privacySettings == null) {
    return null;
  }

  return $PrivacySettingsCopyWith<$Res>(_self.privacySettings!, (value) {
    return _then(_self.copyWith(privacySettings: value));
  });
}/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QrCodeDetailsCopyWith<$Res>? get qrCode {
    if (_self.qrCode == null) {
    return null;
  }

  return $QrCodeDetailsCopyWith<$Res>(_self.qrCode!, (value) {
    return _then(_self.copyWith(qrCode: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? mobileNumber,  String? email,  bool? isVerified,  bool? isActive,  bool? isApproved,  String? membershipStatus,  String? createdAt,  String? updatedAt,  CoreProfile? profile,  JobDetails? job,  BusinessDetails? business,  PrivacySettings? privacySettings, @JsonKey(readValue: readQrCodeDetails)  QrCodeDetails? qrCode, @JsonKey(readValue: readPdfUrl)  String? pdfUrl, @JsonKey(readValue: readFamilyMembers)  List<OwnedFamilyMember>? ownedFamilyMembers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.mobileNumber,_that.email,_that.isVerified,_that.isActive,_that.isApproved,_that.membershipStatus,_that.createdAt,_that.updatedAt,_that.profile,_that.job,_that.business,_that.privacySettings,_that.qrCode,_that.pdfUrl,_that.ownedFamilyMembers);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? mobileNumber,  String? email,  bool? isVerified,  bool? isActive,  bool? isApproved,  String? membershipStatus,  String? createdAt,  String? updatedAt,  CoreProfile? profile,  JobDetails? job,  BusinessDetails? business,  PrivacySettings? privacySettings, @JsonKey(readValue: readQrCodeDetails)  QrCodeDetails? qrCode, @JsonKey(readValue: readPdfUrl)  String? pdfUrl, @JsonKey(readValue: readFamilyMembers)  List<OwnedFamilyMember>? ownedFamilyMembers)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.mobileNumber,_that.email,_that.isVerified,_that.isActive,_that.isApproved,_that.membershipStatus,_that.createdAt,_that.updatedAt,_that.profile,_that.job,_that.business,_that.privacySettings,_that.qrCode,_that.pdfUrl,_that.ownedFamilyMembers);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? mobileNumber,  String? email,  bool? isVerified,  bool? isActive,  bool? isApproved,  String? membershipStatus,  String? createdAt,  String? updatedAt,  CoreProfile? profile,  JobDetails? job,  BusinessDetails? business,  PrivacySettings? privacySettings, @JsonKey(readValue: readQrCodeDetails)  QrCodeDetails? qrCode, @JsonKey(readValue: readPdfUrl)  String? pdfUrl, @JsonKey(readValue: readFamilyMembers)  List<OwnedFamilyMember>? ownedFamilyMembers)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.mobileNumber,_that.email,_that.isVerified,_that.isActive,_that.isApproved,_that.membershipStatus,_that.createdAt,_that.updatedAt,_that.profile,_that.job,_that.business,_that.privacySettings,_that.qrCode,_that.pdfUrl,_that.ownedFamilyMembers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({this.id, this.mobileNumber, this.email, this.isVerified, this.isActive, this.isApproved, this.membershipStatus, this.createdAt, this.updatedAt, this.profile, this.job, this.business, this.privacySettings, @JsonKey(readValue: readQrCodeDetails) this.qrCode, @JsonKey(readValue: readPdfUrl) this.pdfUrl, @JsonKey(readValue: readFamilyMembers)  List<OwnedFamilyMember>? ownedFamilyMembers}): _ownedFamilyMembers = ownedFamilyMembers;
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String? id;
@override final  String? mobileNumber;
@override final  String? email;
@override final  bool? isVerified;
@override final  bool? isActive;
@override final  bool? isApproved;
@override final  String? membershipStatus;
@override final  String? createdAt;
@override final  String? updatedAt;
@override final  CoreProfile? profile;
@override final  JobDetails? job;
@override final  BusinessDetails? business;
@override final  PrivacySettings? privacySettings;
@override@JsonKey(readValue: readQrCodeDetails) final  QrCodeDetails? qrCode;
@override@JsonKey(readValue: readPdfUrl) final  String? pdfUrl;
 final  List<OwnedFamilyMember>? _ownedFamilyMembers;
@override@JsonKey(readValue: readFamilyMembers) List<OwnedFamilyMember>? get ownedFamilyMembers {
  final value = _ownedFamilyMembers;
  if (value == null) return null;
  if (_ownedFamilyMembers is EqualUnmodifiableListView) return _ownedFamilyMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.membershipStatus, membershipStatus) || other.membershipStatus == membershipStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.job, job) || other.job == job)&&(identical(other.business, business) || other.business == business)&&(identical(other.privacySettings, privacySettings) || other.privacySettings == privacySettings)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode)&&(identical(other.pdfUrl, pdfUrl) || other.pdfUrl == pdfUrl)&&const DeepCollectionEquality().equals(other._ownedFamilyMembers, _ownedFamilyMembers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,email,isVerified,isActive,isApproved,membershipStatus,createdAt,updatedAt,profile,job,business,privacySettings,qrCode,pdfUrl,const DeepCollectionEquality().hash(_ownedFamilyMembers));

@override
String toString() {
  return 'UserProfile(id: $id, mobileNumber: $mobileNumber, email: $email, isVerified: $isVerified, isActive: $isActive, isApproved: $isApproved, membershipStatus: $membershipStatus, createdAt: $createdAt, updatedAt: $updatedAt, profile: $profile, job: $job, business: $business, privacySettings: $privacySettings, qrCode: $qrCode, pdfUrl: $pdfUrl, ownedFamilyMembers: $ownedFamilyMembers)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? mobileNumber, String? email, bool? isVerified, bool? isActive, bool? isApproved, String? membershipStatus, String? createdAt, String? updatedAt, CoreProfile? profile, JobDetails? job, BusinessDetails? business, PrivacySettings? privacySettings,@JsonKey(readValue: readQrCodeDetails) QrCodeDetails? qrCode,@JsonKey(readValue: readPdfUrl) String? pdfUrl,@JsonKey(readValue: readFamilyMembers) List<OwnedFamilyMember>? ownedFamilyMembers
});


@override $CoreProfileCopyWith<$Res>? get profile;@override $JobDetailsCopyWith<$Res>? get job;@override $BusinessDetailsCopyWith<$Res>? get business;@override $PrivacySettingsCopyWith<$Res>? get privacySettings;@override $QrCodeDetailsCopyWith<$Res>? get qrCode;

}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? mobileNumber = freezed,Object? email = freezed,Object? isVerified = freezed,Object? isActive = freezed,Object? isApproved = freezed,Object? membershipStatus = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? profile = freezed,Object? job = freezed,Object? business = freezed,Object? privacySettings = freezed,Object? qrCode = freezed,Object? pdfUrl = freezed,Object? ownedFamilyMembers = freezed,}) {
  return _then(_UserProfile(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isVerified: freezed == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isApproved: freezed == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool?,membershipStatus: freezed == membershipStatus ? _self.membershipStatus : membershipStatus // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CoreProfile?,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as JobDetails?,business: freezed == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as BusinessDetails?,privacySettings: freezed == privacySettings ? _self.privacySettings : privacySettings // ignore: cast_nullable_to_non_nullable
as PrivacySettings?,qrCode: freezed == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as QrCodeDetails?,pdfUrl: freezed == pdfUrl ? _self.pdfUrl : pdfUrl // ignore: cast_nullable_to_non_nullable
as String?,ownedFamilyMembers: freezed == ownedFamilyMembers ? _self._ownedFamilyMembers : ownedFamilyMembers // ignore: cast_nullable_to_non_nullable
as List<OwnedFamilyMember>?,
  ));
}

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoreProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $CoreProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobDetailsCopyWith<$Res>? get job {
    if (_self.job == null) {
    return null;
  }

  return $JobDetailsCopyWith<$Res>(_self.job!, (value) {
    return _then(_self.copyWith(job: value));
  });
}/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessDetailsCopyWith<$Res>? get business {
    if (_self.business == null) {
    return null;
  }

  return $BusinessDetailsCopyWith<$Res>(_self.business!, (value) {
    return _then(_self.copyWith(business: value));
  });
}/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrivacySettingsCopyWith<$Res>? get privacySettings {
    if (_self.privacySettings == null) {
    return null;
  }

  return $PrivacySettingsCopyWith<$Res>(_self.privacySettings!, (value) {
    return _then(_self.copyWith(privacySettings: value));
  });
}/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QrCodeDetailsCopyWith<$Res>? get qrCode {
    if (_self.qrCode == null) {
    return null;
  }

  return $QrCodeDetailsCopyWith<$Res>(_self.qrCode!, (value) {
    return _then(_self.copyWith(qrCode: value));
  });
}
}


/// @nodoc
mixin _$CoreProfile {

 String? get id; String? get userId; String? get title; String? get fullName; String? get dob; String? get gender; String? get profilePhotoUrl; String? get state; String? get city; String? get nativeVillage; String? get surname; String? get gotra; String? get address; String? get bio; String? get height; String? get education; String? get instagram; String? get facebook; String? get linkedin; String? get twitter; String? get subCaste; String? get timeOfBirth; String? get disability; String? get manglik; String? get maternalGrandfather; String? get maternalGrandmother; String? get maternalSurname; String? get maternalGotra; String? get maternalVillage;@JsonKey(readValue: readPdfUrl) String? get biodataUrl; String? get createdAt; String? get updatedAt;
/// Create a copy of CoreProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoreProfileCopyWith<CoreProfile> get copyWith => _$CoreProfileCopyWithImpl<CoreProfile>(this as CoreProfile, _$identity);

  /// Serializes this CoreProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoreProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.profilePhotoUrl, profilePhotoUrl) || other.profilePhotoUrl == profilePhotoUrl)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.nativeVillage, nativeVillage) || other.nativeVillage == nativeVillage)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.gotra, gotra) || other.gotra == gotra)&&(identical(other.address, address) || other.address == address)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.height, height) || other.height == height)&&(identical(other.education, education) || other.education == education)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.twitter, twitter) || other.twitter == twitter)&&(identical(other.subCaste, subCaste) || other.subCaste == subCaste)&&(identical(other.timeOfBirth, timeOfBirth) || other.timeOfBirth == timeOfBirth)&&(identical(other.disability, disability) || other.disability == disability)&&(identical(other.manglik, manglik) || other.manglik == manglik)&&(identical(other.maternalGrandfather, maternalGrandfather) || other.maternalGrandfather == maternalGrandfather)&&(identical(other.maternalGrandmother, maternalGrandmother) || other.maternalGrandmother == maternalGrandmother)&&(identical(other.maternalSurname, maternalSurname) || other.maternalSurname == maternalSurname)&&(identical(other.maternalGotra, maternalGotra) || other.maternalGotra == maternalGotra)&&(identical(other.maternalVillage, maternalVillage) || other.maternalVillage == maternalVillage)&&(identical(other.biodataUrl, biodataUrl) || other.biodataUrl == biodataUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,title,fullName,dob,gender,profilePhotoUrl,state,city,nativeVillage,surname,gotra,address,bio,height,education,instagram,facebook,linkedin,twitter,subCaste,timeOfBirth,disability,manglik,maternalGrandfather,maternalGrandmother,maternalSurname,maternalGotra,maternalVillage,biodataUrl,createdAt,updatedAt]);

@override
String toString() {
  return 'CoreProfile(id: $id, userId: $userId, title: $title, fullName: $fullName, dob: $dob, gender: $gender, profilePhotoUrl: $profilePhotoUrl, state: $state, city: $city, nativeVillage: $nativeVillage, surname: $surname, gotra: $gotra, address: $address, bio: $bio, height: $height, education: $education, instagram: $instagram, facebook: $facebook, linkedin: $linkedin, twitter: $twitter, subCaste: $subCaste, timeOfBirth: $timeOfBirth, disability: $disability, manglik: $manglik, maternalGrandfather: $maternalGrandfather, maternalGrandmother: $maternalGrandmother, maternalSurname: $maternalSurname, maternalGotra: $maternalGotra, maternalVillage: $maternalVillage, biodataUrl: $biodataUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CoreProfileCopyWith<$Res>  {
  factory $CoreProfileCopyWith(CoreProfile value, $Res Function(CoreProfile) _then) = _$CoreProfileCopyWithImpl;
@useResult
$Res call({
 String? id, String? userId, String? title, String? fullName, String? dob, String? gender, String? profilePhotoUrl, String? state, String? city, String? nativeVillage, String? surname, String? gotra, String? address, String? bio, String? height, String? education, String? instagram, String? facebook, String? linkedin, String? twitter, String? subCaste, String? timeOfBirth, String? disability, String? manglik, String? maternalGrandfather, String? maternalGrandmother, String? maternalSurname, String? maternalGotra, String? maternalVillage,@JsonKey(readValue: readPdfUrl) String? biodataUrl, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$CoreProfileCopyWithImpl<$Res>
    implements $CoreProfileCopyWith<$Res> {
  _$CoreProfileCopyWithImpl(this._self, this._then);

  final CoreProfile _self;
  final $Res Function(CoreProfile) _then;

/// Create a copy of CoreProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = freezed,Object? title = freezed,Object? fullName = freezed,Object? dob = freezed,Object? gender = freezed,Object? profilePhotoUrl = freezed,Object? state = freezed,Object? city = freezed,Object? nativeVillage = freezed,Object? surname = freezed,Object? gotra = freezed,Object? address = freezed,Object? bio = freezed,Object? height = freezed,Object? education = freezed,Object? instagram = freezed,Object? facebook = freezed,Object? linkedin = freezed,Object? twitter = freezed,Object? subCaste = freezed,Object? timeOfBirth = freezed,Object? disability = freezed,Object? manglik = freezed,Object? maternalGrandfather = freezed,Object? maternalGrandmother = freezed,Object? maternalSurname = freezed,Object? maternalGotra = freezed,Object? maternalVillage = freezed,Object? biodataUrl = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(CoreProfile(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,profilePhotoUrl: freezed == profilePhotoUrl ? _self.profilePhotoUrl : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,nativeVillage: freezed == nativeVillage ? _self.nativeVillage : nativeVillage // ignore: cast_nullable_to_non_nullable
as String?,surname: freezed == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String?,gotra: freezed == gotra ? _self.gotra : gotra // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as String?,education: freezed == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,facebook: freezed == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String?,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,twitter: freezed == twitter ? _self.twitter : twitter // ignore: cast_nullable_to_non_nullable
as String?,subCaste: freezed == subCaste ? _self.subCaste : subCaste // ignore: cast_nullable_to_non_nullable
as String?,timeOfBirth: freezed == timeOfBirth ? _self.timeOfBirth : timeOfBirth // ignore: cast_nullable_to_non_nullable
as String?,disability: freezed == disability ? _self.disability : disability // ignore: cast_nullable_to_non_nullable
as String?,manglik: freezed == manglik ? _self.manglik : manglik // ignore: cast_nullable_to_non_nullable
as String?,maternalGrandfather: freezed == maternalGrandfather ? _self.maternalGrandfather : maternalGrandfather // ignore: cast_nullable_to_non_nullable
as String?,maternalGrandmother: freezed == maternalGrandmother ? _self.maternalGrandmother : maternalGrandmother // ignore: cast_nullable_to_non_nullable
as String?,maternalSurname: freezed == maternalSurname ? _self.maternalSurname : maternalSurname // ignore: cast_nullable_to_non_nullable
as String?,maternalGotra: freezed == maternalGotra ? _self.maternalGotra : maternalGotra // ignore: cast_nullable_to_non_nullable
as String?,maternalVillage: freezed == maternalVillage ? _self.maternalVillage : maternalVillage // ignore: cast_nullable_to_non_nullable
as String?,biodataUrl: freezed == biodataUrl ? _self.biodataUrl : biodataUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CoreProfile].
extension CoreProfilePatterns on CoreProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoreProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoreProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoreProfile value)  $default,){
final _that = this;
switch (_that) {
case _CoreProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoreProfile value)?  $default,){
final _that = this;
switch (_that) {
case _CoreProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? userId,  String? title,  String? fullName,  String? dob,  String? gender,  String? profilePhotoUrl,  String? state,  String? city,  String? nativeVillage,  String? surname,  String? gotra,  String? address,  String? bio,  String? height,  String? education,  String? instagram,  String? facebook,  String? linkedin,  String? twitter,  String? subCaste,  String? timeOfBirth,  String? disability,  String? manglik,  String? maternalGrandfather,  String? maternalGrandmother,  String? maternalSurname,  String? maternalGotra,  String? maternalVillage, @JsonKey(readValue: readPdfUrl)  String? biodataUrl,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoreProfile() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.fullName,_that.dob,_that.gender,_that.profilePhotoUrl,_that.state,_that.city,_that.nativeVillage,_that.surname,_that.gotra,_that.address,_that.bio,_that.height,_that.education,_that.instagram,_that.facebook,_that.linkedin,_that.twitter,_that.subCaste,_that.timeOfBirth,_that.disability,_that.manglik,_that.maternalGrandfather,_that.maternalGrandmother,_that.maternalSurname,_that.maternalGotra,_that.maternalVillage,_that.biodataUrl,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? userId,  String? title,  String? fullName,  String? dob,  String? gender,  String? profilePhotoUrl,  String? state,  String? city,  String? nativeVillage,  String? surname,  String? gotra,  String? address,  String? bio,  String? height,  String? education,  String? instagram,  String? facebook,  String? linkedin,  String? twitter,  String? subCaste,  String? timeOfBirth,  String? disability,  String? manglik,  String? maternalGrandfather,  String? maternalGrandmother,  String? maternalSurname,  String? maternalGotra,  String? maternalVillage, @JsonKey(readValue: readPdfUrl)  String? biodataUrl,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CoreProfile():
return $default(_that.id,_that.userId,_that.title,_that.fullName,_that.dob,_that.gender,_that.profilePhotoUrl,_that.state,_that.city,_that.nativeVillage,_that.surname,_that.gotra,_that.address,_that.bio,_that.height,_that.education,_that.instagram,_that.facebook,_that.linkedin,_that.twitter,_that.subCaste,_that.timeOfBirth,_that.disability,_that.manglik,_that.maternalGrandfather,_that.maternalGrandmother,_that.maternalSurname,_that.maternalGotra,_that.maternalVillage,_that.biodataUrl,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? userId,  String? title,  String? fullName,  String? dob,  String? gender,  String? profilePhotoUrl,  String? state,  String? city,  String? nativeVillage,  String? surname,  String? gotra,  String? address,  String? bio,  String? height,  String? education,  String? instagram,  String? facebook,  String? linkedin,  String? twitter,  String? subCaste,  String? timeOfBirth,  String? disability,  String? manglik,  String? maternalGrandfather,  String? maternalGrandmother,  String? maternalSurname,  String? maternalGotra,  String? maternalVillage, @JsonKey(readValue: readPdfUrl)  String? biodataUrl,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CoreProfile() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.fullName,_that.dob,_that.gender,_that.profilePhotoUrl,_that.state,_that.city,_that.nativeVillage,_that.surname,_that.gotra,_that.address,_that.bio,_that.height,_that.education,_that.instagram,_that.facebook,_that.linkedin,_that.twitter,_that.subCaste,_that.timeOfBirth,_that.disability,_that.manglik,_that.maternalGrandfather,_that.maternalGrandmother,_that.maternalSurname,_that.maternalGotra,_that.maternalVillage,_that.biodataUrl,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoreProfile implements CoreProfile {
  const _CoreProfile({this.id, this.userId, this.title, this.fullName, this.dob, this.gender, this.profilePhotoUrl, this.state, this.city, this.nativeVillage, this.surname, this.gotra, this.address, this.bio, this.height, this.education, this.instagram, this.facebook, this.linkedin, this.twitter, this.subCaste, this.timeOfBirth, this.disability, this.manglik, this.maternalGrandfather, this.maternalGrandmother, this.maternalSurname, this.maternalGotra, this.maternalVillage, @JsonKey(readValue: readPdfUrl) this.biodataUrl, this.createdAt, this.updatedAt});
  factory _CoreProfile.fromJson(Map<String, dynamic> json) => _$CoreProfileFromJson(json);

@override final  String? id;
@override final  String? userId;
@override final  String? title;
@override final  String? fullName;
@override final  String? dob;
@override final  String? gender;
@override final  String? profilePhotoUrl;
@override final  String? state;
@override final  String? city;
@override final  String? nativeVillage;
@override final  String? surname;
@override final  String? gotra;
@override final  String? address;
@override final  String? bio;
@override final  String? height;
@override final  String? education;
@override final  String? instagram;
@override final  String? facebook;
@override final  String? linkedin;
@override final  String? twitter;
@override final  String? subCaste;
@override final  String? timeOfBirth;
@override final  String? disability;
@override final  String? manglik;
@override final  String? maternalGrandfather;
@override final  String? maternalGrandmother;
@override final  String? maternalSurname;
@override final  String? maternalGotra;
@override final  String? maternalVillage;
@override@JsonKey(readValue: readPdfUrl) final  String? biodataUrl;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of CoreProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoreProfileCopyWith<_CoreProfile> get copyWith => __$CoreProfileCopyWithImpl<_CoreProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoreProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoreProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.profilePhotoUrl, profilePhotoUrl) || other.profilePhotoUrl == profilePhotoUrl)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.nativeVillage, nativeVillage) || other.nativeVillage == nativeVillage)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.gotra, gotra) || other.gotra == gotra)&&(identical(other.address, address) || other.address == address)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.height, height) || other.height == height)&&(identical(other.education, education) || other.education == education)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.twitter, twitter) || other.twitter == twitter)&&(identical(other.subCaste, subCaste) || other.subCaste == subCaste)&&(identical(other.timeOfBirth, timeOfBirth) || other.timeOfBirth == timeOfBirth)&&(identical(other.disability, disability) || other.disability == disability)&&(identical(other.manglik, manglik) || other.manglik == manglik)&&(identical(other.maternalGrandfather, maternalGrandfather) || other.maternalGrandfather == maternalGrandfather)&&(identical(other.maternalGrandmother, maternalGrandmother) || other.maternalGrandmother == maternalGrandmother)&&(identical(other.maternalSurname, maternalSurname) || other.maternalSurname == maternalSurname)&&(identical(other.maternalGotra, maternalGotra) || other.maternalGotra == maternalGotra)&&(identical(other.maternalVillage, maternalVillage) || other.maternalVillage == maternalVillage)&&(identical(other.biodataUrl, biodataUrl) || other.biodataUrl == biodataUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,title,fullName,dob,gender,profilePhotoUrl,state,city,nativeVillage,surname,gotra,address,bio,height,education,instagram,facebook,linkedin,twitter,subCaste,timeOfBirth,disability,manglik,maternalGrandfather,maternalGrandmother,maternalSurname,maternalGotra,maternalVillage,biodataUrl,createdAt,updatedAt]);

@override
String toString() {
  return 'CoreProfile(id: $id, userId: $userId, title: $title, fullName: $fullName, dob: $dob, gender: $gender, profilePhotoUrl: $profilePhotoUrl, state: $state, city: $city, nativeVillage: $nativeVillage, surname: $surname, gotra: $gotra, address: $address, bio: $bio, height: $height, education: $education, instagram: $instagram, facebook: $facebook, linkedin: $linkedin, twitter: $twitter, subCaste: $subCaste, timeOfBirth: $timeOfBirth, disability: $disability, manglik: $manglik, maternalGrandfather: $maternalGrandfather, maternalGrandmother: $maternalGrandmother, maternalSurname: $maternalSurname, maternalGotra: $maternalGotra, maternalVillage: $maternalVillage, biodataUrl: $biodataUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CoreProfileCopyWith<$Res> implements $CoreProfileCopyWith<$Res> {
  factory _$CoreProfileCopyWith(_CoreProfile value, $Res Function(_CoreProfile) _then) = __$CoreProfileCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? userId, String? title, String? fullName, String? dob, String? gender, String? profilePhotoUrl, String? state, String? city, String? nativeVillage, String? surname, String? gotra, String? address, String? bio, String? height, String? education, String? instagram, String? facebook, String? linkedin, String? twitter, String? subCaste, String? timeOfBirth, String? disability, String? manglik, String? maternalGrandfather, String? maternalGrandmother, String? maternalSurname, String? maternalGotra, String? maternalVillage,@JsonKey(readValue: readPdfUrl) String? biodataUrl, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$CoreProfileCopyWithImpl<$Res>
    implements _$CoreProfileCopyWith<$Res> {
  __$CoreProfileCopyWithImpl(this._self, this._then);

  final _CoreProfile _self;
  final $Res Function(_CoreProfile) _then;

/// Create a copy of CoreProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? title = freezed,Object? fullName = freezed,Object? dob = freezed,Object? gender = freezed,Object? profilePhotoUrl = freezed,Object? state = freezed,Object? city = freezed,Object? nativeVillage = freezed,Object? surname = freezed,Object? gotra = freezed,Object? address = freezed,Object? bio = freezed,Object? height = freezed,Object? education = freezed,Object? instagram = freezed,Object? facebook = freezed,Object? linkedin = freezed,Object? twitter = freezed,Object? subCaste = freezed,Object? timeOfBirth = freezed,Object? disability = freezed,Object? manglik = freezed,Object? maternalGrandfather = freezed,Object? maternalGrandmother = freezed,Object? maternalSurname = freezed,Object? maternalGotra = freezed,Object? maternalVillage = freezed,Object? biodataUrl = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CoreProfile(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,profilePhotoUrl: freezed == profilePhotoUrl ? _self.profilePhotoUrl : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,nativeVillage: freezed == nativeVillage ? _self.nativeVillage : nativeVillage // ignore: cast_nullable_to_non_nullable
as String?,surname: freezed == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String?,gotra: freezed == gotra ? _self.gotra : gotra // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as String?,education: freezed == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,facebook: freezed == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String?,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,twitter: freezed == twitter ? _self.twitter : twitter // ignore: cast_nullable_to_non_nullable
as String?,subCaste: freezed == subCaste ? _self.subCaste : subCaste // ignore: cast_nullable_to_non_nullable
as String?,timeOfBirth: freezed == timeOfBirth ? _self.timeOfBirth : timeOfBirth // ignore: cast_nullable_to_non_nullable
as String?,disability: freezed == disability ? _self.disability : disability // ignore: cast_nullable_to_non_nullable
as String?,manglik: freezed == manglik ? _self.manglik : manglik // ignore: cast_nullable_to_non_nullable
as String?,maternalGrandfather: freezed == maternalGrandfather ? _self.maternalGrandfather : maternalGrandfather // ignore: cast_nullable_to_non_nullable
as String?,maternalGrandmother: freezed == maternalGrandmother ? _self.maternalGrandmother : maternalGrandmother // ignore: cast_nullable_to_non_nullable
as String?,maternalSurname: freezed == maternalSurname ? _self.maternalSurname : maternalSurname // ignore: cast_nullable_to_non_nullable
as String?,maternalGotra: freezed == maternalGotra ? _self.maternalGotra : maternalGotra // ignore: cast_nullable_to_non_nullable
as String?,maternalVillage: freezed == maternalVillage ? _self.maternalVillage : maternalVillage // ignore: cast_nullable_to_non_nullable
as String?,biodataUrl: freezed == biodataUrl ? _self.biodataUrl : biodataUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$JobDetails {

 String? get id; String? get userId; String? get companyName; String? get designation; String? get industry; int? get yearsOfExperience; String? get state; String? get city;
/// Create a copy of JobDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobDetailsCopyWith<JobDetails> get copyWith => _$JobDetailsCopyWithImpl<JobDetails>(this as JobDetails, _$identity);

  /// Serializes this JobDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.yearsOfExperience, yearsOfExperience) || other.yearsOfExperience == yearsOfExperience)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,companyName,designation,industry,yearsOfExperience,state,city);

@override
String toString() {
  return 'JobDetails(id: $id, userId: $userId, companyName: $companyName, designation: $designation, industry: $industry, yearsOfExperience: $yearsOfExperience, state: $state, city: $city)';
}


}

/// @nodoc
abstract mixin class $JobDetailsCopyWith<$Res>  {
  factory $JobDetailsCopyWith(JobDetails value, $Res Function(JobDetails) _then) = _$JobDetailsCopyWithImpl;
@useResult
$Res call({
 String? id, String? userId, String? companyName, String? designation, String? industry, int? yearsOfExperience, String? state, String? city
});




}
/// @nodoc
class _$JobDetailsCopyWithImpl<$Res>
    implements $JobDetailsCopyWith<$Res> {
  _$JobDetailsCopyWithImpl(this._self, this._then);

  final JobDetails _self;
  final $Res Function(JobDetails) _then;

/// Create a copy of JobDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = freezed,Object? companyName = freezed,Object? designation = freezed,Object? industry = freezed,Object? yearsOfExperience = freezed,Object? state = freezed,Object? city = freezed,}) {
  return _then(JobDetails(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,industry: freezed == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String?,yearsOfExperience: freezed == yearsOfExperience ? _self.yearsOfExperience : yearsOfExperience // ignore: cast_nullable_to_non_nullable
as int?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobDetails].
extension JobDetailsPatterns on JobDetails {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobDetails() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobDetails value)  $default,){
final _that = this;
switch (_that) {
case _JobDetails():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobDetails value)?  $default,){
final _that = this;
switch (_that) {
case _JobDetails() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? userId,  String? companyName,  String? designation,  String? industry,  int? yearsOfExperience,  String? state,  String? city)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobDetails() when $default != null:
return $default(_that.id,_that.userId,_that.companyName,_that.designation,_that.industry,_that.yearsOfExperience,_that.state,_that.city);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? userId,  String? companyName,  String? designation,  String? industry,  int? yearsOfExperience,  String? state,  String? city)  $default,) {final _that = this;
switch (_that) {
case _JobDetails():
return $default(_that.id,_that.userId,_that.companyName,_that.designation,_that.industry,_that.yearsOfExperience,_that.state,_that.city);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? userId,  String? companyName,  String? designation,  String? industry,  int? yearsOfExperience,  String? state,  String? city)?  $default,) {final _that = this;
switch (_that) {
case _JobDetails() when $default != null:
return $default(_that.id,_that.userId,_that.companyName,_that.designation,_that.industry,_that.yearsOfExperience,_that.state,_that.city);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobDetails implements JobDetails {
  const _JobDetails({this.id, this.userId, this.companyName, this.designation, this.industry, this.yearsOfExperience, this.state, this.city});
  factory _JobDetails.fromJson(Map<String, dynamic> json) => _$JobDetailsFromJson(json);

@override final  String? id;
@override final  String? userId;
@override final  String? companyName;
@override final  String? designation;
@override final  String? industry;
@override final  int? yearsOfExperience;
@override final  String? state;
@override final  String? city;

/// Create a copy of JobDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobDetailsCopyWith<_JobDetails> get copyWith => __$JobDetailsCopyWithImpl<_JobDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.yearsOfExperience, yearsOfExperience) || other.yearsOfExperience == yearsOfExperience)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,companyName,designation,industry,yearsOfExperience,state,city);

@override
String toString() {
  return 'JobDetails(id: $id, userId: $userId, companyName: $companyName, designation: $designation, industry: $industry, yearsOfExperience: $yearsOfExperience, state: $state, city: $city)';
}


}

/// @nodoc
abstract mixin class _$JobDetailsCopyWith<$Res> implements $JobDetailsCopyWith<$Res> {
  factory _$JobDetailsCopyWith(_JobDetails value, $Res Function(_JobDetails) _then) = __$JobDetailsCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? userId, String? companyName, String? designation, String? industry, int? yearsOfExperience, String? state, String? city
});




}
/// @nodoc
class __$JobDetailsCopyWithImpl<$Res>
    implements _$JobDetailsCopyWith<$Res> {
  __$JobDetailsCopyWithImpl(this._self, this._then);

  final _JobDetails _self;
  final $Res Function(_JobDetails) _then;

/// Create a copy of JobDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? companyName = freezed,Object? designation = freezed,Object? industry = freezed,Object? yearsOfExperience = freezed,Object? state = freezed,Object? city = freezed,}) {
  return _then(_JobDetails(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,industry: freezed == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String?,yearsOfExperience: freezed == yearsOfExperience ? _self.yearsOfExperience : yearsOfExperience // ignore: cast_nullable_to_non_nullable
as int?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BusinessDetails {

 String? get id; String? get userId; String? get businessName; String? get category; String? get productsServices; String? get state; String? get city; String? get website; String? get role;
/// Create a copy of BusinessDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessDetailsCopyWith<BusinessDetails> get copyWith => _$BusinessDetailsCopyWithImpl<BusinessDetails>(this as BusinessDetails, _$identity);

  /// Serializes this BusinessDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.category, category) || other.category == category)&&(identical(other.productsServices, productsServices) || other.productsServices == productsServices)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.website, website) || other.website == website)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,businessName,category,productsServices,state,city,website,role);

@override
String toString() {
  return 'BusinessDetails(id: $id, userId: $userId, businessName: $businessName, category: $category, productsServices: $productsServices, state: $state, city: $city, website: $website, role: $role)';
}


}

/// @nodoc
abstract mixin class $BusinessDetailsCopyWith<$Res>  {
  factory $BusinessDetailsCopyWith(BusinessDetails value, $Res Function(BusinessDetails) _then) = _$BusinessDetailsCopyWithImpl;
@useResult
$Res call({
 String? id, String? userId, String? businessName, String? category, String? productsServices, String? state, String? city, String? website, String? role
});




}
/// @nodoc
class _$BusinessDetailsCopyWithImpl<$Res>
    implements $BusinessDetailsCopyWith<$Res> {
  _$BusinessDetailsCopyWithImpl(this._self, this._then);

  final BusinessDetails _self;
  final $Res Function(BusinessDetails) _then;

/// Create a copy of BusinessDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = freezed,Object? businessName = freezed,Object? category = freezed,Object? productsServices = freezed,Object? state = freezed,Object? city = freezed,Object? website = freezed,Object? role = freezed,}) {
  return _then(BusinessDetails(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,businessName: freezed == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,productsServices: freezed == productsServices ? _self.productsServices : productsServices // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessDetails].
extension BusinessDetailsPatterns on BusinessDetails {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessDetails() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessDetails value)  $default,){
final _that = this;
switch (_that) {
case _BusinessDetails():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessDetails value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessDetails() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? userId,  String? businessName,  String? category,  String? productsServices,  String? state,  String? city,  String? website,  String? role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessDetails() when $default != null:
return $default(_that.id,_that.userId,_that.businessName,_that.category,_that.productsServices,_that.state,_that.city,_that.website,_that.role);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? userId,  String? businessName,  String? category,  String? productsServices,  String? state,  String? city,  String? website,  String? role)  $default,) {final _that = this;
switch (_that) {
case _BusinessDetails():
return $default(_that.id,_that.userId,_that.businessName,_that.category,_that.productsServices,_that.state,_that.city,_that.website,_that.role);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? userId,  String? businessName,  String? category,  String? productsServices,  String? state,  String? city,  String? website,  String? role)?  $default,) {final _that = this;
switch (_that) {
case _BusinessDetails() when $default != null:
return $default(_that.id,_that.userId,_that.businessName,_that.category,_that.productsServices,_that.state,_that.city,_that.website,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessDetails implements BusinessDetails {
  const _BusinessDetails({this.id, this.userId, this.businessName, this.category, this.productsServices, this.state, this.city, this.website, this.role});
  factory _BusinessDetails.fromJson(Map<String, dynamic> json) => _$BusinessDetailsFromJson(json);

@override final  String? id;
@override final  String? userId;
@override final  String? businessName;
@override final  String? category;
@override final  String? productsServices;
@override final  String? state;
@override final  String? city;
@override final  String? website;
@override final  String? role;

/// Create a copy of BusinessDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessDetailsCopyWith<_BusinessDetails> get copyWith => __$BusinessDetailsCopyWithImpl<_BusinessDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.category, category) || other.category == category)&&(identical(other.productsServices, productsServices) || other.productsServices == productsServices)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.website, website) || other.website == website)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,businessName,category,productsServices,state,city,website,role);

@override
String toString() {
  return 'BusinessDetails(id: $id, userId: $userId, businessName: $businessName, category: $category, productsServices: $productsServices, state: $state, city: $city, website: $website, role: $role)';
}


}

/// @nodoc
abstract mixin class _$BusinessDetailsCopyWith<$Res> implements $BusinessDetailsCopyWith<$Res> {
  factory _$BusinessDetailsCopyWith(_BusinessDetails value, $Res Function(_BusinessDetails) _then) = __$BusinessDetailsCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? userId, String? businessName, String? category, String? productsServices, String? state, String? city, String? website, String? role
});




}
/// @nodoc
class __$BusinessDetailsCopyWithImpl<$Res>
    implements _$BusinessDetailsCopyWith<$Res> {
  __$BusinessDetailsCopyWithImpl(this._self, this._then);

  final _BusinessDetails _self;
  final $Res Function(_BusinessDetails) _then;

/// Create a copy of BusinessDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? businessName = freezed,Object? category = freezed,Object? productsServices = freezed,Object? state = freezed,Object? city = freezed,Object? website = freezed,Object? role = freezed,}) {
  return _then(_BusinessDetails(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,businessName: freezed == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,productsServices: freezed == productsServices ? _self.productsServices : productsServices // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PrivacySettings {

 String? get id; String? get userId; bool? get showMobileNumber; bool? get showEmail; bool? get showGotra; bool? get showFamilyInfo; bool? get showMaternalInfo; bool? get showBusinessInfo; bool? get showProfessionalInfo; bool? get showInstagram; bool? get showFacebook; bool? get showLinkedin; bool? get showTwitter; bool? get isFindmatch;
/// Create a copy of PrivacySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrivacySettingsCopyWith<PrivacySettings> get copyWith => _$PrivacySettingsCopyWithImpl<PrivacySettings>(this as PrivacySettings, _$identity);

  /// Serializes this PrivacySettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrivacySettings&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.showMobileNumber, showMobileNumber) || other.showMobileNumber == showMobileNumber)&&(identical(other.showEmail, showEmail) || other.showEmail == showEmail)&&(identical(other.showGotra, showGotra) || other.showGotra == showGotra)&&(identical(other.showFamilyInfo, showFamilyInfo) || other.showFamilyInfo == showFamilyInfo)&&(identical(other.showMaternalInfo, showMaternalInfo) || other.showMaternalInfo == showMaternalInfo)&&(identical(other.showBusinessInfo, showBusinessInfo) || other.showBusinessInfo == showBusinessInfo)&&(identical(other.showProfessionalInfo, showProfessionalInfo) || other.showProfessionalInfo == showProfessionalInfo)&&(identical(other.showInstagram, showInstagram) || other.showInstagram == showInstagram)&&(identical(other.showFacebook, showFacebook) || other.showFacebook == showFacebook)&&(identical(other.showLinkedin, showLinkedin) || other.showLinkedin == showLinkedin)&&(identical(other.showTwitter, showTwitter) || other.showTwitter == showTwitter)&&(identical(other.isFindmatch, isFindmatch) || other.isFindmatch == isFindmatch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,showMobileNumber,showEmail,showGotra,showFamilyInfo,showMaternalInfo,showBusinessInfo,showProfessionalInfo,showInstagram,showFacebook,showLinkedin,showTwitter,isFindmatch);

@override
String toString() {
  return 'PrivacySettings(id: $id, userId: $userId, showMobileNumber: $showMobileNumber, showEmail: $showEmail, showGotra: $showGotra, showFamilyInfo: $showFamilyInfo, showMaternalInfo: $showMaternalInfo, showBusinessInfo: $showBusinessInfo, showProfessionalInfo: $showProfessionalInfo, showInstagram: $showInstagram, showFacebook: $showFacebook, showLinkedin: $showLinkedin, showTwitter: $showTwitter, isFindmatch: $isFindmatch)';
}


}

/// @nodoc
abstract mixin class $PrivacySettingsCopyWith<$Res>  {
  factory $PrivacySettingsCopyWith(PrivacySettings value, $Res Function(PrivacySettings) _then) = _$PrivacySettingsCopyWithImpl;
@useResult
$Res call({
 String? id, String? userId, bool? showMobileNumber, bool? showEmail, bool? showGotra, bool? showFamilyInfo, bool? showMaternalInfo, bool? showBusinessInfo, bool? showProfessionalInfo, bool? showInstagram, bool? showFacebook, bool? showLinkedin, bool? showTwitter, bool? isFindmatch
});




}
/// @nodoc
class _$PrivacySettingsCopyWithImpl<$Res>
    implements $PrivacySettingsCopyWith<$Res> {
  _$PrivacySettingsCopyWithImpl(this._self, this._then);

  final PrivacySettings _self;
  final $Res Function(PrivacySettings) _then;

/// Create a copy of PrivacySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = freezed,Object? showMobileNumber = freezed,Object? showEmail = freezed,Object? showGotra = freezed,Object? showFamilyInfo = freezed,Object? showMaternalInfo = freezed,Object? showBusinessInfo = freezed,Object? showProfessionalInfo = freezed,Object? showInstagram = freezed,Object? showFacebook = freezed,Object? showLinkedin = freezed,Object? showTwitter = freezed,Object? isFindmatch = freezed,}) {
  return _then(PrivacySettings(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,showMobileNumber: freezed == showMobileNumber ? _self.showMobileNumber : showMobileNumber // ignore: cast_nullable_to_non_nullable
as bool?,showEmail: freezed == showEmail ? _self.showEmail : showEmail // ignore: cast_nullable_to_non_nullable
as bool?,showGotra: freezed == showGotra ? _self.showGotra : showGotra // ignore: cast_nullable_to_non_nullable
as bool?,showFamilyInfo: freezed == showFamilyInfo ? _self.showFamilyInfo : showFamilyInfo // ignore: cast_nullable_to_non_nullable
as bool?,showMaternalInfo: freezed == showMaternalInfo ? _self.showMaternalInfo : showMaternalInfo // ignore: cast_nullable_to_non_nullable
as bool?,showBusinessInfo: freezed == showBusinessInfo ? _self.showBusinessInfo : showBusinessInfo // ignore: cast_nullable_to_non_nullable
as bool?,showProfessionalInfo: freezed == showProfessionalInfo ? _self.showProfessionalInfo : showProfessionalInfo // ignore: cast_nullable_to_non_nullable
as bool?,showInstagram: freezed == showInstagram ? _self.showInstagram : showInstagram // ignore: cast_nullable_to_non_nullable
as bool?,showFacebook: freezed == showFacebook ? _self.showFacebook : showFacebook // ignore: cast_nullable_to_non_nullable
as bool?,showLinkedin: freezed == showLinkedin ? _self.showLinkedin : showLinkedin // ignore: cast_nullable_to_non_nullable
as bool?,showTwitter: freezed == showTwitter ? _self.showTwitter : showTwitter // ignore: cast_nullable_to_non_nullable
as bool?,isFindmatch: freezed == isFindmatch ? _self.isFindmatch : isFindmatch // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [PrivacySettings].
extension PrivacySettingsPatterns on PrivacySettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrivacySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrivacySettings value)  $default,){
final _that = this;
switch (_that) {
case _PrivacySettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrivacySettings value)?  $default,){
final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? userId,  bool? showMobileNumber,  bool? showEmail,  bool? showGotra,  bool? showFamilyInfo,  bool? showMaternalInfo,  bool? showBusinessInfo,  bool? showProfessionalInfo,  bool? showInstagram,  bool? showFacebook,  bool? showLinkedin,  bool? showTwitter,  bool? isFindmatch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
return $default(_that.id,_that.userId,_that.showMobileNumber,_that.showEmail,_that.showGotra,_that.showFamilyInfo,_that.showMaternalInfo,_that.showBusinessInfo,_that.showProfessionalInfo,_that.showInstagram,_that.showFacebook,_that.showLinkedin,_that.showTwitter,_that.isFindmatch);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? userId,  bool? showMobileNumber,  bool? showEmail,  bool? showGotra,  bool? showFamilyInfo,  bool? showMaternalInfo,  bool? showBusinessInfo,  bool? showProfessionalInfo,  bool? showInstagram,  bool? showFacebook,  bool? showLinkedin,  bool? showTwitter,  bool? isFindmatch)  $default,) {final _that = this;
switch (_that) {
case _PrivacySettings():
return $default(_that.id,_that.userId,_that.showMobileNumber,_that.showEmail,_that.showGotra,_that.showFamilyInfo,_that.showMaternalInfo,_that.showBusinessInfo,_that.showProfessionalInfo,_that.showInstagram,_that.showFacebook,_that.showLinkedin,_that.showTwitter,_that.isFindmatch);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? userId,  bool? showMobileNumber,  bool? showEmail,  bool? showGotra,  bool? showFamilyInfo,  bool? showMaternalInfo,  bool? showBusinessInfo,  bool? showProfessionalInfo,  bool? showInstagram,  bool? showFacebook,  bool? showLinkedin,  bool? showTwitter,  bool? isFindmatch)?  $default,) {final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
return $default(_that.id,_that.userId,_that.showMobileNumber,_that.showEmail,_that.showGotra,_that.showFamilyInfo,_that.showMaternalInfo,_that.showBusinessInfo,_that.showProfessionalInfo,_that.showInstagram,_that.showFacebook,_that.showLinkedin,_that.showTwitter,_that.isFindmatch);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrivacySettings implements PrivacySettings {
  const _PrivacySettings({this.id, this.userId, this.showMobileNumber, this.showEmail, this.showGotra, this.showFamilyInfo, this.showMaternalInfo, this.showBusinessInfo, this.showProfessionalInfo, this.showInstagram, this.showFacebook, this.showLinkedin, this.showTwitter, this.isFindmatch});
  factory _PrivacySettings.fromJson(Map<String, dynamic> json) => _$PrivacySettingsFromJson(json);

@override final  String? id;
@override final  String? userId;
@override final  bool? showMobileNumber;
@override final  bool? showEmail;
@override final  bool? showGotra;
@override final  bool? showFamilyInfo;
@override final  bool? showMaternalInfo;
@override final  bool? showBusinessInfo;
@override final  bool? showProfessionalInfo;
@override final  bool? showInstagram;
@override final  bool? showFacebook;
@override final  bool? showLinkedin;
@override final  bool? showTwitter;
@override final  bool? isFindmatch;

/// Create a copy of PrivacySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrivacySettingsCopyWith<_PrivacySettings> get copyWith => __$PrivacySettingsCopyWithImpl<_PrivacySettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrivacySettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrivacySettings&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.showMobileNumber, showMobileNumber) || other.showMobileNumber == showMobileNumber)&&(identical(other.showEmail, showEmail) || other.showEmail == showEmail)&&(identical(other.showGotra, showGotra) || other.showGotra == showGotra)&&(identical(other.showFamilyInfo, showFamilyInfo) || other.showFamilyInfo == showFamilyInfo)&&(identical(other.showMaternalInfo, showMaternalInfo) || other.showMaternalInfo == showMaternalInfo)&&(identical(other.showBusinessInfo, showBusinessInfo) || other.showBusinessInfo == showBusinessInfo)&&(identical(other.showProfessionalInfo, showProfessionalInfo) || other.showProfessionalInfo == showProfessionalInfo)&&(identical(other.showInstagram, showInstagram) || other.showInstagram == showInstagram)&&(identical(other.showFacebook, showFacebook) || other.showFacebook == showFacebook)&&(identical(other.showLinkedin, showLinkedin) || other.showLinkedin == showLinkedin)&&(identical(other.showTwitter, showTwitter) || other.showTwitter == showTwitter)&&(identical(other.isFindmatch, isFindmatch) || other.isFindmatch == isFindmatch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,showMobileNumber,showEmail,showGotra,showFamilyInfo,showMaternalInfo,showBusinessInfo,showProfessionalInfo,showInstagram,showFacebook,showLinkedin,showTwitter,isFindmatch);

@override
String toString() {
  return 'PrivacySettings(id: $id, userId: $userId, showMobileNumber: $showMobileNumber, showEmail: $showEmail, showGotra: $showGotra, showFamilyInfo: $showFamilyInfo, showMaternalInfo: $showMaternalInfo, showBusinessInfo: $showBusinessInfo, showProfessionalInfo: $showProfessionalInfo, showInstagram: $showInstagram, showFacebook: $showFacebook, showLinkedin: $showLinkedin, showTwitter: $showTwitter, isFindmatch: $isFindmatch)';
}


}

/// @nodoc
abstract mixin class _$PrivacySettingsCopyWith<$Res> implements $PrivacySettingsCopyWith<$Res> {
  factory _$PrivacySettingsCopyWith(_PrivacySettings value, $Res Function(_PrivacySettings) _then) = __$PrivacySettingsCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? userId, bool? showMobileNumber, bool? showEmail, bool? showGotra, bool? showFamilyInfo, bool? showMaternalInfo, bool? showBusinessInfo, bool? showProfessionalInfo, bool? showInstagram, bool? showFacebook, bool? showLinkedin, bool? showTwitter, bool? isFindmatch
});




}
/// @nodoc
class __$PrivacySettingsCopyWithImpl<$Res>
    implements _$PrivacySettingsCopyWith<$Res> {
  __$PrivacySettingsCopyWithImpl(this._self, this._then);

  final _PrivacySettings _self;
  final $Res Function(_PrivacySettings) _then;

/// Create a copy of PrivacySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? showMobileNumber = freezed,Object? showEmail = freezed,Object? showGotra = freezed,Object? showFamilyInfo = freezed,Object? showMaternalInfo = freezed,Object? showBusinessInfo = freezed,Object? showProfessionalInfo = freezed,Object? showInstagram = freezed,Object? showFacebook = freezed,Object? showLinkedin = freezed,Object? showTwitter = freezed,Object? isFindmatch = freezed,}) {
  return _then(_PrivacySettings(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,showMobileNumber: freezed == showMobileNumber ? _self.showMobileNumber : showMobileNumber // ignore: cast_nullable_to_non_nullable
as bool?,showEmail: freezed == showEmail ? _self.showEmail : showEmail // ignore: cast_nullable_to_non_nullable
as bool?,showGotra: freezed == showGotra ? _self.showGotra : showGotra // ignore: cast_nullable_to_non_nullable
as bool?,showFamilyInfo: freezed == showFamilyInfo ? _self.showFamilyInfo : showFamilyInfo // ignore: cast_nullable_to_non_nullable
as bool?,showMaternalInfo: freezed == showMaternalInfo ? _self.showMaternalInfo : showMaternalInfo // ignore: cast_nullable_to_non_nullable
as bool?,showBusinessInfo: freezed == showBusinessInfo ? _self.showBusinessInfo : showBusinessInfo // ignore: cast_nullable_to_non_nullable
as bool?,showProfessionalInfo: freezed == showProfessionalInfo ? _self.showProfessionalInfo : showProfessionalInfo // ignore: cast_nullable_to_non_nullable
as bool?,showInstagram: freezed == showInstagram ? _self.showInstagram : showInstagram // ignore: cast_nullable_to_non_nullable
as bool?,showFacebook: freezed == showFacebook ? _self.showFacebook : showFacebook // ignore: cast_nullable_to_non_nullable
as bool?,showLinkedin: freezed == showLinkedin ? _self.showLinkedin : showLinkedin // ignore: cast_nullable_to_non_nullable
as bool?,showTwitter: freezed == showTwitter ? _self.showTwitter : showTwitter // ignore: cast_nullable_to_non_nullable
as bool?,isFindmatch: freezed == isFindmatch ? _self.isFindmatch : isFindmatch // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$QrCodeDetails {

 String? get id; String? get code;@JsonKey(readValue: readQrUrl) String? get qrImageUrl;
/// Create a copy of QrCodeDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrCodeDetailsCopyWith<QrCodeDetails> get copyWith => _$QrCodeDetailsCopyWithImpl<QrCodeDetails>(this as QrCodeDetails, _$identity);

  /// Serializes this QrCodeDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrCodeDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.qrImageUrl, qrImageUrl) || other.qrImageUrl == qrImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,qrImageUrl);

@override
String toString() {
  return 'QrCodeDetails(id: $id, code: $code, qrImageUrl: $qrImageUrl)';
}


}

/// @nodoc
abstract mixin class $QrCodeDetailsCopyWith<$Res>  {
  factory $QrCodeDetailsCopyWith(QrCodeDetails value, $Res Function(QrCodeDetails) _then) = _$QrCodeDetailsCopyWithImpl;
@useResult
$Res call({
 String? id, String? code,@JsonKey(readValue: readQrUrl) String? qrImageUrl
});




}
/// @nodoc
class _$QrCodeDetailsCopyWithImpl<$Res>
    implements $QrCodeDetailsCopyWith<$Res> {
  _$QrCodeDetailsCopyWithImpl(this._self, this._then);

  final QrCodeDetails _self;
  final $Res Function(QrCodeDetails) _then;

/// Create a copy of QrCodeDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? code = freezed,Object? qrImageUrl = freezed,}) {
  return _then(QrCodeDetails(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,qrImageUrl: freezed == qrImageUrl ? _self.qrImageUrl : qrImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QrCodeDetails].
extension QrCodeDetailsPatterns on QrCodeDetails {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QrCodeDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QrCodeDetails() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QrCodeDetails value)  $default,){
final _that = this;
switch (_that) {
case _QrCodeDetails():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QrCodeDetails value)?  $default,){
final _that = this;
switch (_that) {
case _QrCodeDetails() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? code, @JsonKey(readValue: readQrUrl)  String? qrImageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QrCodeDetails() when $default != null:
return $default(_that.id,_that.code,_that.qrImageUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? code, @JsonKey(readValue: readQrUrl)  String? qrImageUrl)  $default,) {final _that = this;
switch (_that) {
case _QrCodeDetails():
return $default(_that.id,_that.code,_that.qrImageUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? code, @JsonKey(readValue: readQrUrl)  String? qrImageUrl)?  $default,) {final _that = this;
switch (_that) {
case _QrCodeDetails() when $default != null:
return $default(_that.id,_that.code,_that.qrImageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QrCodeDetails implements QrCodeDetails {
  const _QrCodeDetails({this.id, this.code, @JsonKey(readValue: readQrUrl) this.qrImageUrl});
  factory _QrCodeDetails.fromJson(Map<String, dynamic> json) => _$QrCodeDetailsFromJson(json);

@override final  String? id;
@override final  String? code;
@override@JsonKey(readValue: readQrUrl) final  String? qrImageUrl;

/// Create a copy of QrCodeDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QrCodeDetailsCopyWith<_QrCodeDetails> get copyWith => __$QrCodeDetailsCopyWithImpl<_QrCodeDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QrCodeDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QrCodeDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.qrImageUrl, qrImageUrl) || other.qrImageUrl == qrImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,code,qrImageUrl);

@override
String toString() {
  return 'QrCodeDetails(id: $id, code: $code, qrImageUrl: $qrImageUrl)';
}


}

/// @nodoc
abstract mixin class _$QrCodeDetailsCopyWith<$Res> implements $QrCodeDetailsCopyWith<$Res> {
  factory _$QrCodeDetailsCopyWith(_QrCodeDetails value, $Res Function(_QrCodeDetails) _then) = __$QrCodeDetailsCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? code,@JsonKey(readValue: readQrUrl) String? qrImageUrl
});




}
/// @nodoc
class __$QrCodeDetailsCopyWithImpl<$Res>
    implements _$QrCodeDetailsCopyWith<$Res> {
  __$QrCodeDetailsCopyWithImpl(this._self, this._then);

  final _QrCodeDetails _self;
  final $Res Function(_QrCodeDetails) _then;

/// Create a copy of QrCodeDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? code = freezed,Object? qrImageUrl = freezed,}) {
  return _then(_QrCodeDetails(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,qrImageUrl: freezed == qrImageUrl ? _self.qrImageUrl : qrImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OwnedFamilyMember {

 String? get id; String? get fullName; String? get gender; String? get dob; String? get relationshipType; bool? get isDeceased; String? get photoUrl; String? get qrImageUrl; String? get linkedUserId;
/// Create a copy of OwnedFamilyMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnedFamilyMemberCopyWith<OwnedFamilyMember> get copyWith => _$OwnedFamilyMemberCopyWithImpl<OwnedFamilyMember>(this as OwnedFamilyMember, _$identity);

  /// Serializes this OwnedFamilyMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnedFamilyMember&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.relationshipType, relationshipType) || other.relationshipType == relationshipType)&&(identical(other.isDeceased, isDeceased) || other.isDeceased == isDeceased)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.qrImageUrl, qrImageUrl) || other.qrImageUrl == qrImageUrl)&&(identical(other.linkedUserId, linkedUserId) || other.linkedUserId == linkedUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,gender,dob,relationshipType,isDeceased,photoUrl,qrImageUrl,linkedUserId);

@override
String toString() {
  return 'OwnedFamilyMember(id: $id, fullName: $fullName, gender: $gender, dob: $dob, relationshipType: $relationshipType, isDeceased: $isDeceased, photoUrl: $photoUrl, qrImageUrl: $qrImageUrl, linkedUserId: $linkedUserId)';
}


}

/// @nodoc
abstract mixin class $OwnedFamilyMemberCopyWith<$Res>  {
  factory $OwnedFamilyMemberCopyWith(OwnedFamilyMember value, $Res Function(OwnedFamilyMember) _then) = _$OwnedFamilyMemberCopyWithImpl;
@useResult
$Res call({
 String? id, String? fullName, String? gender, String? dob, String? relationshipType, bool? isDeceased, String? photoUrl, String? qrImageUrl, String? linkedUserId
});




}
/// @nodoc
class _$OwnedFamilyMemberCopyWithImpl<$Res>
    implements $OwnedFamilyMemberCopyWith<$Res> {
  _$OwnedFamilyMemberCopyWithImpl(this._self, this._then);

  final OwnedFamilyMember _self;
  final $Res Function(OwnedFamilyMember) _then;

/// Create a copy of OwnedFamilyMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? fullName = freezed,Object? gender = freezed,Object? dob = freezed,Object? relationshipType = freezed,Object? isDeceased = freezed,Object? photoUrl = freezed,Object? qrImageUrl = freezed,Object? linkedUserId = freezed,}) {
  return _then(OwnedFamilyMember(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,relationshipType: freezed == relationshipType ? _self.relationshipType : relationshipType // ignore: cast_nullable_to_non_nullable
as String?,isDeceased: freezed == isDeceased ? _self.isDeceased : isDeceased // ignore: cast_nullable_to_non_nullable
as bool?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,qrImageUrl: freezed == qrImageUrl ? _self.qrImageUrl : qrImageUrl // ignore: cast_nullable_to_non_nullable
as String?,linkedUserId: freezed == linkedUserId ? _self.linkedUserId : linkedUserId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnedFamilyMember].
extension OwnedFamilyMemberPatterns on OwnedFamilyMember {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnedFamilyMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnedFamilyMember() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnedFamilyMember value)  $default,){
final _that = this;
switch (_that) {
case _OwnedFamilyMember():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnedFamilyMember value)?  $default,){
final _that = this;
switch (_that) {
case _OwnedFamilyMember() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? fullName,  String? gender,  String? dob,  String? relationshipType,  bool? isDeceased,  String? photoUrl,  String? qrImageUrl,  String? linkedUserId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnedFamilyMember() when $default != null:
return $default(_that.id,_that.fullName,_that.gender,_that.dob,_that.relationshipType,_that.isDeceased,_that.photoUrl,_that.qrImageUrl,_that.linkedUserId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? fullName,  String? gender,  String? dob,  String? relationshipType,  bool? isDeceased,  String? photoUrl,  String? qrImageUrl,  String? linkedUserId)  $default,) {final _that = this;
switch (_that) {
case _OwnedFamilyMember():
return $default(_that.id,_that.fullName,_that.gender,_that.dob,_that.relationshipType,_that.isDeceased,_that.photoUrl,_that.qrImageUrl,_that.linkedUserId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? fullName,  String? gender,  String? dob,  String? relationshipType,  bool? isDeceased,  String? photoUrl,  String? qrImageUrl,  String? linkedUserId)?  $default,) {final _that = this;
switch (_that) {
case _OwnedFamilyMember() when $default != null:
return $default(_that.id,_that.fullName,_that.gender,_that.dob,_that.relationshipType,_that.isDeceased,_that.photoUrl,_that.qrImageUrl,_that.linkedUserId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OwnedFamilyMember implements OwnedFamilyMember {
  const _OwnedFamilyMember({this.id, this.fullName, this.gender, this.dob, this.relationshipType, this.isDeceased, this.photoUrl, this.qrImageUrl, this.linkedUserId});
  factory _OwnedFamilyMember.fromJson(Map<String, dynamic> json) => _$OwnedFamilyMemberFromJson(json);

@override final  String? id;
@override final  String? fullName;
@override final  String? gender;
@override final  String? dob;
@override final  String? relationshipType;
@override final  bool? isDeceased;
@override final  String? photoUrl;
@override final  String? qrImageUrl;
@override final  String? linkedUserId;

/// Create a copy of OwnedFamilyMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnedFamilyMemberCopyWith<_OwnedFamilyMember> get copyWith => __$OwnedFamilyMemberCopyWithImpl<_OwnedFamilyMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OwnedFamilyMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnedFamilyMember&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.relationshipType, relationshipType) || other.relationshipType == relationshipType)&&(identical(other.isDeceased, isDeceased) || other.isDeceased == isDeceased)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.qrImageUrl, qrImageUrl) || other.qrImageUrl == qrImageUrl)&&(identical(other.linkedUserId, linkedUserId) || other.linkedUserId == linkedUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,gender,dob,relationshipType,isDeceased,photoUrl,qrImageUrl,linkedUserId);

@override
String toString() {
  return 'OwnedFamilyMember(id: $id, fullName: $fullName, gender: $gender, dob: $dob, relationshipType: $relationshipType, isDeceased: $isDeceased, photoUrl: $photoUrl, qrImageUrl: $qrImageUrl, linkedUserId: $linkedUserId)';
}


}

/// @nodoc
abstract mixin class _$OwnedFamilyMemberCopyWith<$Res> implements $OwnedFamilyMemberCopyWith<$Res> {
  factory _$OwnedFamilyMemberCopyWith(_OwnedFamilyMember value, $Res Function(_OwnedFamilyMember) _then) = __$OwnedFamilyMemberCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? fullName, String? gender, String? dob, String? relationshipType, bool? isDeceased, String? photoUrl, String? qrImageUrl, String? linkedUserId
});




}
/// @nodoc
class __$OwnedFamilyMemberCopyWithImpl<$Res>
    implements _$OwnedFamilyMemberCopyWith<$Res> {
  __$OwnedFamilyMemberCopyWithImpl(this._self, this._then);

  final _OwnedFamilyMember _self;
  final $Res Function(_OwnedFamilyMember) _then;

/// Create a copy of OwnedFamilyMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? fullName = freezed,Object? gender = freezed,Object? dob = freezed,Object? relationshipType = freezed,Object? isDeceased = freezed,Object? photoUrl = freezed,Object? qrImageUrl = freezed,Object? linkedUserId = freezed,}) {
  return _then(_OwnedFamilyMember(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,relationshipType: freezed == relationshipType ? _self.relationshipType : relationshipType // ignore: cast_nullable_to_non_nullable
as String?,isDeceased: freezed == isDeceased ? _self.isDeceased : isDeceased // ignore: cast_nullable_to_non_nullable
as bool?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,qrImageUrl: freezed == qrImageUrl ? _self.qrImageUrl : qrImageUrl // ignore: cast_nullable_to_non_nullable
as String?,linkedUserId: freezed == linkedUserId ? _self.linkedUserId : linkedUserId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
