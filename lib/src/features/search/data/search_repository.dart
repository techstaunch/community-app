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
    String? fullName,
    String? state,
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
    final effectiveFullName = (fullName != null && fullName.isNotEmpty)
        ? fullName
        : (query != null && query.isNotEmpty ? query : null);
    final response = await _dio.get(
      ApiEndpoints.search,
      queryParameters: {
        'fullName': ?effectiveFullName,
        'limit': limit,
        'page': page,
        if (state != null && state.isNotEmpty) 'state': state,
        if (city != null && city.isNotEmpty) 'city': city,
        if (gender != null && gender.isNotEmpty) 'gender': gender,
        if (gotra != null && gotra.isNotEmpty) 'gotra': gotra,
        if (surname != null && surname.isNotEmpty) 'surname': surname,
        if (businessCategory != null && businessCategory.isNotEmpty) 'businessCategory': businessCategory,
        if (occupation != null && occupation.isNotEmpty) 'occupation': occupation,
        'ageMin': ?ageMin,
        'ageMax': ?ageMax,
      },
    );
    
    final searchResponse = SearchResponse.fromJson(response.data);
    return searchResponse.data;
  }

  Future<List<SearchResult>> findMatchMembers({
    String? query,
    String? fullName,
    String? state,
    String? city,
    String? gender,
    String? gotra,
    String? surname,
    String? occupation,
    int? ageMin,
    int? ageMax,
    int page = 1,
    int limit = 10,
  }) async {
    final effectiveFullName = (fullName != null && fullName.isNotEmpty)
        ? fullName
        : (query != null && query.isNotEmpty ? query : null);
    final response = await _dio.get(
      ApiEndpoints.searchFindMatch,
      queryParameters: {
        'fullName': ?effectiveFullName,
        'limit': limit,
        'page': page,
        if (state != null && state.isNotEmpty) 'state': state,
        if (city != null && city.isNotEmpty) 'city': city,
        if (gender != null && gender.isNotEmpty) 'gender': gender,
        if (gotra != null && gotra.isNotEmpty) 'gotra': gotra,
        if (surname != null && surname.isNotEmpty) 'surname': surname,
        if (occupation != null && occupation.isNotEmpty) 'occupation': occupation,
        'ageMin': ?ageMin,
        'ageMax': ?ageMax,
      },
    );
    
    final searchResponse = SearchResponse.fromJson(response.data);
    return searchResponse.data;
  }

  Future<List<SearchResult>> searchLinkableMembers({
    String? query,
    String? fullName,
    String? mobileNumber,
    String? city,
    String? gender,
    String? gotra,
    String? surname,
    int page = 1,
    int limit = 10,
  }) async {
    final effectiveFullName = (fullName != null && fullName.isNotEmpty)
        ? fullName
        : (query != null && query.isNotEmpty ? query : null);
    final response = await _dio.get(
      ApiEndpoints.searchLinkMembers,
      queryParameters: {
        'fullName': ?effectiveFullName,
        'limit': limit,
        'page': page,
        if (mobileNumber != null && mobileNumber.isNotEmpty) 'mobileNumber': mobileNumber,
        if (city != null && city.isNotEmpty) 'city': city,
        if (gender != null && gender.isNotEmpty) 'gender': gender,
        if (gotra != null && gotra.isNotEmpty) 'gotra': gotra,
        if (surname != null && surname.isNotEmpty) 'surname': surname,
      },
    );
    final searchResponse = SearchResponse.fromJson(response.data);
    return searchResponse.data;
  }

  Future<SearchResult> getMember(String id) async {
    final response = await _dio.get(ApiEndpoints.searchMember(id));
    return SearchResult.fromJson(response.data['data']);
  }

  Future<SearchResult> getLinkableMember(String id) async {
    final response = await _dio.get(ApiEndpoints.searchLinkMember(id));
    return SearchResult.fromJson(response.data['data']);
  }
}
