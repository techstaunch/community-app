import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'profile_models.dart';

part 'profile_repository.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(ref.watch(apiClientProvider));
}

class ProfileRepository {
  final Dio _dio;

  ProfileRepository(this._dio);

  Future<UserProfile> getOwnProfile() async {
    final response = await _dio.get(ApiEndpoints.profiles);
    return UserProfile.fromJson(response.data['data']);
  }

  Future<UserProfile> updateCoreProfile(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.profiles, data: data);
    return UserProfile.fromJson(response.data['data']);
  }

  Future<UserProfile> updateJobDetails(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.profileJob, data: data);
    return UserProfile.fromJson(response.data['data']);
  }

  Future<UserProfile> updateBusinessDetails(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.profileBusiness, data: data);
    return UserProfile.fromJson(response.data['data']);
  }

  Future<void> updatePrivacySettings(Map<String, dynamic> data) async {
    await _dio.post(ApiEndpoints.profilePrivacy, data: data);
  }

  Future<void> deleteJobDetails() async {
    await _dio.delete(ApiEndpoints.profileJob);
  }

  Future<void> deleteBusinessDetails() async {
    await _dio.delete(ApiEndpoints.profileBusiness);
  }

  Future<void> uploadProfilePhoto(String filePath) async {
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(filePath),
    });
    
    // Explicitly grab token to bypass any interceptor issues with FormData
    final storage = const FlutterSecureStorage();
    final token = await storage.read(key: ApiEndpoints.accessTokenKey);
    
    await _dio.post(
      ApiEndpoints.profilePhoto, 
      data: formData,
      options: Options(
        headers: {
          if (token != null) 'Authorization': 'Bearer ',
        }
      )
    );
  }

  Future<void> deleteProfilePhoto() async {
    await _dio.delete(ApiEndpoints.profilePhoto);
  }
}
