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
    return data.map((e) {
      if (e is Map<String, dynamic>) {
        final comm = e['community'];
        if (comm is Map<String, dynamic>) {
          final commMap = Map<String, dynamic>.from(comm);
          commMap['membershipStatus'] = e['status'] ?? commMap['membershipStatus'];
          return Community.fromJson(commMap);
        }
      }
      return Community.fromJson(e['community'] ?? e);
    }).toList();
  }

  Future<Community> createCommunity(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.communities, data: data);
    return Community.fromJson(response.data['data']);
  }

  Future<List<AppNotification>> getNotifications({String source = 'ALL'}) async {
    final response = await _dio.get(
      ApiEndpoints.notifications,
      queryParameters: {'source': source},
    );
    final data = response.data['data'] as List? ?? [];
    return data.map((e) => AppNotification.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> markNotificationAsRead(String id) async {
    try {
      await _dio.post(ApiEndpoints.notificationRead(id));
    } on DioException catch (e) {
      if (e.response?.statusCode == 405) {
        await _dio.patch(ApiEndpoints.notificationRead(id));
      } else {
        rethrow;
      }
    }
  }
}
