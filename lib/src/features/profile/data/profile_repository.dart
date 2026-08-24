import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils/api_endpoints.dart';
import '../../../core/network/api_client.dart';
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

  Future<UserProfile> updatePrivacySettings(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.profilePrivacy, data: data);
    return UserProfile.fromJson(response.data['data']);
  }

  Future<void> uploadProfilePhoto(String filePath) async {
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(filePath),
    });
    await _dio.post(ApiEndpoints.profilePhoto, data: formData);
  }

  Future<void> deleteProfilePhoto() async {
    await _dio.delete(ApiEndpoints.profilePhoto);
  }
}
