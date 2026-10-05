// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'family_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FamilyMember {

 String? get id; String? get title; String? get fullName; String? get gender; String? get dob;@JsonKey(readValue: readRelationship) String? get relationshipType; String? get directRelationship; String? get relationshipToViewer; bool? get isDeceased; bool? get isMinor; bool? get isRegisteredUser; String? get photoUrl; String? get qrImageUrl; String? get linkedMobile; String? get linkedUserId; String? get ownerUserId; bool? get privacyProtected; PrivacySettings? get privacySettings; String? get state; String? get city; String? get nativeVillage; String? get surname; String? get gotra; String? get subCaste; String? get timeOfBirth; String? get disability; String? get manglik; String? get maternalSurname; String? get maternalGotra; String? get address; String? get bio; String? get education; String? get email; String? get height; String? get instagram; String? get facebook; String? get linkedin; String? get twitter; Map<String, dynamic>? get job; Map<String, dynamic>? get business;
/// Create a copy of FamilyMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyMemberCopyWith<FamilyMember> get copyWith => _$FamilyMemberCopyWithImpl<FamilyMember>(this as FamilyMember, _$identity);

  /// Serializes this FamilyMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyMember&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.relationshipType, relationshipType) || other.relationshipType == relationshipType)&&(identical(other.directRelationship, directRelationship) || other.directRelationship == directRelationship)&&(identical(other.relationshipToViewer, relationshipToViewer) || other.relationshipToViewer == relationshipToViewer)&&(identical(other.isDeceased, isDeceased) || other.isDeceased == isDeceased)&&(identical(other.isMinor, isMinor) || other.isMinor == isMinor)&&(identical(other.isRegisteredUser, isRegisteredUser) || other.isRegisteredUser == isRegisteredUser)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.qrImageUrl, qrImageUrl) || other.qrImageUrl == qrImageUrl)&&(identical(other.linkedMobile, linkedMobile) || other.linkedMobile == linkedMobile)&&(identical(other.linkedUserId, linkedUserId) || other.linkedUserId == linkedUserId)&&(identical(other.ownerUserId, ownerUserId) || other.ownerUserId == ownerUserId)&&(identical(other.privacyProtected, privacyProtected) || other.privacyProtected == privacyProtected)&&(identical(other.privacySettings, privacySettings) || other.privacySettings == privacySettings)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.nativeVillage, nativeVillage) || other.nativeVillage == nativeVillage)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.gotra, gotra) || other.gotra == gotra)&&(identical(other.subCaste, subCaste) || other.subCaste == subCaste)&&(identical(other.timeOfBirth, timeOfBirth) || other.timeOfBirth == timeOfBirth)&&(identical(other.disability, disability) || other.disability == disability)&&(identical(other.manglik, manglik) || other.manglik == manglik)&&(identical(other.maternalSurname, maternalSurname) || other.maternalSurname == maternalSurname)&&(identical(other.maternalGotra, maternalGotra) || other.maternalGotra == maternalGotra)&&(identical(other.address, address) || other.address == address)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.education, education) || other.education == education)&&(identical(other.email, email) || other.email == email)&&(identical(other.height, height) || other.height == height)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.twitter, twitter) || other.twitter == twitter)&&const DeepCollectionEquality().equals(other.job, job)&&const DeepCollectionEquality().equals(other.business, business));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,fullName,gender,dob,relationshipType,directRelationship,relationshipToViewer,isDeceased,isMinor,isRegisteredUser,photoUrl,qrImageUrl,linkedMobile,linkedUserId,ownerUserId,privacyProtected,privacySettings,state,city,nativeVillage,surname,gotra,subCaste,timeOfBirth,disability,manglik,maternalSurname,maternalGotra,address,bio,education,email,height,instagram,facebook,linkedin,twitter,const DeepCollectionEquality().hash(job),const DeepCollectionEquality().hash(business)]);

@override
String toString() {
  return 'FamilyMember(id: $id, title: $title, fullName: $fullName, gender: $gender, dob: $dob, relationshipType: $relationshipType, directRelationship: $directRelationship, relationshipToViewer: $relationshipToViewer, isDeceased: $isDeceased, isMinor: $isMinor, isRegisteredUser: $isRegisteredUser, photoUrl: $photoUrl, qrImageUrl: $qrImageUrl, linkedMobile: $linkedMobile, linkedUserId: $linkedUserId, ownerUserId: $ownerUserId, privacyProtected: $privacyProtected, privacySettings: $privacySettings, state: $state, city: $city, nativeVillage: $nativeVillage, surname: $surname, gotra: $gotra, subCaste: $subCaste, timeOfBirth: $timeOfBirth, disability: $disability, manglik: $manglik, maternalSurname: $maternalSurname, maternalGotra: $maternalGotra, address: $address, bio: $bio, education: $education, email: $email, height: $height, instagram: $instagram, facebook: $facebook, linkedin: $linkedin, twitter: $twitter, job: $job, business: $business)';
}


}

/// @nodoc
abstract mixin class $FamilyMemberCopyWith<$Res>  {
  factory $FamilyMemberCopyWith(FamilyMember value, $Res Function(FamilyMember) _then) = _$FamilyMemberCopyWithImpl;
@useResult
$Res call({
 String? id, String? title, String? fullName, String? gender, String? dob,@JsonKey(readValue: readRelationship) String? relationshipType, String? directRelationship, String? relationshipToViewer, bool? isDeceased, bool? isMinor, bool? isRegisteredUser, String? photoUrl, String? qrImageUrl, String? linkedMobile, String? linkedUserId, String? ownerUserId, bool? privacyProtected, PrivacySettings? privacySettings, String? state, String? city, String? nativeVillage, String? surname, String? gotra, String? subCaste, String? timeOfBirth, String? disability, String? manglik, String? maternalSurname, String? maternalGotra, String? address, String? bio, String? education, String? email, String? height, String? instagram, String? facebook, String? linkedin, String? twitter, Map<String, dynamic>? job, Map<String, dynamic>? business
});


$PrivacySettingsCopyWith<$Res>? get privacySettings;

}
/// @nodoc
class _$FamilyMemberCopyWithImpl<$Res>
    implements $FamilyMemberCopyWith<$Res> {
  _$FamilyMemberCopyWithImpl(this._self, this._then);

  final FamilyMember _self;
  final $Res Function(FamilyMember) _then;

/// Create a copy of FamilyMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? fullName = freezed,Object? gender = freezed,Object? dob = freezed,Object? relationshipType = freezed,Object? directRelationship = freezed,Object? relationshipToViewer = freezed,Object? isDeceased = freezed,Object? isMinor = freezed,Object? isRegisteredUser = freezed,Object? photoUrl = freezed,Object? qrImageUrl = freezed,Object? linkedMobile = freezed,Object? linkedUserId = freezed,Object? ownerUserId = freezed,Object? privacyProtected = freezed,Object? privacySettings = freezed,Object? state = freezed,Object? city = freezed,Object? nativeVillage = freezed,Object? surname = freezed,Object? gotra = freezed,Object? subCaste = freezed,Object? timeOfBirth = freezed,Object? disability = freezed,Object? manglik = freezed,Object? maternalSurname = freezed,Object? maternalGotra = freezed,Object? address = freezed,Object? bio = freezed,Object? education = freezed,Object? email = freezed,Object? height = freezed,Object? instagram = freezed,Object? facebook = freezed,Object? linkedin = freezed,Object? twitter = freezed,Object? job = freezed,Object? business = freezed,}) {
  return _then(FamilyMember(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,relationshipType: freezed == relationshipType ? _self.relationshipType : relationshipType // ignore: cast_nullable_to_non_nullable
as String?,directRelationship: freezed == directRelationship ? _self.directRelationship : directRelationship // ignore: cast_nullable_to_non_nullable
as String?,relationshipToViewer: freezed == relationshipToViewer ? _self.relationshipToViewer : relationshipToViewer // ignore: cast_nullable_to_non_nullable
as String?,isDeceased: freezed == isDeceased ? _self.isDeceased : isDeceased // ignore: cast_nullable_to_non_nullable
as bool?,isMinor: freezed == isMinor ? _self.isMinor : isMinor // ignore: cast_nullable_to_non_nullable
as bool?,isRegisteredUser: freezed == isRegisteredUser ? _self.isRegisteredUser : isRegisteredUser // ignore: cast_nullable_to_non_nullable
as bool?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,qrImageUrl: freezed == qrImageUrl ? _self.qrImageUrl : qrImageUrl // ignore: cast_nullable_to_non_nullable
as String?,linkedMobile: freezed == linkedMobile ? _self.linkedMobile : linkedMobile // ignore: cast_nullable_to_non_nullable
as String?,linkedUserId: freezed == linkedUserId ? _self.linkedUserId : linkedUserId // ignore: cast_nullable_to_non_nullable
as String?,ownerUserId: freezed == ownerUserId ? _self.ownerUserId : ownerUserId // ignore: cast_nullable_to_non_nullable
as String?,privacyProtected: freezed == privacyProtected ? _self.privacyProtected : privacyProtected // ignore: cast_nullable_to_non_nullable
as bool?,privacySettings: freezed == privacySettings ? _self.privacySettings : privacySettings // ignore: cast_nullable_to_non_nullable
as PrivacySettings?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,nativeVillage: freezed == nativeVillage ? _self.nativeVillage : nativeVillage // ignore: cast_nullable_to_non_nullable
as String?,surname: freezed == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String?,gotra: freezed == gotra ? _self.gotra : gotra // ignore: cast_nullable_to_non_nullable
as String?,subCaste: freezed == subCaste ? _self.subCaste : subCaste // ignore: cast_nullable_to_non_nullable
as String?,timeOfBirth: freezed == timeOfBirth ? _self.timeOfBirth : timeOfBirth // ignore: cast_nullable_to_non_nullable
as String?,disability: freezed == disability ? _self.disability : disability // ignore: cast_nullable_to_non_nullable
as String?,manglik: freezed == manglik ? _self.manglik : manglik // ignore: cast_nullable_to_non_nullable
as String?,maternalSurname: freezed == maternalSurname ? _self.maternalSurname : maternalSurname // ignore: cast_nullable_to_non_nullable
as String?,maternalGotra: freezed == maternalGotra ? _self.maternalGotra : maternalGotra // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,education: freezed == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,facebook: freezed == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String?,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,twitter: freezed == twitter ? _self.twitter : twitter // ignore: cast_nullable_to_non_nullable
as String?,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,business: freezed == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}
/// Create a copy of FamilyMember
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


/// Adds pattern-matching-related methods to [FamilyMember].
extension FamilyMemberPatterns on FamilyMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FamilyMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FamilyMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FamilyMember value)  $default,){
final _that = this;
switch (_that) {
case _FamilyMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FamilyMember value)?  $default,){
final _that = this;
switch (_that) {
case _FamilyMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? title,  String? fullName,  String? gender,  String? dob, @JsonKey(readValue: readRelationship)  String? relationshipType,  String? directRelationship,  String? relationshipToViewer,  bool? isDeceased,  bool? isMinor,  bool? isRegisteredUser,  String? photoUrl,  String? qrImageUrl,  String? linkedMobile,  String? linkedUserId,  String? ownerUserId,  bool? privacyProtected,  PrivacySettings? privacySettings,  String? state,  String? city,  String? nativeVillage,  String? surname,  String? gotra,  String? subCaste,  String? timeOfBirth,  String? disability,  String? manglik,  String? maternalSurname,  String? maternalGotra,  String? address,  String? bio,  String? education,  String? email,  String? height,  String? instagram,  String? facebook,  String? linkedin,  String? twitter,  Map<String, dynamic>? job,  Map<String, dynamic>? business)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FamilyMember() when $default != null:
return $default(_that.id,_that.title,_that.fullName,_that.gender,_that.dob,_that.relationshipType,_that.directRelationship,_that.relationshipToViewer,_that.isDeceased,_that.isMinor,_that.isRegisteredUser,_that.photoUrl,_that.qrImageUrl,_that.linkedMobile,_that.linkedUserId,_that.ownerUserId,_that.privacyProtected,_that.privacySettings,_that.state,_that.city,_that.nativeVillage,_that.surname,_that.gotra,_that.subCaste,_that.timeOfBirth,_that.disability,_that.manglik,_that.maternalSurname,_that.maternalGotra,_that.address,_that.bio,_that.education,_that.email,_that.height,_that.instagram,_that.facebook,_that.linkedin,_that.twitter,_that.job,_that.business);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? title,  String? fullName,  String? gender,  String? dob, @JsonKey(readValue: readRelationship)  String? relationshipType,  String? directRelationship,  String? relationshipToViewer,  bool? isDeceased,  bool? isMinor,  bool? isRegisteredUser,  String? photoUrl,  String? qrImageUrl,  String? linkedMobile,  String? linkedUserId,  String? ownerUserId,  bool? privacyProtected,  PrivacySettings? privacySettings,  String? state,  String? city,  String? nativeVillage,  String? surname,  String? gotra,  String? subCaste,  String? timeOfBirth,  String? disability,  String? manglik,  String? maternalSurname,  String? maternalGotra,  String? address,  String? bio,  String? education,  String? email,  String? height,  String? instagram,  String? facebook,  String? linkedin,  String? twitter,  Map<String, dynamic>? job,  Map<String, dynamic>? business)  $default,) {final _that = this;
switch (_that) {
case _FamilyMember():
return $default(_that.id,_that.title,_that.fullName,_that.gender,_that.dob,_that.relationshipType,_that.directRelationship,_that.relationshipToViewer,_that.isDeceased,_that.isMinor,_that.isRegisteredUser,_that.photoUrl,_that.qrImageUrl,_that.linkedMobile,_that.linkedUserId,_that.ownerUserId,_that.privacyProtected,_that.privacySettings,_that.state,_that.city,_that.nativeVillage,_that.surname,_that.gotra,_that.subCaste,_that.timeOfBirth,_that.disability,_that.manglik,_that.maternalSurname,_that.maternalGotra,_that.address,_that.bio,_that.education,_that.email,_that.height,_that.instagram,_that.facebook,_that.linkedin,_that.twitter,_that.job,_that.business);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? title,  String? fullName,  String? gender,  String? dob, @JsonKey(readValue: readRelationship)  String? relationshipType,  String? directRelationship,  String? relationshipToViewer,  bool? isDeceased,  bool? isMinor,  bool? isRegisteredUser,  String? photoUrl,  String? qrImageUrl,  String? linkedMobile,  String? linkedUserId,  String? ownerUserId,  bool? privacyProtected,  PrivacySettings? privacySettings,  String? state,  String? city,  String? nativeVillage,  String? surname,  String? gotra,  String? subCaste,  String? timeOfBirth,  String? disability,  String? manglik,  String? maternalSurname,  String? maternalGotra,  String? address,  String? bio,  String? education,  String? email,  String? height,  String? instagram,  String? facebook,  String? linkedin,  String? twitter,  Map<String, dynamic>? job,  Map<String, dynamic>? business)?  $default,) {final _that = this;
switch (_that) {
case _FamilyMember() when $default != null:
return $default(_that.id,_that.title,_that.fullName,_that.gender,_that.dob,_that.relationshipType,_that.directRelationship,_that.relationshipToViewer,_that.isDeceased,_that.isMinor,_that.isRegisteredUser,_that.photoUrl,_that.qrImageUrl,_that.linkedMobile,_that.linkedUserId,_that.ownerUserId,_that.privacyProtected,_that.privacySettings,_that.state,_that.city,_that.nativeVillage,_that.surname,_that.gotra,_that.subCaste,_that.timeOfBirth,_that.disability,_that.manglik,_that.maternalSurname,_that.maternalGotra,_that.address,_that.bio,_that.education,_that.email,_that.height,_that.instagram,_that.facebook,_that.linkedin,_that.twitter,_that.job,_that.business);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FamilyMember implements FamilyMember {
  const _FamilyMember({this.id, this.title, this.fullName, this.gender, this.dob, @JsonKey(readValue: readRelationship) this.relationshipType, this.directRelationship, this.relationshipToViewer, this.isDeceased, this.isMinor, this.isRegisteredUser, this.photoUrl, this.qrImageUrl, this.linkedMobile, this.linkedUserId, this.ownerUserId, this.privacyProtected, this.privacySettings, this.state, this.city, this.nativeVillage, this.surname, this.gotra, this.subCaste, this.timeOfBirth, this.disability, this.manglik, this.maternalSurname, this.maternalGotra, this.address, this.bio, this.education, this.email, this.height, this.instagram, this.facebook, this.linkedin, this.twitter,  Map<String, dynamic>? job,  Map<String, dynamic>? business}): _job = job,_business = business;
  factory _FamilyMember.fromJson(Map<String, dynamic> json) => _$FamilyMemberFromJson(json);

@override final  String? id;
@override final  String? title;
@override final  String? fullName;
@override final  String? gender;
@override final  String? dob;
@override@JsonKey(readValue: readRelationship) final  String? relationshipType;
@override final  String? directRelationship;
@override final  String? relationshipToViewer;
@override final  bool? isDeceased;
@override final  bool? isMinor;
@override final  bool? isRegisteredUser;
@override final  String? photoUrl;
@override final  String? qrImageUrl;
@override final  String? linkedMobile;
@override final  String? linkedUserId;
@override final  String? ownerUserId;
@override final  bool? privacyProtected;
@override final  PrivacySettings? privacySettings;
@override final  String? state;
@override final  String? city;
@override final  String? nativeVillage;
@override final  String? surname;
@override final  String? gotra;
@override final  String? subCaste;
@override final  String? timeOfBirth;
@override final  String? disability;
@override final  String? manglik;
@override final  String? maternalSurname;
@override final  String? maternalGotra;
@override final  String? address;
@override final  String? bio;
@override final  String? education;
@override final  String? email;
@override final  String? height;
@override final  String? instagram;
@override final  String? facebook;
@override final  String? linkedin;
@override final  String? twitter;
 final  Map<String, dynamic>? _job;
@override Map<String, dynamic>? get job {
  final value = _job;
  if (value == null) return null;
  if (_job is EqualUnmodifiableMapView) return _job;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _business;
@override Map<String, dynamic>? get business {
  final value = _business;
  if (value == null) return null;
  if (_business is EqualUnmodifiableMapView) return _business;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of FamilyMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FamilyMemberCopyWith<_FamilyMember> get copyWith => __$FamilyMemberCopyWithImpl<_FamilyMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FamilyMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyMember&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.relationshipType, relationshipType) || other.relationshipType == relationshipType)&&(identical(other.directRelationship, directRelationship) || other.directRelationship == directRelationship)&&(identical(other.relationshipToViewer, relationshipToViewer) || other.relationshipToViewer == relationshipToViewer)&&(identical(other.isDeceased, isDeceased) || other.isDeceased == isDeceased)&&(identical(other.isMinor, isMinor) || other.isMinor == isMinor)&&(identical(other.isRegisteredUser, isRegisteredUser) || other.isRegisteredUser == isRegisteredUser)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.qrImageUrl, qrImageUrl) || other.qrImageUrl == qrImageUrl)&&(identical(other.linkedMobile, linkedMobile) || other.linkedMobile == linkedMobile)&&(identical(other.linkedUserId, linkedUserId) || other.linkedUserId == linkedUserId)&&(identical(other.ownerUserId, ownerUserId) || other.ownerUserId == ownerUserId)&&(identical(other.privacyProtected, privacyProtected) || other.privacyProtected == privacyProtected)&&(identical(other.privacySettings, privacySettings) || other.privacySettings == privacySettings)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.nativeVillage, nativeVillage) || other.nativeVillage == nativeVillage)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.gotra, gotra) || other.gotra == gotra)&&(identical(other.subCaste, subCaste) || other.subCaste == subCaste)&&(identical(other.timeOfBirth, timeOfBirth) || other.timeOfBirth == timeOfBirth)&&(identical(other.disability, disability) || other.disability == disability)&&(identical(other.manglik, manglik) || other.manglik == manglik)&&(identical(other.maternalSurname, maternalSurname) || other.maternalSurname == maternalSurname)&&(identical(other.maternalGotra, maternalGotra) || other.maternalGotra == maternalGotra)&&(identical(other.address, address) || other.address == address)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.education, education) || other.education == education)&&(identical(other.email, email) || other.email == email)&&(identical(other.height, height) || other.height == height)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.twitter, twitter) || other.twitter == twitter)&&const DeepCollectionEquality().equals(other._job, _job)&&const DeepCollectionEquality().equals(other._business, _business));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,fullName,gender,dob,relationshipType,directRelationship,relationshipToViewer,isDeceased,isMinor,isRegisteredUser,photoUrl,qrImageUrl,linkedMobile,linkedUserId,ownerUserId,privacyProtected,privacySettings,state,city,nativeVillage,surname,gotra,subCaste,timeOfBirth,disability,manglik,maternalSurname,maternalGotra,address,bio,education,email,height,instagram,facebook,linkedin,twitter,const DeepCollectionEquality().hash(_job),const DeepCollectionEquality().hash(_business)]);

@override
String toString() {
  return 'FamilyMember(id: $id, title: $title, fullName: $fullName, gender: $gender, dob: $dob, relationshipType: $relationshipType, directRelationship: $directRelationship, relationshipToViewer: $relationshipToViewer, isDeceased: $isDeceased, isMinor: $isMinor, isRegisteredUser: $isRegisteredUser, photoUrl: $photoUrl, qrImageUrl: $qrImageUrl, linkedMobile: $linkedMobile, linkedUserId: $linkedUserId, ownerUserId: $ownerUserId, privacyProtected: $privacyProtected, privacySettings: $privacySettings, state: $state, city: $city, nativeVillage: $nativeVillage, surname: $surname, gotra: $gotra, subCaste: $subCaste, timeOfBirth: $timeOfBirth, disability: $disability, manglik: $manglik, maternalSurname: $maternalSurname, maternalGotra: $maternalGotra, address: $address, bio: $bio, education: $education, email: $email, height: $height, instagram: $instagram, facebook: $facebook, linkedin: $linkedin, twitter: $twitter, job: $job, business: $business)';
}


}

/// @nodoc
abstract mixin class _$FamilyMemberCopyWith<$Res> implements $FamilyMemberCopyWith<$Res> {
  factory _$FamilyMemberCopyWith(_FamilyMember value, $Res Function(_FamilyMember) _then) = __$FamilyMemberCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? title, String? fullName, String? gender, String? dob,@JsonKey(readValue: readRelationship) String? relationshipType, String? directRelationship, String? relationshipToViewer, bool? isDeceased, bool? isMinor, bool? isRegisteredUser, String? photoUrl, String? qrImageUrl, String? linkedMobile, String? linkedUserId, String? ownerUserId, bool? privacyProtected, PrivacySettings? privacySettings, String? state, String? city, String? nativeVillage, String? surname, String? gotra, String? subCaste, String? timeOfBirth, String? disability, String? manglik, String? maternalSurname, String? maternalGotra, String? address, String? bio, String? education, String? email, String? height, String? instagram, String? facebook, String? linkedin, String? twitter, Map<String, dynamic>? job, Map<String, dynamic>? business
});


@override $PrivacySettingsCopyWith<$Res>? get privacySettings;

}
/// @nodoc
class __$FamilyMemberCopyWithImpl<$Res>
    implements _$FamilyMemberCopyWith<$Res> {
  __$FamilyMemberCopyWithImpl(this._self, this._then);

  final _FamilyMember _self;
  final $Res Function(_FamilyMember) _then;

/// Create a copy of FamilyMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? fullName = freezed,Object? gender = freezed,Object? dob = freezed,Object? relationshipType = freezed,Object? directRelationship = freezed,Object? relationshipToViewer = freezed,Object? isDeceased = freezed,Object? isMinor = freezed,Object? isRegisteredUser = freezed,Object? photoUrl = freezed,Object? qrImageUrl = freezed,Object? linkedMobile = freezed,Object? linkedUserId = freezed,Object? ownerUserId = freezed,Object? privacyProtected = freezed,Object? privacySettings = freezed,Object? state = freezed,Object? city = freezed,Object? nativeVillage = freezed,Object? surname = freezed,Object? gotra = freezed,Object? subCaste = freezed,Object? timeOfBirth = freezed,Object? disability = freezed,Object? manglik = freezed,Object? maternalSurname = freezed,Object? maternalGotra = freezed,Object? address = freezed,Object? bio = freezed,Object? education = freezed,Object? email = freezed,Object? height = freezed,Object? instagram = freezed,Object? facebook = freezed,Object? linkedin = freezed,Object? twitter = freezed,Object? job = freezed,Object? business = freezed,}) {
  return _then(_FamilyMember(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,relationshipType: freezed == relationshipType ? _self.relationshipType : relationshipType // ignore: cast_nullable_to_non_nullable
as String?,directRelationship: freezed == directRelationship ? _self.directRelationship : directRelationship // ignore: cast_nullable_to_non_nullable
as String?,relationshipToViewer: freezed == relationshipToViewer ? _self.relationshipToViewer : relationshipToViewer // ignore: cast_nullable_to_non_nullable
as String?,isDeceased: freezed == isDeceased ? _self.isDeceased : isDeceased // ignore: cast_nullable_to_non_nullable
as bool?,isMinor: freezed == isMinor ? _self.isMinor : isMinor // ignore: cast_nullable_to_non_nullable
as bool?,isRegisteredUser: freezed == isRegisteredUser ? _self.isRegisteredUser : isRegisteredUser // ignore: cast_nullable_to_non_nullable
as bool?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,qrImageUrl: freezed == qrImageUrl ? _self.qrImageUrl : qrImageUrl // ignore: cast_nullable_to_non_nullable
as String?,linkedMobile: freezed == linkedMobile ? _self.linkedMobile : linkedMobile // ignore: cast_nullable_to_non_nullable
as String?,linkedUserId: freezed == linkedUserId ? _self.linkedUserId : linkedUserId // ignore: cast_nullable_to_non_nullable
as String?,ownerUserId: freezed == ownerUserId ? _self.ownerUserId : ownerUserId // ignore: cast_nullable_to_non_nullable
as String?,privacyProtected: freezed == privacyProtected ? _self.privacyProtected : privacyProtected // ignore: cast_nullable_to_non_nullable
as bool?,privacySettings: freezed == privacySettings ? _self.privacySettings : privacySettings // ignore: cast_nullable_to_non_nullable
as PrivacySettings?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,nativeVillage: freezed == nativeVillage ? _self.nativeVillage : nativeVillage // ignore: cast_nullable_to_non_nullable
as String?,surname: freezed == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String?,gotra: freezed == gotra ? _self.gotra : gotra // ignore: cast_nullable_to_non_nullable
as String?,subCaste: freezed == subCaste ? _self.subCaste : subCaste // ignore: cast_nullable_to_non_nullable
as String?,timeOfBirth: freezed == timeOfBirth ? _self.timeOfBirth : timeOfBirth // ignore: cast_nullable_to_non_nullable
as String?,disability: freezed == disability ? _self.disability : disability // ignore: cast_nullable_to_non_nullable
as String?,manglik: freezed == manglik ? _self.manglik : manglik // ignore: cast_nullable_to_non_nullable
as String?,maternalSurname: freezed == maternalSurname ? _self.maternalSurname : maternalSurname // ignore: cast_nullable_to_non_nullable
as String?,maternalGotra: freezed == maternalGotra ? _self.maternalGotra : maternalGotra // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,education: freezed == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,facebook: freezed == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String?,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,twitter: freezed == twitter ? _self.twitter : twitter // ignore: cast_nullable_to_non_nullable
as String?,job: freezed == job ? _self._job : job // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,business: freezed == business ? _self._business : business // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of FamilyMember
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
mixin _$FamilyTreeNode {

 String? get id; String? get title; String? get fullName; String? get gender; String? get dob;@JsonKey(readValue: readRelationship) String? get relationshipType; String? get directRelationship; String? get relationshipToViewer; bool? get isDeceased; bool? get isMinor; bool? get isRegisteredUser; String? get photoUrl; String? get qrImageUrl; String? get linkedMobile; String? get ownerUserId;@JsonKey(readValue: readUserId) String? get linkedUserId; bool? get privacyProtected; PrivacySettings? get privacySettings; String? get state; String? get city; String? get nativeVillage; String? get surname; String? get gotra; String? get subCaste; String? get timeOfBirth; String? get disability; String? get manglik; String? get maternalSurname; String? get maternalGotra; String? get address; String? get bio; String? get education; String? get email; String? get height; String? get instagram; String? get facebook; String? get linkedin; String? get twitter; Map<String, dynamic>? get job; Map<String, dynamic>? get business; List<FamilyTreeNode> get parents; List<FamilyTreeNode> get spouses; List<FamilyTreeNode> get siblings; List<FamilyTreeNode> get children;
/// Create a copy of FamilyTreeNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyTreeNodeCopyWith<FamilyTreeNode> get copyWith => _$FamilyTreeNodeCopyWithImpl<FamilyTreeNode>(this as FamilyTreeNode, _$identity);

  /// Serializes this FamilyTreeNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyTreeNode&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.relationshipType, relationshipType) || other.relationshipType == relationshipType)&&(identical(other.directRelationship, directRelationship) || other.directRelationship == directRelationship)&&(identical(other.relationshipToViewer, relationshipToViewer) || other.relationshipToViewer == relationshipToViewer)&&(identical(other.isDeceased, isDeceased) || other.isDeceased == isDeceased)&&(identical(other.isMinor, isMinor) || other.isMinor == isMinor)&&(identical(other.isRegisteredUser, isRegisteredUser) || other.isRegisteredUser == isRegisteredUser)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.qrImageUrl, qrImageUrl) || other.qrImageUrl == qrImageUrl)&&(identical(other.linkedMobile, linkedMobile) || other.linkedMobile == linkedMobile)&&(identical(other.ownerUserId, ownerUserId) || other.ownerUserId == ownerUserId)&&(identical(other.linkedUserId, linkedUserId) || other.linkedUserId == linkedUserId)&&(identical(other.privacyProtected, privacyProtected) || other.privacyProtected == privacyProtected)&&(identical(other.privacySettings, privacySettings) || other.privacySettings == privacySettings)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.nativeVillage, nativeVillage) || other.nativeVillage == nativeVillage)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.gotra, gotra) || other.gotra == gotra)&&(identical(other.subCaste, subCaste) || other.subCaste == subCaste)&&(identical(other.timeOfBirth, timeOfBirth) || other.timeOfBirth == timeOfBirth)&&(identical(other.disability, disability) || other.disability == disability)&&(identical(other.manglik, manglik) || other.manglik == manglik)&&(identical(other.maternalSurname, maternalSurname) || other.maternalSurname == maternalSurname)&&(identical(other.maternalGotra, maternalGotra) || other.maternalGotra == maternalGotra)&&(identical(other.address, address) || other.address == address)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.education, education) || other.education == education)&&(identical(other.email, email) || other.email == email)&&(identical(other.height, height) || other.height == height)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.twitter, twitter) || other.twitter == twitter)&&const DeepCollectionEquality().equals(other.job, job)&&const DeepCollectionEquality().equals(other.business, business)&&const DeepCollectionEquality().equals(other.parents, parents)&&const DeepCollectionEquality().equals(other.spouses, spouses)&&const DeepCollectionEquality().equals(other.siblings, siblings)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,fullName,gender,dob,relationshipType,directRelationship,relationshipToViewer,isDeceased,isMinor,isRegisteredUser,photoUrl,qrImageUrl,linkedMobile,ownerUserId,linkedUserId,privacyProtected,privacySettings,state,city,nativeVillage,surname,gotra,subCaste,timeOfBirth,disability,manglik,maternalSurname,maternalGotra,address,bio,education,email,height,instagram,facebook,linkedin,twitter,const DeepCollectionEquality().hash(job),const DeepCollectionEquality().hash(business),const DeepCollectionEquality().hash(parents),const DeepCollectionEquality().hash(spouses),const DeepCollectionEquality().hash(siblings),const DeepCollectionEquality().hash(children)]);

@override
String toString() {
  return 'FamilyTreeNode(id: $id, title: $title, fullName: $fullName, gender: $gender, dob: $dob, relationshipType: $relationshipType, directRelationship: $directRelationship, relationshipToViewer: $relationshipToViewer, isDeceased: $isDeceased, isMinor: $isMinor, isRegisteredUser: $isRegisteredUser, photoUrl: $photoUrl, qrImageUrl: $qrImageUrl, linkedMobile: $linkedMobile, ownerUserId: $ownerUserId, linkedUserId: $linkedUserId, privacyProtected: $privacyProtected, privacySettings: $privacySettings, state: $state, city: $city, nativeVillage: $nativeVillage, surname: $surname, gotra: $gotra, subCaste: $subCaste, timeOfBirth: $timeOfBirth, disability: $disability, manglik: $manglik, maternalSurname: $maternalSurname, maternalGotra: $maternalGotra, address: $address, bio: $bio, education: $education, email: $email, height: $height, instagram: $instagram, facebook: $facebook, linkedin: $linkedin, twitter: $twitter, job: $job, business: $business, parents: $parents, spouses: $spouses, siblings: $siblings, children: $children)';
}


}

/// @nodoc
abstract mixin class $FamilyTreeNodeCopyWith<$Res>  {
  factory $FamilyTreeNodeCopyWith(FamilyTreeNode value, $Res Function(FamilyTreeNode) _then) = _$FamilyTreeNodeCopyWithImpl;
@useResult
$Res call({
 String? id, String? title, String? fullName, String? gender, String? dob,@JsonKey(readValue: readRelationship) String? relationshipType, String? directRelationship, String? relationshipToViewer, bool? isDeceased, bool? isMinor, bool? isRegisteredUser, String? photoUrl, String? qrImageUrl, String? linkedMobile, String? ownerUserId,@JsonKey(readValue: readUserId) String? linkedUserId, bool? privacyProtected, PrivacySettings? privacySettings, String? state, String? city, String? nativeVillage, String? surname, String? gotra, String? subCaste, String? timeOfBirth, String? disability, String? manglik, String? maternalSurname, String? maternalGotra, String? address, String? bio, String? education, String? email, String? height, String? instagram, String? facebook, String? linkedin, String? twitter, Map<String, dynamic>? job, Map<String, dynamic>? business, List<FamilyTreeNode> parents, List<FamilyTreeNode> spouses, List<FamilyTreeNode> siblings, List<FamilyTreeNode> children
});


$PrivacySettingsCopyWith<$Res>? get privacySettings;

}
/// @nodoc
class _$FamilyTreeNodeCopyWithImpl<$Res>
    implements $FamilyTreeNodeCopyWith<$Res> {
  _$FamilyTreeNodeCopyWithImpl(this._self, this._then);

  final FamilyTreeNode _self;
  final $Res Function(FamilyTreeNode) _then;

/// Create a copy of FamilyTreeNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? fullName = freezed,Object? gender = freezed,Object? dob = freezed,Object? relationshipType = freezed,Object? directRelationship = freezed,Object? relationshipToViewer = freezed,Object? isDeceased = freezed,Object? isMinor = freezed,Object? isRegisteredUser = freezed,Object? photoUrl = freezed,Object? qrImageUrl = freezed,Object? linkedMobile = freezed,Object? ownerUserId = freezed,Object? linkedUserId = freezed,Object? privacyProtected = freezed,Object? privacySettings = freezed,Object? state = freezed,Object? city = freezed,Object? nativeVillage = freezed,Object? surname = freezed,Object? gotra = freezed,Object? subCaste = freezed,Object? timeOfBirth = freezed,Object? disability = freezed,Object? manglik = freezed,Object? maternalSurname = freezed,Object? maternalGotra = freezed,Object? address = freezed,Object? bio = freezed,Object? education = freezed,Object? email = freezed,Object? height = freezed,Object? instagram = freezed,Object? facebook = freezed,Object? linkedin = freezed,Object? twitter = freezed,Object? job = freezed,Object? business = freezed,Object? parents = null,Object? spouses = null,Object? siblings = null,Object? children = null,}) {
  return _then(FamilyTreeNode(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,relationshipType: freezed == relationshipType ? _self.relationshipType : relationshipType // ignore: cast_nullable_to_non_nullable
as String?,directRelationship: freezed == directRelationship ? _self.directRelationship : directRelationship // ignore: cast_nullable_to_non_nullable
as String?,relationshipToViewer: freezed == relationshipToViewer ? _self.relationshipToViewer : relationshipToViewer // ignore: cast_nullable_to_non_nullable
as String?,isDeceased: freezed == isDeceased ? _self.isDeceased : isDeceased // ignore: cast_nullable_to_non_nullable
as bool?,isMinor: freezed == isMinor ? _self.isMinor : isMinor // ignore: cast_nullable_to_non_nullable
as bool?,isRegisteredUser: freezed == isRegisteredUser ? _self.isRegisteredUser : isRegisteredUser // ignore: cast_nullable_to_non_nullable
as bool?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,qrImageUrl: freezed == qrImageUrl ? _self.qrImageUrl : qrImageUrl // ignore: cast_nullable_to_non_nullable
as String?,linkedMobile: freezed == linkedMobile ? _self.linkedMobile : linkedMobile // ignore: cast_nullable_to_non_nullable
as String?,ownerUserId: freezed == ownerUserId ? _self.ownerUserId : ownerUserId // ignore: cast_nullable_to_non_nullable
as String?,linkedUserId: freezed == linkedUserId ? _self.linkedUserId : linkedUserId // ignore: cast_nullable_to_non_nullable
as String?,privacyProtected: freezed == privacyProtected ? _self.privacyProtected : privacyProtected // ignore: cast_nullable_to_non_nullable
as bool?,privacySettings: freezed == privacySettings ? _self.privacySettings : privacySettings // ignore: cast_nullable_to_non_nullable
as PrivacySettings?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,nativeVillage: freezed == nativeVillage ? _self.nativeVillage : nativeVillage // ignore: cast_nullable_to_non_nullable
as String?,surname: freezed == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String?,gotra: freezed == gotra ? _self.gotra : gotra // ignore: cast_nullable_to_non_nullable
as String?,subCaste: freezed == subCaste ? _self.subCaste : subCaste // ignore: cast_nullable_to_non_nullable
as String?,timeOfBirth: freezed == timeOfBirth ? _self.timeOfBirth : timeOfBirth // ignore: cast_nullable_to_non_nullable
as String?,disability: freezed == disability ? _self.disability : disability // ignore: cast_nullable_to_non_nullable
as String?,manglik: freezed == manglik ? _self.manglik : manglik // ignore: cast_nullable_to_non_nullable
as String?,maternalSurname: freezed == maternalSurname ? _self.maternalSurname : maternalSurname // ignore: cast_nullable_to_non_nullable
as String?,maternalGotra: freezed == maternalGotra ? _self.maternalGotra : maternalGotra // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,education: freezed == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,facebook: freezed == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String?,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,twitter: freezed == twitter ? _self.twitter : twitter // ignore: cast_nullable_to_non_nullable
as String?,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,business: freezed == business ? _self.business : business // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,parents: null == parents ? _self.parents : parents // ignore: cast_nullable_to_non_nullable
as List<FamilyTreeNode>,spouses: null == spouses ? _self.spouses : spouses // ignore: cast_nullable_to_non_nullable
as List<FamilyTreeNode>,siblings: null == siblings ? _self.siblings : siblings // ignore: cast_nullable_to_non_nullable
as List<FamilyTreeNode>,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<FamilyTreeNode>,
  ));
}
/// Create a copy of FamilyTreeNode
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


/// Adds pattern-matching-related methods to [FamilyTreeNode].
extension FamilyTreeNodePatterns on FamilyTreeNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FamilyTreeNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FamilyTreeNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FamilyTreeNode value)  $default,){
final _that = this;
switch (_that) {
case _FamilyTreeNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FamilyTreeNode value)?  $default,){
final _that = this;
switch (_that) {
case _FamilyTreeNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? title,  String? fullName,  String? gender,  String? dob, @JsonKey(readValue: readRelationship)  String? relationshipType,  String? directRelationship,  String? relationshipToViewer,  bool? isDeceased,  bool? isMinor,  bool? isRegisteredUser,  String? photoUrl,  String? qrImageUrl,  String? linkedMobile,  String? ownerUserId, @JsonKey(readValue: readUserId)  String? linkedUserId,  bool? privacyProtected,  PrivacySettings? privacySettings,  String? state,  String? city,  String? nativeVillage,  String? surname,  String? gotra,  String? subCaste,  String? timeOfBirth,  String? disability,  String? manglik,  String? maternalSurname,  String? maternalGotra,  String? address,  String? bio,  String? education,  String? email,  String? height,  String? instagram,  String? facebook,  String? linkedin,  String? twitter,  Map<String, dynamic>? job,  Map<String, dynamic>? business,  List<FamilyTreeNode> parents,  List<FamilyTreeNode> spouses,  List<FamilyTreeNode> siblings,  List<FamilyTreeNode> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FamilyTreeNode() when $default != null:
return $default(_that.id,_that.title,_that.fullName,_that.gender,_that.dob,_that.relationshipType,_that.directRelationship,_that.relationshipToViewer,_that.isDeceased,_that.isMinor,_that.isRegisteredUser,_that.photoUrl,_that.qrImageUrl,_that.linkedMobile,_that.ownerUserId,_that.linkedUserId,_that.privacyProtected,_that.privacySettings,_that.state,_that.city,_that.nativeVillage,_that.surname,_that.gotra,_that.subCaste,_that.timeOfBirth,_that.disability,_that.manglik,_that.maternalSurname,_that.maternalGotra,_that.address,_that.bio,_that.education,_that.email,_that.height,_that.instagram,_that.facebook,_that.linkedin,_that.twitter,_that.job,_that.business,_that.parents,_that.spouses,_that.siblings,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? title,  String? fullName,  String? gender,  String? dob, @JsonKey(readValue: readRelationship)  String? relationshipType,  String? directRelationship,  String? relationshipToViewer,  bool? isDeceased,  bool? isMinor,  bool? isRegisteredUser,  String? photoUrl,  String? qrImageUrl,  String? linkedMobile,  String? ownerUserId, @JsonKey(readValue: readUserId)  String? linkedUserId,  bool? privacyProtected,  PrivacySettings? privacySettings,  String? state,  String? city,  String? nativeVillage,  String? surname,  String? gotra,  String? subCaste,  String? timeOfBirth,  String? disability,  String? manglik,  String? maternalSurname,  String? maternalGotra,  String? address,  String? bio,  String? education,  String? email,  String? height,  String? instagram,  String? facebook,  String? linkedin,  String? twitter,  Map<String, dynamic>? job,  Map<String, dynamic>? business,  List<FamilyTreeNode> parents,  List<FamilyTreeNode> spouses,  List<FamilyTreeNode> siblings,  List<FamilyTreeNode> children)  $default,) {final _that = this;
switch (_that) {
case _FamilyTreeNode():
return $default(_that.id,_that.title,_that.fullName,_that.gender,_that.dob,_that.relationshipType,_that.directRelationship,_that.relationshipToViewer,_that.isDeceased,_that.isMinor,_that.isRegisteredUser,_that.photoUrl,_that.qrImageUrl,_that.linkedMobile,_that.ownerUserId,_that.linkedUserId,_that.privacyProtected,_that.privacySettings,_that.state,_that.city,_that.nativeVillage,_that.surname,_that.gotra,_that.subCaste,_that.timeOfBirth,_that.disability,_that.manglik,_that.maternalSurname,_that.maternalGotra,_that.address,_that.bio,_that.education,_that.email,_that.height,_that.instagram,_that.facebook,_that.linkedin,_that.twitter,_that.job,_that.business,_that.parents,_that.spouses,_that.siblings,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? title,  String? fullName,  String? gender,  String? dob, @JsonKey(readValue: readRelationship)  String? relationshipType,  String? directRelationship,  String? relationshipToViewer,  bool? isDeceased,  bool? isMinor,  bool? isRegisteredUser,  String? photoUrl,  String? qrImageUrl,  String? linkedMobile,  String? ownerUserId, @JsonKey(readValue: readUserId)  String? linkedUserId,  bool? privacyProtected,  PrivacySettings? privacySettings,  String? state,  String? city,  String? nativeVillage,  String? surname,  String? gotra,  String? subCaste,  String? timeOfBirth,  String? disability,  String? manglik,  String? maternalSurname,  String? maternalGotra,  String? address,  String? bio,  String? education,  String? email,  String? height,  String? instagram,  String? facebook,  String? linkedin,  String? twitter,  Map<String, dynamic>? job,  Map<String, dynamic>? business,  List<FamilyTreeNode> parents,  List<FamilyTreeNode> spouses,  List<FamilyTreeNode> siblings,  List<FamilyTreeNode> children)?  $default,) {final _that = this;
switch (_that) {
case _FamilyTreeNode() when $default != null:
return $default(_that.id,_that.title,_that.fullName,_that.gender,_that.dob,_that.relationshipType,_that.directRelationship,_that.relationshipToViewer,_that.isDeceased,_that.isMinor,_that.isRegisteredUser,_that.photoUrl,_that.qrImageUrl,_that.linkedMobile,_that.ownerUserId,_that.linkedUserId,_that.privacyProtected,_that.privacySettings,_that.state,_that.city,_that.nativeVillage,_that.surname,_that.gotra,_that.subCaste,_that.timeOfBirth,_that.disability,_that.manglik,_that.maternalSurname,_that.maternalGotra,_that.address,_that.bio,_that.education,_that.email,_that.height,_that.instagram,_that.facebook,_that.linkedin,_that.twitter,_that.job,_that.business,_that.parents,_that.spouses,_that.siblings,_that.children);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FamilyTreeNode implements FamilyTreeNode {
  const _FamilyTreeNode({this.id, this.title, this.fullName, this.gender, this.dob, @JsonKey(readValue: readRelationship) this.relationshipType, this.directRelationship, this.relationshipToViewer, this.isDeceased, this.isMinor, this.isRegisteredUser, this.photoUrl, this.qrImageUrl, this.linkedMobile, this.ownerUserId, @JsonKey(readValue: readUserId) this.linkedUserId, this.privacyProtected, this.privacySettings, this.state, this.city, this.nativeVillage, this.surname, this.gotra, this.subCaste, this.timeOfBirth, this.disability, this.manglik, this.maternalSurname, this.maternalGotra, this.address, this.bio, this.education, this.email, this.height, this.instagram, this.facebook, this.linkedin, this.twitter,  Map<String, dynamic>? job,  Map<String, dynamic>? business,  List<FamilyTreeNode> parents = const [],  List<FamilyTreeNode> spouses = const [],  List<FamilyTreeNode> siblings = const [],  List<FamilyTreeNode> children = const []}): _job = job,_business = business,_parents = parents,_spouses = spouses,_siblings = siblings,_children = children;
  factory _FamilyTreeNode.fromJson(Map<String, dynamic> json) => _$FamilyTreeNodeFromJson(json);

@override final  String? id;
@override final  String? title;
@override final  String? fullName;
@override final  String? gender;
@override final  String? dob;
@override@JsonKey(readValue: readRelationship) final  String? relationshipType;
@override final  String? directRelationship;
@override final  String? relationshipToViewer;
@override final  bool? isDeceased;
@override final  bool? isMinor;
@override final  bool? isRegisteredUser;
@override final  String? photoUrl;
@override final  String? qrImageUrl;
@override final  String? linkedMobile;
@override final  String? ownerUserId;
@override@JsonKey(readValue: readUserId) final  String? linkedUserId;
@override final  bool? privacyProtected;
@override final  PrivacySettings? privacySettings;
@override final  String? state;
@override final  String? city;
@override final  String? nativeVillage;
@override final  String? surname;
@override final  String? gotra;
@override final  String? subCaste;
@override final  String? timeOfBirth;
@override final  String? disability;
@override final  String? manglik;
@override final  String? maternalSurname;
@override final  String? maternalGotra;
@override final  String? address;
@override final  String? bio;
@override final  String? education;
@override final  String? email;
@override final  String? height;
@override final  String? instagram;
@override final  String? facebook;
@override final  String? linkedin;
@override final  String? twitter;
 final  Map<String, dynamic>? _job;
@override Map<String, dynamic>? get job {
  final value = _job;
  if (value == null) return null;
  if (_job is EqualUnmodifiableMapView) return _job;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _business;
@override Map<String, dynamic>? get business {
  final value = _business;
  if (value == null) return null;
  if (_business is EqualUnmodifiableMapView) return _business;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<FamilyTreeNode> _parents;
@override@JsonKey() List<FamilyTreeNode> get parents {
  if (_parents is EqualUnmodifiableListView) return _parents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parents);
}

 final  List<FamilyTreeNode> _spouses;
@override@JsonKey() List<FamilyTreeNode> get spouses {
  if (_spouses is EqualUnmodifiableListView) return _spouses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_spouses);
}

 final  List<FamilyTreeNode> _siblings;
@override@JsonKey() List<FamilyTreeNode> get siblings {
  if (_siblings is EqualUnmodifiableListView) return _siblings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_siblings);
}

 final  List<FamilyTreeNode> _children;
@override@JsonKey() List<FamilyTreeNode> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of FamilyTreeNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FamilyTreeNodeCopyWith<_FamilyTreeNode> get copyWith => __$FamilyTreeNodeCopyWithImpl<_FamilyTreeNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FamilyTreeNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyTreeNode&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.relationshipType, relationshipType) || other.relationshipType == relationshipType)&&(identical(other.directRelationship, directRelationship) || other.directRelationship == directRelationship)&&(identical(other.relationshipToViewer, relationshipToViewer) || other.relationshipToViewer == relationshipToViewer)&&(identical(other.isDeceased, isDeceased) || other.isDeceased == isDeceased)&&(identical(other.isMinor, isMinor) || other.isMinor == isMinor)&&(identical(other.isRegisteredUser, isRegisteredUser) || other.isRegisteredUser == isRegisteredUser)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.qrImageUrl, qrImageUrl) || other.qrImageUrl == qrImageUrl)&&(identical(other.linkedMobile, linkedMobile) || other.linkedMobile == linkedMobile)&&(identical(other.ownerUserId, ownerUserId) || other.ownerUserId == ownerUserId)&&(identical(other.linkedUserId, linkedUserId) || other.linkedUserId == linkedUserId)&&(identical(other.privacyProtected, privacyProtected) || other.privacyProtected == privacyProtected)&&(identical(other.privacySettings, privacySettings) || other.privacySettings == privacySettings)&&(identical(other.state, state) || other.state == state)&&(identical(other.city, city) || other.city == city)&&(identical(other.nativeVillage, nativeVillage) || other.nativeVillage == nativeVillage)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.gotra, gotra) || other.gotra == gotra)&&(identical(other.subCaste, subCaste) || other.subCaste == subCaste)&&(identical(other.timeOfBirth, timeOfBirth) || other.timeOfBirth == timeOfBirth)&&(identical(other.disability, disability) || other.disability == disability)&&(identical(other.manglik, manglik) || other.manglik == manglik)&&(identical(other.maternalSurname, maternalSurname) || other.maternalSurname == maternalSurname)&&(identical(other.maternalGotra, maternalGotra) || other.maternalGotra == maternalGotra)&&(identical(other.address, address) || other.address == address)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.education, education) || other.education == education)&&(identical(other.email, email) || other.email == email)&&(identical(other.height, height) || other.height == height)&&(identical(other.instagram, instagram) || other.instagram == instagram)&&(identical(other.facebook, facebook) || other.facebook == facebook)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.twitter, twitter) || other.twitter == twitter)&&const DeepCollectionEquality().equals(other._job, _job)&&const DeepCollectionEquality().equals(other._business, _business)&&const DeepCollectionEquality().equals(other._parents, _parents)&&const DeepCollectionEquality().equals(other._spouses, _spouses)&&const DeepCollectionEquality().equals(other._siblings, _siblings)&&const DeepCollectionEquality().equals(other._children, _children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,fullName,gender,dob,relationshipType,directRelationship,relationshipToViewer,isDeceased,isMinor,isRegisteredUser,photoUrl,qrImageUrl,linkedMobile,ownerUserId,linkedUserId,privacyProtected,privacySettings,state,city,nativeVillage,surname,gotra,subCaste,timeOfBirth,disability,manglik,maternalSurname,maternalGotra,address,bio,education,email,height,instagram,facebook,linkedin,twitter,const DeepCollectionEquality().hash(_job),const DeepCollectionEquality().hash(_business),const DeepCollectionEquality().hash(_parents),const DeepCollectionEquality().hash(_spouses),const DeepCollectionEquality().hash(_siblings),const DeepCollectionEquality().hash(_children)]);

@override
String toString() {
  return 'FamilyTreeNode(id: $id, title: $title, fullName: $fullName, gender: $gender, dob: $dob, relationshipType: $relationshipType, directRelationship: $directRelationship, relationshipToViewer: $relationshipToViewer, isDeceased: $isDeceased, isMinor: $isMinor, isRegisteredUser: $isRegisteredUser, photoUrl: $photoUrl, qrImageUrl: $qrImageUrl, linkedMobile: $linkedMobile, ownerUserId: $ownerUserId, linkedUserId: $linkedUserId, privacyProtected: $privacyProtected, privacySettings: $privacySettings, state: $state, city: $city, nativeVillage: $nativeVillage, surname: $surname, gotra: $gotra, subCaste: $subCaste, timeOfBirth: $timeOfBirth, disability: $disability, manglik: $manglik, maternalSurname: $maternalSurname, maternalGotra: $maternalGotra, address: $address, bio: $bio, education: $education, email: $email, height: $height, instagram: $instagram, facebook: $facebook, linkedin: $linkedin, twitter: $twitter, job: $job, business: $business, parents: $parents, spouses: $spouses, siblings: $siblings, children: $children)';
}


}

/// @nodoc
abstract mixin class _$FamilyTreeNodeCopyWith<$Res> implements $FamilyTreeNodeCopyWith<$Res> {
  factory _$FamilyTreeNodeCopyWith(_FamilyTreeNode value, $Res Function(_FamilyTreeNode) _then) = __$FamilyTreeNodeCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? title, String? fullName, String? gender, String? dob,@JsonKey(readValue: readRelationship) String? relationshipType, String? directRelationship, String? relationshipToViewer, bool? isDeceased, bool? isMinor, bool? isRegisteredUser, String? photoUrl, String? qrImageUrl, String? linkedMobile, String? ownerUserId,@JsonKey(readValue: readUserId) String? linkedUserId, bool? privacyProtected, PrivacySettings? privacySettings, String? state, String? city, String? nativeVillage, String? surname, String? gotra, String? subCaste, String? timeOfBirth, String? disability, String? manglik, String? maternalSurname, String? maternalGotra, String? address, String? bio, String? education, String? email, String? height, String? instagram, String? facebook, String? linkedin, String? twitter, Map<String, dynamic>? job, Map<String, dynamic>? business, List<FamilyTreeNode> parents, List<FamilyTreeNode> spouses, List<FamilyTreeNode> siblings, List<FamilyTreeNode> children
});


@override $PrivacySettingsCopyWith<$Res>? get privacySettings;

}
/// @nodoc
class __$FamilyTreeNodeCopyWithImpl<$Res>
    implements _$FamilyTreeNodeCopyWith<$Res> {
  __$FamilyTreeNodeCopyWithImpl(this._self, this._then);

  final _FamilyTreeNode _self;
  final $Res Function(_FamilyTreeNode) _then;

/// Create a copy of FamilyTreeNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? fullName = freezed,Object? gender = freezed,Object? dob = freezed,Object? relationshipType = freezed,Object? directRelationship = freezed,Object? relationshipToViewer = freezed,Object? isDeceased = freezed,Object? isMinor = freezed,Object? isRegisteredUser = freezed,Object? photoUrl = freezed,Object? qrImageUrl = freezed,Object? linkedMobile = freezed,Object? ownerUserId = freezed,Object? linkedUserId = freezed,Object? privacyProtected = freezed,Object? privacySettings = freezed,Object? state = freezed,Object? city = freezed,Object? nativeVillage = freezed,Object? surname = freezed,Object? gotra = freezed,Object? subCaste = freezed,Object? timeOfBirth = freezed,Object? disability = freezed,Object? manglik = freezed,Object? maternalSurname = freezed,Object? maternalGotra = freezed,Object? address = freezed,Object? bio = freezed,Object? education = freezed,Object? email = freezed,Object? height = freezed,Object? instagram = freezed,Object? facebook = freezed,Object? linkedin = freezed,Object? twitter = freezed,Object? job = freezed,Object? business = freezed,Object? parents = null,Object? spouses = null,Object? siblings = null,Object? children = null,}) {
  return _then(_FamilyTreeNode(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,relationshipType: freezed == relationshipType ? _self.relationshipType : relationshipType // ignore: cast_nullable_to_non_nullable
as String?,directRelationship: freezed == directRelationship ? _self.directRelationship : directRelationship // ignore: cast_nullable_to_non_nullable
as String?,relationshipToViewer: freezed == relationshipToViewer ? _self.relationshipToViewer : relationshipToViewer // ignore: cast_nullable_to_non_nullable
as String?,isDeceased: freezed == isDeceased ? _self.isDeceased : isDeceased // ignore: cast_nullable_to_non_nullable
as bool?,isMinor: freezed == isMinor ? _self.isMinor : isMinor // ignore: cast_nullable_to_non_nullable
as bool?,isRegisteredUser: freezed == isRegisteredUser ? _self.isRegisteredUser : isRegisteredUser // ignore: cast_nullable_to_non_nullable
as bool?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,qrImageUrl: freezed == qrImageUrl ? _self.qrImageUrl : qrImageUrl // ignore: cast_nullable_to_non_nullable
as String?,linkedMobile: freezed == linkedMobile ? _self.linkedMobile : linkedMobile // ignore: cast_nullable_to_non_nullable
as String?,ownerUserId: freezed == ownerUserId ? _self.ownerUserId : ownerUserId // ignore: cast_nullable_to_non_nullable
as String?,linkedUserId: freezed == linkedUserId ? _self.linkedUserId : linkedUserId // ignore: cast_nullable_to_non_nullable
as String?,privacyProtected: freezed == privacyProtected ? _self.privacyProtected : privacyProtected // ignore: cast_nullable_to_non_nullable
as bool?,privacySettings: freezed == privacySettings ? _self.privacySettings : privacySettings // ignore: cast_nullable_to_non_nullable
as PrivacySettings?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,nativeVillage: freezed == nativeVillage ? _self.nativeVillage : nativeVillage // ignore: cast_nullable_to_non_nullable
as String?,surname: freezed == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String?,gotra: freezed == gotra ? _self.gotra : gotra // ignore: cast_nullable_to_non_nullable
as String?,subCaste: freezed == subCaste ? _self.subCaste : subCaste // ignore: cast_nullable_to_non_nullable
as String?,timeOfBirth: freezed == timeOfBirth ? _self.timeOfBirth : timeOfBirth // ignore: cast_nullable_to_non_nullable
as String?,disability: freezed == disability ? _self.disability : disability // ignore: cast_nullable_to_non_nullable
as String?,manglik: freezed == manglik ? _self.manglik : manglik // ignore: cast_nullable_to_non_nullable
as String?,maternalSurname: freezed == maternalSurname ? _self.maternalSurname : maternalSurname // ignore: cast_nullable_to_non_nullable
as String?,maternalGotra: freezed == maternalGotra ? _self.maternalGotra : maternalGotra // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,education: freezed == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as String?,instagram: freezed == instagram ? _self.instagram : instagram // ignore: cast_nullable_to_non_nullable
as String?,facebook: freezed == facebook ? _self.facebook : facebook // ignore: cast_nullable_to_non_nullable
as String?,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,twitter: freezed == twitter ? _self.twitter : twitter // ignore: cast_nullable_to_non_nullable
as String?,job: freezed == job ? _self._job : job // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,business: freezed == business ? _self._business : business // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,parents: null == parents ? _self._parents : parents // ignore: cast_nullable_to_non_nullable
as List<FamilyTreeNode>,spouses: null == spouses ? _self._spouses : spouses // ignore: cast_nullable_to_non_nullable
as List<FamilyTreeNode>,siblings: null == siblings ? _self._siblings : siblings // ignore: cast_nullable_to_non_nullable
as List<FamilyTreeNode>,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<FamilyTreeNode>,
  ));
}

/// Create a copy of FamilyTreeNode
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

// dart format on
