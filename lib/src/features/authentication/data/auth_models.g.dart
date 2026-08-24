// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) =>
    _AuthResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : AuthData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(_AuthResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_AuthData _$AuthDataFromJson(Map<String, dynamic> json) => _AuthData(
  accessToken: json['accessToken'] as String?,
  refreshToken: json['refreshToken'] as String?,
  isNewUser: json['isNewUser'] as bool?,
);

Map<String, dynamic> _$AuthDataToJson(_AuthData instance) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'isNewUser': instance.isNewUser,
};
