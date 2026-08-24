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

 String? get id; String? get mobileNumber; String? get email; CoreProfile? get profile; JobDetails? get job; BusinessDetails? get business; PrivacySettings? get privacySettings;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.job, job) || other.job == job)&&(identical(other.business, business) || other.business == business)&&(identical(other.privacySettings, privacySettings) || other.privacySettings == privacySettings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,email,profile,job,business,privacySettings);

@override
String toString() {
  return 'UserProfile(id: $id, mobileNumber: $mobileNumber, email: $email, profile: $profile, job: $job, business: $business, privacySettings: $privacySettings)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String? id, String? mobileNumber, String? email, CoreProfile? profile, JobDetails? job, BusinessDetails? business, PrivacySettings? privacySettings
});


$CoreProfileCopyWith<$Res>? get profile;$JobDetailsCopyWith<$Res>? get job;$BusinessDetailsCopyWith<$Res>? get business;$PrivacySettingsCopyWith<$Res>? get privacySettings;

}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? mobileNumber = freezed,Object? email = freezed,Object? profile = freezed,Object? job = freezed,Object? business = freezed,Object? privacySettings = freezed,}) {
  return _then(UserProfile(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CoreProfile?,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as JobDetails?,business: freezed == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as BusinessDetails?,privacySettings: freezed == privacySettings ? _self.privacySettings : privacySettings // ignore: cast_nullable_to_non_nullable
as PrivacySettings?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? mobileNumber,  String? email,  CoreProfile? profile,  JobDetails? job,  BusinessDetails? business,  PrivacySettings? privacySettings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.mobileNumber,_that.email,_that.profile,_that.job,_that.business,_that.privacySettings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? mobileNumber,  String? email,  CoreProfile? profile,  JobDetails? job,  BusinessDetails? business,  PrivacySettings? privacySettings)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.mobileNumber,_that.email,_that.profile,_that.job,_that.business,_that.privacySettings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? mobileNumber,  String? email,  CoreProfile? profile,  JobDetails? job,  BusinessDetails? business,  PrivacySettings? privacySettings)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.mobileNumber,_that.email,_that.profile,_that.job,_that.business,_that.privacySettings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({this.id, this.mobileNumber, this.email, this.profile, this.job, this.business, this.privacySettings});
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String? id;
@override final  String? mobileNumber;
@override final  String? email;
@override final  CoreProfile? profile;
@override final  JobDetails? job;
@override final  BusinessDetails? business;
@override final  PrivacySettings? privacySettings;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.job, job) || other.job == job)&&(identical(other.business, business) || other.business == business)&&(identical(other.privacySettings, privacySettings) || other.privacySettings == privacySettings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,email,profile,job,business,privacySettings);

@override
String toString() {
  return 'UserProfile(id: $id, mobileNumber: $mobileNumber, email: $email, profile: $profile, job: $job, business: $business, privacySettings: $privacySettings)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? mobileNumber, String? email, CoreProfile? profile, JobDetails? job, BusinessDetails? business, PrivacySettings? privacySettings
});


@override $CoreProfileCopyWith<$Res>? get profile;@override $JobDetailsCopyWith<$Res>? get job;@override $BusinessDetailsCopyWith<$Res>? get business;@override $PrivacySettingsCopyWith<$Res>? get privacySettings;

}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? mobileNumber = freezed,Object? email = freezed,Object? profile = freezed,Object? job = freezed,Object? business = freezed,Object? privacySettings = freezed,}) {
  return _then(_UserProfile(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CoreProfile?,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as JobDetails?,business: freezed == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as BusinessDetails?,privacySettings: freezed == privacySettings ? _self.privacySettings : privacySettings // ignore: cast_nullable_to_non_nullable
as PrivacySettings?,
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
}
}


/// @nodoc
mixin _$CoreProfile {

 String? get fullName; String? get dob; String? get gender; String? get profilePhotoUrl; String? get city; String? get nativeVillage; String? get surname; String? get gotra;
/// Create a copy of CoreProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoreProfileCopyWith<CoreProfile> get copyWith => _$CoreProfileCopyWithImpl<CoreProfile>(this as CoreProfile, _$identity);

  /// Serializes this CoreProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoreProfile&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.profilePhotoUrl, profilePhotoUrl) || other.profilePhotoUrl == profilePhotoUrl)&&(identical(other.city, city) || other.city == city)&&(identical(other.nativeVillage, nativeVillage) || other.nativeVillage == nativeVillage)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.gotra, gotra) || other.gotra == gotra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,dob,gender,profilePhotoUrl,city,nativeVillage,surname,gotra);

@override
String toString() {
  return 'CoreProfile(fullName: $fullName, dob: $dob, gender: $gender, profilePhotoUrl: $profilePhotoUrl, city: $city, nativeVillage: $nativeVillage, surname: $surname, gotra: $gotra)';
}


}

/// @nodoc
abstract mixin class $CoreProfileCopyWith<$Res>  {
  factory $CoreProfileCopyWith(CoreProfile value, $Res Function(CoreProfile) _then) = _$CoreProfileCopyWithImpl;
@useResult
$Res call({
 String? fullName, String? dob, String? gender, String? profilePhotoUrl, String? city, String? nativeVillage, String? surname, String? gotra
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
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? dob = freezed,Object? gender = freezed,Object? profilePhotoUrl = freezed,Object? city = freezed,Object? nativeVillage = freezed,Object? surname = freezed,Object? gotra = freezed,}) {
  return _then(CoreProfile(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,profilePhotoUrl: freezed == profilePhotoUrl ? _self.profilePhotoUrl : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,nativeVillage: freezed == nativeVillage ? _self.nativeVillage : nativeVillage // ignore: cast_nullable_to_non_nullable
as String?,surname: freezed == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String?,gotra: freezed == gotra ? _self.gotra : gotra // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fullName,  String? dob,  String? gender,  String? profilePhotoUrl,  String? city,  String? nativeVillage,  String? surname,  String? gotra)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoreProfile() when $default != null:
return $default(_that.fullName,_that.dob,_that.gender,_that.profilePhotoUrl,_that.city,_that.nativeVillage,_that.surname,_that.gotra);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fullName,  String? dob,  String? gender,  String? profilePhotoUrl,  String? city,  String? nativeVillage,  String? surname,  String? gotra)  $default,) {final _that = this;
switch (_that) {
case _CoreProfile():
return $default(_that.fullName,_that.dob,_that.gender,_that.profilePhotoUrl,_that.city,_that.nativeVillage,_that.surname,_that.gotra);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fullName,  String? dob,  String? gender,  String? profilePhotoUrl,  String? city,  String? nativeVillage,  String? surname,  String? gotra)?  $default,) {final _that = this;
switch (_that) {
case _CoreProfile() when $default != null:
return $default(_that.fullName,_that.dob,_that.gender,_that.profilePhotoUrl,_that.city,_that.nativeVillage,_that.surname,_that.gotra);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoreProfile implements CoreProfile {
  const _CoreProfile({this.fullName, this.dob, this.gender, this.profilePhotoUrl, this.city, this.nativeVillage, this.surname, this.gotra});
  factory _CoreProfile.fromJson(Map<String, dynamic> json) => _$CoreProfileFromJson(json);

@override final  String? fullName;
@override final  String? dob;
@override final  String? gender;
@override final  String? profilePhotoUrl;
@override final  String? city;
@override final  String? nativeVillage;
@override final  String? surname;
@override final  String? gotra;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoreProfile&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.profilePhotoUrl, profilePhotoUrl) || other.profilePhotoUrl == profilePhotoUrl)&&(identical(other.city, city) || other.city == city)&&(identical(other.nativeVillage, nativeVillage) || other.nativeVillage == nativeVillage)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.gotra, gotra) || other.gotra == gotra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,dob,gender,profilePhotoUrl,city,nativeVillage,surname,gotra);

@override
String toString() {
  return 'CoreProfile(fullName: $fullName, dob: $dob, gender: $gender, profilePhotoUrl: $profilePhotoUrl, city: $city, nativeVillage: $nativeVillage, surname: $surname, gotra: $gotra)';
}


}

/// @nodoc
abstract mixin class _$CoreProfileCopyWith<$Res> implements $CoreProfileCopyWith<$Res> {
  factory _$CoreProfileCopyWith(_CoreProfile value, $Res Function(_CoreProfile) _then) = __$CoreProfileCopyWithImpl;
@override @useResult
$Res call({
 String? fullName, String? dob, String? gender, String? profilePhotoUrl, String? city, String? nativeVillage, String? surname, String? gotra
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
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? dob = freezed,Object? gender = freezed,Object? profilePhotoUrl = freezed,Object? city = freezed,Object? nativeVillage = freezed,Object? surname = freezed,Object? gotra = freezed,}) {
  return _then(_CoreProfile(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,profilePhotoUrl: freezed == profilePhotoUrl ? _self.profilePhotoUrl : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,nativeVillage: freezed == nativeVillage ? _self.nativeVillage : nativeVillage // ignore: cast_nullable_to_non_nullable
as String?,surname: freezed == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String?,gotra: freezed == gotra ? _self.gotra : gotra // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$JobDetails {

 String? get companyName; String? get designation; String? get industry; int? get yearsOfExperience;
/// Create a copy of JobDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobDetailsCopyWith<JobDetails> get copyWith => _$JobDetailsCopyWithImpl<JobDetails>(this as JobDetails, _$identity);

  /// Serializes this JobDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobDetails&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.yearsOfExperience, yearsOfExperience) || other.yearsOfExperience == yearsOfExperience));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,companyName,designation,industry,yearsOfExperience);

@override
String toString() {
  return 'JobDetails(companyName: $companyName, designation: $designation, industry: $industry, yearsOfExperience: $yearsOfExperience)';
}


}

/// @nodoc
abstract mixin class $JobDetailsCopyWith<$Res>  {
  factory $JobDetailsCopyWith(JobDetails value, $Res Function(JobDetails) _then) = _$JobDetailsCopyWithImpl;
@useResult
$Res call({
 String? companyName, String? designation, String? industry, int? yearsOfExperience
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
@pragma('vm:prefer-inline') @override $Res call({Object? companyName = freezed,Object? designation = freezed,Object? industry = freezed,Object? yearsOfExperience = freezed,}) {
  return _then(JobDetails(
companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,industry: freezed == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String?,yearsOfExperience: freezed == yearsOfExperience ? _self.yearsOfExperience : yearsOfExperience // ignore: cast_nullable_to_non_nullable
as int?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? companyName,  String? designation,  String? industry,  int? yearsOfExperience)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobDetails() when $default != null:
return $default(_that.companyName,_that.designation,_that.industry,_that.yearsOfExperience);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? companyName,  String? designation,  String? industry,  int? yearsOfExperience)  $default,) {final _that = this;
switch (_that) {
case _JobDetails():
return $default(_that.companyName,_that.designation,_that.industry,_that.yearsOfExperience);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? companyName,  String? designation,  String? industry,  int? yearsOfExperience)?  $default,) {final _that = this;
switch (_that) {
case _JobDetails() when $default != null:
return $default(_that.companyName,_that.designation,_that.industry,_that.yearsOfExperience);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobDetails implements JobDetails {
  const _JobDetails({this.companyName, this.designation, this.industry, this.yearsOfExperience});
  factory _JobDetails.fromJson(Map<String, dynamic> json) => _$JobDetailsFromJson(json);

@override final  String? companyName;
@override final  String? designation;
@override final  String? industry;
@override final  int? yearsOfExperience;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobDetails&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.yearsOfExperience, yearsOfExperience) || other.yearsOfExperience == yearsOfExperience));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,companyName,designation,industry,yearsOfExperience);

@override
String toString() {
  return 'JobDetails(companyName: $companyName, designation: $designation, industry: $industry, yearsOfExperience: $yearsOfExperience)';
}


}

/// @nodoc
abstract mixin class _$JobDetailsCopyWith<$Res> implements $JobDetailsCopyWith<$Res> {
  factory _$JobDetailsCopyWith(_JobDetails value, $Res Function(_JobDetails) _then) = __$JobDetailsCopyWithImpl;
@override @useResult
$Res call({
 String? companyName, String? designation, String? industry, int? yearsOfExperience
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
@override @pragma('vm:prefer-inline') $Res call({Object? companyName = freezed,Object? designation = freezed,Object? industry = freezed,Object? yearsOfExperience = freezed,}) {
  return _then(_JobDetails(
companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,industry: freezed == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String?,yearsOfExperience: freezed == yearsOfExperience ? _self.yearsOfExperience : yearsOfExperience // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$BusinessDetails {

 String? get businessName; String? get category; String? get productsServices; String? get address; String? get website;
/// Create a copy of BusinessDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessDetailsCopyWith<BusinessDetails> get copyWith => _$BusinessDetailsCopyWithImpl<BusinessDetails>(this as BusinessDetails, _$identity);

  /// Serializes this BusinessDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessDetails&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.category, category) || other.category == category)&&(identical(other.productsServices, productsServices) || other.productsServices == productsServices)&&(identical(other.address, address) || other.address == address)&&(identical(other.website, website) || other.website == website));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,businessName,category,productsServices,address,website);

@override
String toString() {
  return 'BusinessDetails(businessName: $businessName, category: $category, productsServices: $productsServices, address: $address, website: $website)';
}


}

/// @nodoc
abstract mixin class $BusinessDetailsCopyWith<$Res>  {
  factory $BusinessDetailsCopyWith(BusinessDetails value, $Res Function(BusinessDetails) _then) = _$BusinessDetailsCopyWithImpl;
@useResult
$Res call({
 String? businessName, String? category, String? productsServices, String? address, String? website
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
@pragma('vm:prefer-inline') @override $Res call({Object? businessName = freezed,Object? category = freezed,Object? productsServices = freezed,Object? address = freezed,Object? website = freezed,}) {
  return _then(BusinessDetails(
businessName: freezed == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,productsServices: freezed == productsServices ? _self.productsServices : productsServices // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? businessName,  String? category,  String? productsServices,  String? address,  String? website)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessDetails() when $default != null:
return $default(_that.businessName,_that.category,_that.productsServices,_that.address,_that.website);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? businessName,  String? category,  String? productsServices,  String? address,  String? website)  $default,) {final _that = this;
switch (_that) {
case _BusinessDetails():
return $default(_that.businessName,_that.category,_that.productsServices,_that.address,_that.website);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? businessName,  String? category,  String? productsServices,  String? address,  String? website)?  $default,) {final _that = this;
switch (_that) {
case _BusinessDetails() when $default != null:
return $default(_that.businessName,_that.category,_that.productsServices,_that.address,_that.website);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessDetails implements BusinessDetails {
  const _BusinessDetails({this.businessName, this.category, this.productsServices, this.address, this.website});
  factory _BusinessDetails.fromJson(Map<String, dynamic> json) => _$BusinessDetailsFromJson(json);

@override final  String? businessName;
@override final  String? category;
@override final  String? productsServices;
@override final  String? address;
@override final  String? website;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessDetails&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.category, category) || other.category == category)&&(identical(other.productsServices, productsServices) || other.productsServices == productsServices)&&(identical(other.address, address) || other.address == address)&&(identical(other.website, website) || other.website == website));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,businessName,category,productsServices,address,website);

@override
String toString() {
  return 'BusinessDetails(businessName: $businessName, category: $category, productsServices: $productsServices, address: $address, website: $website)';
}


}

/// @nodoc
abstract mixin class _$BusinessDetailsCopyWith<$Res> implements $BusinessDetailsCopyWith<$Res> {
  factory _$BusinessDetailsCopyWith(_BusinessDetails value, $Res Function(_BusinessDetails) _then) = __$BusinessDetailsCopyWithImpl;
@override @useResult
$Res call({
 String? businessName, String? category, String? productsServices, String? address, String? website
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
@override @pragma('vm:prefer-inline') $Res call({Object? businessName = freezed,Object? category = freezed,Object? productsServices = freezed,Object? address = freezed,Object? website = freezed,}) {
  return _then(_BusinessDetails(
businessName: freezed == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,productsServices: freezed == productsServices ? _self.productsServices : productsServices // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PrivacySettings {

 bool? get showMobileNumber; bool? get showEmail; bool? get showFamilyInfo; bool? get showBusinessInfo; bool? get showProfessionalInfo;
/// Create a copy of PrivacySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrivacySettingsCopyWith<PrivacySettings> get copyWith => _$PrivacySettingsCopyWithImpl<PrivacySettings>(this as PrivacySettings, _$identity);

  /// Serializes this PrivacySettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrivacySettings&&(identical(other.showMobileNumber, showMobileNumber) || other.showMobileNumber == showMobileNumber)&&(identical(other.showEmail, showEmail) || other.showEmail == showEmail)&&(identical(other.showFamilyInfo, showFamilyInfo) || other.showFamilyInfo == showFamilyInfo)&&(identical(other.showBusinessInfo, showBusinessInfo) || other.showBusinessInfo == showBusinessInfo)&&(identical(other.showProfessionalInfo, showProfessionalInfo) || other.showProfessionalInfo == showProfessionalInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showMobileNumber,showEmail,showFamilyInfo,showBusinessInfo,showProfessionalInfo);

@override
String toString() {
  return 'PrivacySettings(showMobileNumber: $showMobileNumber, showEmail: $showEmail, showFamilyInfo: $showFamilyInfo, showBusinessInfo: $showBusinessInfo, showProfessionalInfo: $showProfessionalInfo)';
}


}

/// @nodoc
abstract mixin class $PrivacySettingsCopyWith<$Res>  {
  factory $PrivacySettingsCopyWith(PrivacySettings value, $Res Function(PrivacySettings) _then) = _$PrivacySettingsCopyWithImpl;
@useResult
$Res call({
 bool? showMobileNumber, bool? showEmail, bool? showFamilyInfo, bool? showBusinessInfo, bool? showProfessionalInfo
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
@pragma('vm:prefer-inline') @override $Res call({Object? showMobileNumber = freezed,Object? showEmail = freezed,Object? showFamilyInfo = freezed,Object? showBusinessInfo = freezed,Object? showProfessionalInfo = freezed,}) {
  return _then(PrivacySettings(
showMobileNumber: freezed == showMobileNumber ? _self.showMobileNumber : showMobileNumber // ignore: cast_nullable_to_non_nullable
as bool?,showEmail: freezed == showEmail ? _self.showEmail : showEmail // ignore: cast_nullable_to_non_nullable
as bool?,showFamilyInfo: freezed == showFamilyInfo ? _self.showFamilyInfo : showFamilyInfo // ignore: cast_nullable_to_non_nullable
as bool?,showBusinessInfo: freezed == showBusinessInfo ? _self.showBusinessInfo : showBusinessInfo // ignore: cast_nullable_to_non_nullable
as bool?,showProfessionalInfo: freezed == showProfessionalInfo ? _self.showProfessionalInfo : showProfessionalInfo // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? showMobileNumber,  bool? showEmail,  bool? showFamilyInfo,  bool? showBusinessInfo,  bool? showProfessionalInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
return $default(_that.showMobileNumber,_that.showEmail,_that.showFamilyInfo,_that.showBusinessInfo,_that.showProfessionalInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? showMobileNumber,  bool? showEmail,  bool? showFamilyInfo,  bool? showBusinessInfo,  bool? showProfessionalInfo)  $default,) {final _that = this;
switch (_that) {
case _PrivacySettings():
return $default(_that.showMobileNumber,_that.showEmail,_that.showFamilyInfo,_that.showBusinessInfo,_that.showProfessionalInfo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? showMobileNumber,  bool? showEmail,  bool? showFamilyInfo,  bool? showBusinessInfo,  bool? showProfessionalInfo)?  $default,) {final _that = this;
switch (_that) {
case _PrivacySettings() when $default != null:
return $default(_that.showMobileNumber,_that.showEmail,_that.showFamilyInfo,_that.showBusinessInfo,_that.showProfessionalInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrivacySettings implements PrivacySettings {
  const _PrivacySettings({this.showMobileNumber, this.showEmail, this.showFamilyInfo, this.showBusinessInfo, this.showProfessionalInfo});
  factory _PrivacySettings.fromJson(Map<String, dynamic> json) => _$PrivacySettingsFromJson(json);

@override final  bool? showMobileNumber;
@override final  bool? showEmail;
@override final  bool? showFamilyInfo;
@override final  bool? showBusinessInfo;
@override final  bool? showProfessionalInfo;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrivacySettings&&(identical(other.showMobileNumber, showMobileNumber) || other.showMobileNumber == showMobileNumber)&&(identical(other.showEmail, showEmail) || other.showEmail == showEmail)&&(identical(other.showFamilyInfo, showFamilyInfo) || other.showFamilyInfo == showFamilyInfo)&&(identical(other.showBusinessInfo, showBusinessInfo) || other.showBusinessInfo == showBusinessInfo)&&(identical(other.showProfessionalInfo, showProfessionalInfo) || other.showProfessionalInfo == showProfessionalInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showMobileNumber,showEmail,showFamilyInfo,showBusinessInfo,showProfessionalInfo);

@override
String toString() {
  return 'PrivacySettings(showMobileNumber: $showMobileNumber, showEmail: $showEmail, showFamilyInfo: $showFamilyInfo, showBusinessInfo: $showBusinessInfo, showProfessionalInfo: $showProfessionalInfo)';
}


}

/// @nodoc
abstract mixin class _$PrivacySettingsCopyWith<$Res> implements $PrivacySettingsCopyWith<$Res> {
  factory _$PrivacySettingsCopyWith(_PrivacySettings value, $Res Function(_PrivacySettings) _then) = __$PrivacySettingsCopyWithImpl;
@override @useResult
$Res call({
 bool? showMobileNumber, bool? showEmail, bool? showFamilyInfo, bool? showBusinessInfo, bool? showProfessionalInfo
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
@override @pragma('vm:prefer-inline') $Res call({Object? showMobileNumber = freezed,Object? showEmail = freezed,Object? showFamilyInfo = freezed,Object? showBusinessInfo = freezed,Object? showProfessionalInfo = freezed,}) {
  return _then(_PrivacySettings(
showMobileNumber: freezed == showMobileNumber ? _self.showMobileNumber : showMobileNumber // ignore: cast_nullable_to_non_nullable
as bool?,showEmail: freezed == showEmail ? _self.showEmail : showEmail // ignore: cast_nullable_to_non_nullable
as bool?,showFamilyInfo: freezed == showFamilyInfo ? _self.showFamilyInfo : showFamilyInfo // ignore: cast_nullable_to_non_nullable
as bool?,showBusinessInfo: freezed == showBusinessInfo ? _self.showBusinessInfo : showBusinessInfo // ignore: cast_nullable_to_non_nullable
as bool?,showProfessionalInfo: freezed == showProfessionalInfo ? _self.showProfessionalInfo : showProfessionalInfo // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
