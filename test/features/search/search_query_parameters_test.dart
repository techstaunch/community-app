import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:community_connect/src/features/search/data/search_repository.dart';

void main() {
  group('Search Query Parameters Tests', () {
    late Dio dio;
    late SearchRepository repo;
    late Map<String, dynamic> lastQueryParameters;
    late String lastPath;

    setUp(() {
      dio = Dio();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            lastPath = options.path;
            lastQueryParameters = options.queryParameters;
            // Return fake empty response to prevent network calls
            return handler.resolve(
              Response(
                requestOptions: options,
                data: {
                  'success': true,
                  'message': 'Success',
                  'data': [],
                  'total': 0,
                  'page': 1,
                  'limit': 10,
                },
                statusCode: 200,
              ),
            );
          },
        ),
      );
      repo = SearchRepository(dio);
    });

    test('searchMembers sends fullName parameter (not query) with limit and page', () async {
      await repo.searchMembers(
        fullName: 'tom',
        page: 1,
        limit: 10,
      );

      expect(lastPath, equals('/search'));
      expect(lastQueryParameters['fullName'], equals('tom'));
      expect(lastQueryParameters.containsKey('query'), isFalse);
      expect(lastQueryParameters['page'], equals(1));
      expect(lastQueryParameters['limit'], equals(10));
    });

    test('searchMembers converts legacy query parameter to fullName', () async {
      await repo.searchMembers(
        query: 'tom',
        page: 2,
        limit: 20,
      );

      expect(lastPath, equals('/search'));
      expect(lastQueryParameters['fullName'], equals('tom'));
      expect(lastQueryParameters.containsKey('query'), isFalse);
      expect(lastQueryParameters['page'], equals(2));
      expect(lastQueryParameters['limit'], equals(20));
    });

    test('findMatchMembers sends fullName parameter (not query)', () async {
      await repo.findMatchMembers(
        fullName: 'priya',
        page: 1,
        limit: 10,
      );

      expect(lastPath, equals('/search/find-match'));
      expect(lastQueryParameters['fullName'], equals('priya'));
      expect(lastQueryParameters.containsKey('query'), isFalse);
      expect(lastQueryParameters['page'], equals(1));
      expect(lastQueryParameters['limit'], equals(10));
    });

    test('searchLinkableMembers sends fullName parameter (not query)', () async {
      await repo.searchLinkableMembers(
        fullName: 'jane',
        page: 1,
        limit: 10,
      );

      expect(lastPath, equals('/search/link-members'));
      expect(lastQueryParameters['fullName'], equals('jane'));
      expect(lastQueryParameters.containsKey('query'), isFalse);
      expect(lastQueryParameters['page'], equals(1));
      expect(lastQueryParameters['limit'], equals(10));
    });
  });
}
