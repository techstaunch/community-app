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
    try {
      final repo = ref.read(communityRepositoryProvider);
      await repo.joinCommunity(inviteCode);
      state = AsyncValue.data(await _fetchMemberships());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

}

@riverpod
Future<List<Announcement>> communityAnnouncements(Ref ref, String communityId) async {
  final repo = ref.watch(communityRepositoryProvider);
  return repo.getAnnouncements(communityId);
}

@riverpod
Future<List<Event>> communityEvents(Ref ref, String communityId) async {
  final repo = ref.watch(communityRepositoryProvider);
  return repo.getEvents(communityId);
}
