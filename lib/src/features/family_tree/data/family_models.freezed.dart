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

 String? get id; String? get fullName; String? get gender; String? get dob; String? get relationshipType; bool? get isDeceased; String? get photoUrl; String? get linkedMobile;
/// Create a copy of FamilyMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyMemberCopyWith<FamilyMember> get copyWith => _$FamilyMemberCopyWithImpl<FamilyMember>(this as FamilyMember, _$identity);

  /// Serializes this FamilyMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyMember&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.relationshipType, relationshipType) || other.relationshipType == relationshipType)&&(identical(other.isDeceased, isDeceased) || other.isDeceased == isDeceased)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.linkedMobile, linkedMobile) || other.linkedMobile == linkedMobile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,gender,dob,relationshipType,isDeceased,photoUrl,linkedMobile);

@override
String toString() {
  return 'FamilyMember(id: $id, fullName: $fullName, gender: $gender, dob: $dob, relationshipType: $relationshipType, isDeceased: $isDeceased, photoUrl: $photoUrl, linkedMobile: $linkedMobile)';
}


}

/// @nodoc
abstract mixin class $FamilyMemberCopyWith<$Res>  {
  factory $FamilyMemberCopyWith(FamilyMember value, $Res Function(FamilyMember) _then) = _$FamilyMemberCopyWithImpl;
@useResult
$Res call({
 String? id, String? fullName, String? gender, String? dob, String? relationshipType, bool? isDeceased, String? photoUrl, String? linkedMobile
});




}
/// @nodoc
class _$FamilyMemberCopyWithImpl<$Res>
    implements $FamilyMemberCopyWith<$Res> {
  _$FamilyMemberCopyWithImpl(this._self, this._then);

  final FamilyMember _self;
  final $Res Function(FamilyMember) _then;

/// Create a copy of FamilyMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? fullName = freezed,Object? gender = freezed,Object? dob = freezed,Object? relationshipType = freezed,Object? isDeceased = freezed,Object? photoUrl = freezed,Object? linkedMobile = freezed,}) {
  return _then(FamilyMember(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,relationshipType: freezed == relationshipType ? _self.relationshipType : relationshipType // ignore: cast_nullable_to_non_nullable
as String?,isDeceased: freezed == isDeceased ? _self.isDeceased : isDeceased // ignore: cast_nullable_to_non_nullable
as bool?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,linkedMobile: freezed == linkedMobile ? _self.linkedMobile : linkedMobile // ignore: cast_nullable_to_non_nullable
as String?,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? fullName,  String? gender,  String? dob,  String? relationshipType,  bool? isDeceased,  String? photoUrl,  String? linkedMobile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FamilyMember() when $default != null:
return $default(_that.id,_that.fullName,_that.gender,_that.dob,_that.relationshipType,_that.isDeceased,_that.photoUrl,_that.linkedMobile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? fullName,  String? gender,  String? dob,  String? relationshipType,  bool? isDeceased,  String? photoUrl,  String? linkedMobile)  $default,) {final _that = this;
switch (_that) {
case _FamilyMember():
return $default(_that.id,_that.fullName,_that.gender,_that.dob,_that.relationshipType,_that.isDeceased,_that.photoUrl,_that.linkedMobile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? fullName,  String? gender,  String? dob,  String? relationshipType,  bool? isDeceased,  String? photoUrl,  String? linkedMobile)?  $default,) {final _that = this;
switch (_that) {
case _FamilyMember() when $default != null:
return $default(_that.id,_that.fullName,_that.gender,_that.dob,_that.relationshipType,_that.isDeceased,_that.photoUrl,_that.linkedMobile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FamilyMember implements FamilyMember {
  const _FamilyMember({this.id, this.fullName, this.gender, this.dob, this.relationshipType, this.isDeceased, this.photoUrl, this.linkedMobile});
  factory _FamilyMember.fromJson(Map<String, dynamic> json) => _$FamilyMemberFromJson(json);

@override final  String? id;
@override final  String? fullName;
@override final  String? gender;
@override final  String? dob;
@override final  String? relationshipType;
@override final  bool? isDeceased;
@override final  String? photoUrl;
@override final  String? linkedMobile;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyMember&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.relationshipType, relationshipType) || other.relationshipType == relationshipType)&&(identical(other.isDeceased, isDeceased) || other.isDeceased == isDeceased)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.linkedMobile, linkedMobile) || other.linkedMobile == linkedMobile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,gender,dob,relationshipType,isDeceased,photoUrl,linkedMobile);

@override
String toString() {
  return 'FamilyMember(id: $id, fullName: $fullName, gender: $gender, dob: $dob, relationshipType: $relationshipType, isDeceased: $isDeceased, photoUrl: $photoUrl, linkedMobile: $linkedMobile)';
}


}

/// @nodoc
abstract mixin class _$FamilyMemberCopyWith<$Res> implements $FamilyMemberCopyWith<$Res> {
  factory _$FamilyMemberCopyWith(_FamilyMember value, $Res Function(_FamilyMember) _then) = __$FamilyMemberCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? fullName, String? gender, String? dob, String? relationshipType, bool? isDeceased, String? photoUrl, String? linkedMobile
});




}
/// @nodoc
class __$FamilyMemberCopyWithImpl<$Res>
    implements _$FamilyMemberCopyWith<$Res> {
  __$FamilyMemberCopyWithImpl(this._self, this._then);

  final _FamilyMember _self;
  final $Res Function(_FamilyMember) _then;

/// Create a copy of FamilyMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? fullName = freezed,Object? gender = freezed,Object? dob = freezed,Object? relationshipType = freezed,Object? isDeceased = freezed,Object? photoUrl = freezed,Object? linkedMobile = freezed,}) {
  return _then(_FamilyMember(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,relationshipType: freezed == relationshipType ? _self.relationshipType : relationshipType // ignore: cast_nullable_to_non_nullable
as String?,isDeceased: freezed == isDeceased ? _self.isDeceased : isDeceased // ignore: cast_nullable_to_non_nullable
as bool?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,linkedMobile: freezed == linkedMobile ? _self.linkedMobile : linkedMobile // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$FamilyTreeNode {

 String? get id; String? get fullName; String? get relationshipType; bool? get isDeceased; String? get photoUrl; List<FamilyTreeNode> get children;
/// Create a copy of FamilyTreeNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FamilyTreeNodeCopyWith<FamilyTreeNode> get copyWith => _$FamilyTreeNodeCopyWithImpl<FamilyTreeNode>(this as FamilyTreeNode, _$identity);

  /// Serializes this FamilyTreeNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FamilyTreeNode&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.relationshipType, relationshipType) || other.relationshipType == relationshipType)&&(identical(other.isDeceased, isDeceased) || other.isDeceased == isDeceased)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,relationshipType,isDeceased,photoUrl,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'FamilyTreeNode(id: $id, fullName: $fullName, relationshipType: $relationshipType, isDeceased: $isDeceased, photoUrl: $photoUrl, children: $children)';
}


}

/// @nodoc
abstract mixin class $FamilyTreeNodeCopyWith<$Res>  {
  factory $FamilyTreeNodeCopyWith(FamilyTreeNode value, $Res Function(FamilyTreeNode) _then) = _$FamilyTreeNodeCopyWithImpl;
@useResult
$Res call({
 String? id, String? fullName, String? relationshipType, bool? isDeceased, String? photoUrl, List<FamilyTreeNode> children
});




}
/// @nodoc
class _$FamilyTreeNodeCopyWithImpl<$Res>
    implements $FamilyTreeNodeCopyWith<$Res> {
  _$FamilyTreeNodeCopyWithImpl(this._self, this._then);

  final FamilyTreeNode _self;
  final $Res Function(FamilyTreeNode) _then;

/// Create a copy of FamilyTreeNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? fullName = freezed,Object? relationshipType = freezed,Object? isDeceased = freezed,Object? photoUrl = freezed,Object? children = null,}) {
  return _then(FamilyTreeNode(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,relationshipType: freezed == relationshipType ? _self.relationshipType : relationshipType // ignore: cast_nullable_to_non_nullable
as String?,isDeceased: freezed == isDeceased ? _self.isDeceased : isDeceased // ignore: cast_nullable_to_non_nullable
as bool?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<FamilyTreeNode>,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? fullName,  String? relationshipType,  bool? isDeceased,  String? photoUrl,  List<FamilyTreeNode> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FamilyTreeNode() when $default != null:
return $default(_that.id,_that.fullName,_that.relationshipType,_that.isDeceased,_that.photoUrl,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? fullName,  String? relationshipType,  bool? isDeceased,  String? photoUrl,  List<FamilyTreeNode> children)  $default,) {final _that = this;
switch (_that) {
case _FamilyTreeNode():
return $default(_that.id,_that.fullName,_that.relationshipType,_that.isDeceased,_that.photoUrl,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? fullName,  String? relationshipType,  bool? isDeceased,  String? photoUrl,  List<FamilyTreeNode> children)?  $default,) {final _that = this;
switch (_that) {
case _FamilyTreeNode() when $default != null:
return $default(_that.id,_that.fullName,_that.relationshipType,_that.isDeceased,_that.photoUrl,_that.children);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FamilyTreeNode implements FamilyTreeNode {
  const _FamilyTreeNode({this.id, this.fullName, this.relationshipType, this.isDeceased, this.photoUrl,  List<FamilyTreeNode> children = const []}): _children = children;
  factory _FamilyTreeNode.fromJson(Map<String, dynamic> json) => _$FamilyTreeNodeFromJson(json);

@override final  String? id;
@override final  String? fullName;
@override final  String? relationshipType;
@override final  bool? isDeceased;
@override final  String? photoUrl;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FamilyTreeNode&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.relationshipType, relationshipType) || other.relationshipType == relationshipType)&&(identical(other.isDeceased, isDeceased) || other.isDeceased == isDeceased)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other._children, _children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,relationshipType,isDeceased,photoUrl,const DeepCollectionEquality().hash(_children));

@override
String toString() {
  return 'FamilyTreeNode(id: $id, fullName: $fullName, relationshipType: $relationshipType, isDeceased: $isDeceased, photoUrl: $photoUrl, children: $children)';
}


}

/// @nodoc
abstract mixin class _$FamilyTreeNodeCopyWith<$Res> implements $FamilyTreeNodeCopyWith<$Res> {
  factory _$FamilyTreeNodeCopyWith(_FamilyTreeNode value, $Res Function(_FamilyTreeNode) _then) = __$FamilyTreeNodeCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? fullName, String? relationshipType, bool? isDeceased, String? photoUrl, List<FamilyTreeNode> children
});




}
/// @nodoc
class __$FamilyTreeNodeCopyWithImpl<$Res>
    implements _$FamilyTreeNodeCopyWith<$Res> {
  __$FamilyTreeNodeCopyWithImpl(this._self, this._then);

  final _FamilyTreeNode _self;
  final $Res Function(_FamilyTreeNode) _then;

/// Create a copy of FamilyTreeNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? fullName = freezed,Object? relationshipType = freezed,Object? isDeceased = freezed,Object? photoUrl = freezed,Object? children = null,}) {
  return _then(_FamilyTreeNode(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,relationshipType: freezed == relationshipType ? _self.relationshipType : relationshipType // ignore: cast_nullable_to_non_nullable
as String?,isDeceased: freezed == isDeceased ? _self.isDeceased : isDeceased // ignore: cast_nullable_to_non_nullable
as bool?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<FamilyTreeNode>,
  ));
}


}

// dart format on
