// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Community {

 String? get id; String? get name; String? get description; String? get logoUrl; String? get inviteCode;
/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityCopyWith<Community> get copyWith => _$CommunityCopyWithImpl<Community>(this as Community, _$identity);

  /// Serializes this Community to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Community&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,logoUrl,inviteCode);

@override
String toString() {
  return 'Community(id: $id, name: $name, description: $description, logoUrl: $logoUrl, inviteCode: $inviteCode)';
}


}

/// @nodoc
abstract mixin class $CommunityCopyWith<$Res>  {
  factory $CommunityCopyWith(Community value, $Res Function(Community) _then) = _$CommunityCopyWithImpl;
@useResult
$Res call({
 String? id, String? name, String? description, String? logoUrl, String? inviteCode
});




}
/// @nodoc
class _$CommunityCopyWithImpl<$Res>
    implements $CommunityCopyWith<$Res> {
  _$CommunityCopyWithImpl(this._self, this._then);

  final Community _self;
  final $Res Function(Community) _then;

/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? description = freezed,Object? logoUrl = freezed,Object? inviteCode = freezed,}) {
  return _then(Community(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Community].
extension CommunityPatterns on Community {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Community value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Community() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Community value)  $default,){
final _that = this;
switch (_that) {
case _Community():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Community value)?  $default,){
final _that = this;
switch (_that) {
case _Community() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? name,  String? description,  String? logoUrl,  String? inviteCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Community() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.logoUrl,_that.inviteCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? name,  String? description,  String? logoUrl,  String? inviteCode)  $default,) {final _that = this;
switch (_that) {
case _Community():
return $default(_that.id,_that.name,_that.description,_that.logoUrl,_that.inviteCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? name,  String? description,  String? logoUrl,  String? inviteCode)?  $default,) {final _that = this;
switch (_that) {
case _Community() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.logoUrl,_that.inviteCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Community implements Community {
  const _Community({this.id, this.name, this.description, this.logoUrl, this.inviteCode});
  factory _Community.fromJson(Map<String, dynamic> json) => _$CommunityFromJson(json);

@override final  String? id;
@override final  String? name;
@override final  String? description;
@override final  String? logoUrl;
@override final  String? inviteCode;

/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityCopyWith<_Community> get copyWith => __$CommunityCopyWithImpl<_Community>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Community&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,logoUrl,inviteCode);

@override
String toString() {
  return 'Community(id: $id, name: $name, description: $description, logoUrl: $logoUrl, inviteCode: $inviteCode)';
}


}

/// @nodoc
abstract mixin class _$CommunityCopyWith<$Res> implements $CommunityCopyWith<$Res> {
  factory _$CommunityCopyWith(_Community value, $Res Function(_Community) _then) = __$CommunityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? name, String? description, String? logoUrl, String? inviteCode
});




}
/// @nodoc
class __$CommunityCopyWithImpl<$Res>
    implements _$CommunityCopyWith<$Res> {
  __$CommunityCopyWithImpl(this._self, this._then);

  final _Community _self;
  final $Res Function(_Community) _then;

/// Create a copy of Community
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? description = freezed,Object? logoUrl = freezed,Object? inviteCode = freezed,}) {
  return _then(_Community(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CommunityMember {

 String? get membershipId; String? get userId; String? get fullName; String? get role; String? get status;
/// Create a copy of CommunityMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityMemberCopyWith<CommunityMember> get copyWith => _$CommunityMemberCopyWithImpl<CommunityMember>(this as CommunityMember, _$identity);

  /// Serializes this CommunityMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityMember&&(identical(other.membershipId, membershipId) || other.membershipId == membershipId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,membershipId,userId,fullName,role,status);

@override
String toString() {
  return 'CommunityMember(membershipId: $membershipId, userId: $userId, fullName: $fullName, role: $role, status: $status)';
}


}

/// @nodoc
abstract mixin class $CommunityMemberCopyWith<$Res>  {
  factory $CommunityMemberCopyWith(CommunityMember value, $Res Function(CommunityMember) _then) = _$CommunityMemberCopyWithImpl;
@useResult
$Res call({
 String? membershipId, String? userId, String? fullName, String? role, String? status
});




}
/// @nodoc
class _$CommunityMemberCopyWithImpl<$Res>
    implements $CommunityMemberCopyWith<$Res> {
  _$CommunityMemberCopyWithImpl(this._self, this._then);

  final CommunityMember _self;
  final $Res Function(CommunityMember) _then;

/// Create a copy of CommunityMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? membershipId = freezed,Object? userId = freezed,Object? fullName = freezed,Object? role = freezed,Object? status = freezed,}) {
  return _then(CommunityMember(
membershipId: freezed == membershipId ? _self.membershipId : membershipId // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityMember].
extension CommunityMemberPatterns on CommunityMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityMember value)  $default,){
final _that = this;
switch (_that) {
case _CommunityMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityMember value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? membershipId,  String? userId,  String? fullName,  String? role,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityMember() when $default != null:
return $default(_that.membershipId,_that.userId,_that.fullName,_that.role,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? membershipId,  String? userId,  String? fullName,  String? role,  String? status)  $default,) {final _that = this;
switch (_that) {
case _CommunityMember():
return $default(_that.membershipId,_that.userId,_that.fullName,_that.role,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? membershipId,  String? userId,  String? fullName,  String? role,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _CommunityMember() when $default != null:
return $default(_that.membershipId,_that.userId,_that.fullName,_that.role,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommunityMember implements CommunityMember {
  const _CommunityMember({this.membershipId, this.userId, this.fullName, this.role, this.status});
  factory _CommunityMember.fromJson(Map<String, dynamic> json) => _$CommunityMemberFromJson(json);

@override final  String? membershipId;
@override final  String? userId;
@override final  String? fullName;
@override final  String? role;
@override final  String? status;

/// Create a copy of CommunityMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityMemberCopyWith<_CommunityMember> get copyWith => __$CommunityMemberCopyWithImpl<_CommunityMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommunityMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityMember&&(identical(other.membershipId, membershipId) || other.membershipId == membershipId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,membershipId,userId,fullName,role,status);

@override
String toString() {
  return 'CommunityMember(membershipId: $membershipId, userId: $userId, fullName: $fullName, role: $role, status: $status)';
}


}

/// @nodoc
abstract mixin class _$CommunityMemberCopyWith<$Res> implements $CommunityMemberCopyWith<$Res> {
  factory _$CommunityMemberCopyWith(_CommunityMember value, $Res Function(_CommunityMember) _then) = __$CommunityMemberCopyWithImpl;
@override @useResult
$Res call({
 String? membershipId, String? userId, String? fullName, String? role, String? status
});




}
/// @nodoc
class __$CommunityMemberCopyWithImpl<$Res>
    implements _$CommunityMemberCopyWith<$Res> {
  __$CommunityMemberCopyWithImpl(this._self, this._then);

  final _CommunityMember _self;
  final $Res Function(_CommunityMember) _then;

/// Create a copy of CommunityMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? membershipId = freezed,Object? userId = freezed,Object? fullName = freezed,Object? role = freezed,Object? status = freezed,}) {
  return _then(_CommunityMember(
membershipId: freezed == membershipId ? _self.membershipId : membershipId // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
