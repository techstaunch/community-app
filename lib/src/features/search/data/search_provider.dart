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

  Future<List<SearchResult>> _fetchResults({
    String? query,
    String? city,
    String? gender,
    String? gotra,
    String? surname,
    String? businessCategory,
    String? occupation,
    int? ageMin,
    int? ageMax,
    int page = 1,
    int limit = 10,
  }) async {
    final repo = ref.read(searchRepositoryProvider);
    return await repo.searchMembers(
      query: query,
      city: city,
      gender: gender,
      gotra: gotra,
      surname: surname,
      businessCategory: businessCategory,
      occupation: occupation,
      ageMin: ageMin,
      ageMax: ageMax,
      page: page,
      limit: limit,
    );
  }

  void search({
    String? query,
    String? city,
    String? gender,
    String? gotra,
    String? surname,
    String? businessCategory,
    String? occupation,
    int? ageMin,
    int? ageMax,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchResults(
      query: query,
      city: city,
      gender: gender,
      gotra: gotra,
      surname: surname,
      businessCategory: businessCategory,
      occupation: occupation,
      ageMin: ageMin,
      ageMax: ageMax,
    ));
  }
}
