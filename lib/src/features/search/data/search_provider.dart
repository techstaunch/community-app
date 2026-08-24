import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'search_repository.dart';
import 'search_models.dart';

part 'search_provider.g.dart';

@riverpod
class SearchController extends _$SearchController {
  @override
  FutureOr<List<SearchResult>> build() async {
    return _fetchResults();
  }

  Future<List<SearchResult>> _fetchResults({String? query}) async {
    final repo = ref.read(searchRepositoryProvider);
    return await repo.searchMembers(query: query);
  }

  void search(String query) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchResults(query: query));
  }
}
