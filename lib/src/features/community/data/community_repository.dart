import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import 'community_models.dart';

part 'community_repository.g.dart';

@riverpod
CommunityRepository communityRepository(Ref ref) {
  return CommunityRepository(ref.watch(apiClientProvider));
}

class CommunityRepository {
  final Dio _dio;

  CommunityRepository(this._dio);

  Future<void> joinCommunity(String inviteCode) async {
    await _dio.post(
      ApiEndpoints.communitiesJoin,
      data: {'inviteCode': inviteCode},
    );
  }

  Future<List<Community>> getMyMemberships() async {
    final response = await _dio.get(ApiEndpoints.communitiesMyMemberships);
    final data = response.data['data'] as List;
    return data.map((e) => Community.fromJson(e['community'])).toList();
  }

  Future<Community> createCommunity(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.communities, data: data);
    return Community.fromJson(response.data['data']);
  }

  Future<List<CommunityMember>> getCommunityMembers(String communityId, {int page = 1, int limit = 10}) async {
    final response = await _dio.get(
      '${ApiEndpoints.communities}/$communityId/members',
      queryParameters: {'page': page, 'limit': limit},
    );
    final data = response.data['data'] as List;
    return data.map((e) => CommunityMember.fromJson(e)).toList();
  }

  Future<void> approveJoinRequest(String communityId, String membershipId) async {
    await _dio.post(
      '${ApiEndpoints.communities}/$communityId/approve',
      data: {'membershipId': membershipId},
    );
  }

  Future<void> rejectJoinRequest(String communityId, String membershipId) async {
    await _dio.post(
      '${ApiEndpoints.communities}/$communityId/reject',
      data: {'membershipId': membershipId},
    );
  }

  Future<List<Announcement>> getAnnouncements(String communityId, {int page = 1, int limit = 10}) async {
    final response = await _dio.get(
      '/admin/$communityId/announcements',
      queryParameters: {'page': page, 'limit': limit},
    );
    final data = response.data['data'] as List;
    return data.map((e) => Announcement.fromJson(e)).toList();
  }

  Future<List<Event>> getEvents(String communityId, {int page = 1, int limit = 10}) async {
    final response = await _dio.get(
      '/admin/$communityId/events',
      queryParameters: {'page': page, 'limit': limit},
    );
    final data = response.data['data'] as List;
    return data.map((e) => Event.fromJson(e)).toList();
  }
}
