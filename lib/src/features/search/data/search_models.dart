import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_models.freezed.dart';
part 'search_models.g.dart';

@freezed
abstract class SearchResult with _$SearchResult {
  const factory SearchResult({
    String? id,
    String? fullName,
    String? profilePhotoUrl,
    String? city,
    String? gender,
    String? designation,
    String? companyName,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) => _$SearchResultFromJson(json);
}

@freezed
abstract class SearchResponse with _$SearchResponse {
  const factory SearchResponse({
    required bool success,
    required String message,
    required List<SearchResult> data,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);
}
