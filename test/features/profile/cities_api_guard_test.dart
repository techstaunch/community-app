import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/profile/data/profile_provider.dart';
import 'package:community_connect/src/features/profile/data/profile_repository.dart';

void main() {
  group('Cities API Guard Tests', () {
    test('getCities returns empty list and does NOT call Dio when state is empty or whitespace', () async {
      var dioCallCount = 0;
      final dio = Dio();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            dioCallCount++;
            return handler.resolve(
              Response(
                requestOptions: options,
                data: {'success': true, 'data': {'cityNames': ['Surat']}},
                statusCode: 200,
              ),
            );
          },
        ),
      );

      final repo = ProfileRepository(dio);

      // Empty string
      final resEmpty = await repo.getCities('');
      expect(resEmpty, isEmpty);
      expect(dioCallCount, equals(0));

      // Whitespace string
      final resWhitespace = await repo.getCities('   ');
      expect(resWhitespace, isEmpty);
      expect(dioCallCount, equals(0));
    });

    test('getCities calls API with state query parameter when state is provided', () async {
      String? requestedState;
      final dio = Dio();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            requestedState = options.queryParameters['state']?.toString();
            return handler.resolve(
              Response(
                requestOptions: options,
                data: {
                  'success': true,
                  'data': {
                    'cityNames': ['Ahmedabad', 'Surat'],
                  },
                },
                statusCode: 200,
              ),
            );
          },
        ),
      );

      final repo = ProfileRepository(dio);
      final cities = await repo.getCities('Gujarat');

      expect(requestedState, equals('Gujarat'));
      expect(cities, equals(['Ahmedabad', 'Surat']));
    });

    test('citiesList provider returns empty list without calling repo when state is empty', () async {
      final element = ProviderContainer(
        overrides: [
          profileRepositoryProvider.overrideWithValue(_ThrowingProfileRepository()),
        ],
      );

      final cities = await element.read(citiesListProvider('').future);
      expect(cities, isEmpty);

      final citiesWhitespace = await element.read(citiesListProvider('   ').future);
      expect(citiesWhitespace, isEmpty);
    });
  });
}

class _ThrowingProfileRepository extends ProfileRepository {
  _ThrowingProfileRepository() : super(Dio());

  @override
  Future<List<String>> getCities(String state, {String? search}) {
    throw StateError('getCities should not be called when state is empty');
  }
}
