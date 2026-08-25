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
    return (response.data['data'] as List).map((e) => FamilyMember.fromJson(e)).toList();
  }

  Future<FamilyTreeNode> getFamilyHierarchy() async {
    final response = await _dio.get(ApiEndpoints.familyTree);
    return FamilyTreeNode.fromJson(response.data['data']);
  }

  Future<FamilyMember> addFamilyMember(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.familyMember, data: data);
    return FamilyMember.fromJson(response.data['data']);
  }
}
