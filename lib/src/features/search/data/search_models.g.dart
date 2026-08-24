// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchResult _$SearchResultFromJson(Map<String, dynamic> json) =>
    _SearchResult(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      city: json['city'] as String?,
      gender: json['gender'] as String?,
      designation: json['designation'] as String?,
      companyName: json['companyName'] as String?,
    );

Map<String, dynamic> _$SearchResultToJson(_SearchResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'city': instance.city,
      'gender': instance.gender,
      'designation': instance.designation,
      'companyName': instance.companyName,
    };

_SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    _SearchResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResponseToJson(_SearchResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
