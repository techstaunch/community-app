import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'community_repository.dart';
import 'community_models.dart';

part 'community_provider.g.dart';

@riverpod
class MyCommunitiesController extends _$MyCommunitiesController {
  @override
  FutureOr<List<Community>> build() async {
    return _fetchMemberships();
  }

  Future<List<Community>> _fetchMemberships() async {
    final repo = ref.read(communityRepositoryProvider);
    return await repo.getMyMemberships();
  }

  Future<void> joinCommunity(String inviteCode) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(communityRepositoryProvider);
      await repo.joinCommunity(inviteCode);
      return _fetchMemberships();
    });
  }

  Future<void> createCommunity(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(communityRepositoryProvider);
      await repo.createCommunity(data);
      return _fetchMemberships();
    });
  }
}
