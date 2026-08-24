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
    int page = 1,
    int limit = 10,
  }) async {
    final response = await _dio.get(
      ApiEndpoints.search,
      queryParameters: {
        if (query != null && query.isNotEmpty) 'query': query,
        if (city != null && city.isNotEmpty) 'city': city,
        if (gender != null && gender.isNotEmpty) 'gender': gender,
        'page': page,
        'limit': limit,
      },
    );
    
    final searchResponse = SearchResponse.fromJson(response.data);
    return searchResponse.data;
  }
}
