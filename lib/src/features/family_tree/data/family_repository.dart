import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import 'family_models.dart';

part 'family_repository.g.dart';

@riverpod
FamilyRepository familyRepository(Ref ref) {
  return FamilyRepository(ref.watch(apiClientProvider));
}

class FamilyRepository {
  final Dio _dio;
  FamilyRepository(this._dio);

  Future<List<FamilyMember>> getFamilyMembers() async {
    final response = await _dio.get(ApiEndpoints.familyMember);
    return (response.data['data'] as List)
        .map((e) => FamilyMember.fromJson(e))
        .toList();
  }

  Future<FamilyTreeNode> getFamilyHierarchy({String? focusUserId}) async {
    final queryParams = <String, dynamic>{'depth': 5};
    if (focusUserId != null && focusUserId.isNotEmpty) {
      queryParams['focusUserId'] = focusUserId;
    }
    final response = await _dio.get(
      ApiEndpoints.familyHierarchy,
      queryParameters: queryParams,
    );
    return FamilyTreeNode.fromJson(response.data['data']['tree']);
  }

  Future<String> uploadFamilyMemberPhoto(String filePath) async {
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(filePath),
    });
    final response = await _dio.post(ApiEndpoints.familyUploadPhoto, data: formData);
    return response.data['data']['photoUrl'] as String;
  }

  Future<FamilyMember> addFamilyMember(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.familyMember, data: data);
    return FamilyMember.fromJson(response.data['data']);
  }

  Future<void> updateFamilyMember(String id, Map<String, dynamic> data) async {
    try {
      await _dio.put(ApiEndpoints.familyMemberId(id), data: data);
      return;
    } on DioException catch (error) {
      final message = error.response?.data is Map
          ? error.response?.data['message']?.toString()
          : null;
      final isMissingFamilyRecord =
          (error.response?.statusCode == 404 ||
              error.response?.statusCode == 500) &&
          message ==
              'Family member record not found or you do not have permission to update it.';
      if (!isMissingFamilyRecord) rethrow;

      final response = await _dio.get(ApiEndpoints.familyMember);
      final familyMemberId = _findFamilyMemberId(response.data, id);
      if (familyMemberId == null || familyMemberId.isEmpty) rethrow;
      await _dio.put(
        ApiEndpoints.familyMemberId(familyMemberId),
        data: data,
      );
    }
  }

  String? _findFamilyMemberId(Object? value, String linkedUserId) {
    if (value is List) {
      for (final item in value) {
        final id = _findFamilyMemberId(item, linkedUserId);
        if (id != null) return id;
      }
      return null;
    }
    if (value is! Map) return null;

    final linkedUser = value['linkedUser'];
    final linkedId =
        value['linkedUserId']?.toString() ??
        (linkedUser is Map ? linkedUser['id']?.toString() : null);
    if (linkedId == linkedUserId) {
      final familyMemberId = value['id']?.toString();
      if (familyMemberId != null && familyMemberId != linkedUserId) {
        return familyMemberId;
      }
    }

    for (final nestedValue in value.values) {
      final id = _findFamilyMemberId(nestedValue, linkedUserId);
      if (id != null) return id;
    }
    return null;
  }

  Future<void> deleteFamilyMember(String id) async {
    await _dio.delete(ApiEndpoints.familyMemberId(id));
  }
}
