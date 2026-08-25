import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import 'search_models.dart';

part 'search_repository.g.dart';

@riverpod
SearchRepository searchRepository(Ref ref) {
  return SearchRepository(ref.watch(apiClientProvider));
}

class SearchRepository {
  final Dio _dio;

  SearchRepository(this._dio);

  Future<List<SearchResult>> searchMembers({
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
    final response = await _dio.get(
      ApiEndpoints.search,
      queryParameters: {
        if (query != null && query.isNotEmpty) 'query': query,
        if (city != null && city.isNotEmpty) 'city': city,
        if (gender != null && gender.isNotEmpty) 'gender': gender,
        if (gotra != null && gotra.isNotEmpty) 'gotra': gotra,
        if (surname != null && surname.isNotEmpty) 'surname': surname,
        if (businessCategory != null && businessCategory.isNotEmpty) 'businessCategory': businessCategory,
        if (occupation != null && occupation.isNotEmpty) 'occupation': occupation,
        if (ageMin != null) 'ageMin': ageMin,
        if (ageMax != null) 'ageMax': ageMax,
        'page': page,
        'limit': limit,
      },
    );
    
    final searchResponse = SearchResponse.fromJson(response.data);
    return searchResponse.data;
  }
}
