import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:community_connect/src/features/search/data/search_models.dart';
import 'package:community_connect/src/features/search/data/search_provider.dart';
import 'package:community_connect/src/features/search/data/search_repository.dart';

class _TrackingSearchRepository extends SearchRepository {
  final List<String?> recordedQueries = [];

  _TrackingSearchRepository() : super(Dio());

  @override
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
    recordedQueries.add(fullName ?? query);
    return [];
  }

  @override
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
    recordedQueries.add(fullName ?? query);
    return [];
  }
}

void main() {
  group('Search Debounce Tests', () {
    test('rapid search keystrokes are debounced and only the last one fires after 400ms', () async {
      final repo = _TrackingSearchRepository();
      final element = ProviderContainer(
        overrides: [
          searchRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(element.dispose);

      // Keep autoDispose provider alive during test
      final sub = element.listen(searchControllerProvider, (_, _) {});
      addTearDown(sub.close);

      final notifier = element.read(searchControllerProvider.notifier);
      await pumpEventQueue();
      expect(repo.recordedQueries.length, 0);

      // Rapidly simulate typing: "a", "ab", "abc"
      notifier.search(query: 'a');
      notifier.search(query: 'ab');
      notifier.search(query: 'abc');

      // Before 400ms has elapsed, no new queries should be sent
      await Future.delayed(const Duration(milliseconds: 100));
      await pumpEventQueue();
      expect(repo.recordedQueries.length, 0);

      // Wait past the 400ms debounce duration
      await Future.delayed(const Duration(milliseconds: 350));
      await pumpEventQueue();
      expect(repo.recordedQueries.length, 1);
      expect(repo.recordedQueries.last, 'abc');
    });

    test('search with immediate: true fires immediately without waiting for debounce duration', () async {
      final repo = _TrackingSearchRepository();
      final element = ProviderContainer(
        overrides: [
          searchRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(element.dispose);

      final sub = element.listen(searchControllerProvider, (_, _) {});
      addTearDown(sub.close);

      final notifier = element.read(searchControllerProvider.notifier);
      await pumpEventQueue();
      expect(repo.recordedQueries.length, 0);

      // Immediate search
      notifier.search(query: 'test_immediate', immediate: true);
      await pumpEventQueue();

      expect(repo.recordedQueries.length, 1);
      expect(repo.recordedQueries.last, 'test_immediate');
    });

    test('clearing query with empty string clears state immediately without unnecessary network call', () async {
      final repo = _TrackingSearchRepository();
      final element = ProviderContainer(
        overrides: [
          searchRepositoryProvider.overrideWithValue(repo),
        ],
      );
      addTearDown(element.dispose);

      final sub = element.listen(searchControllerProvider, (_, _) {});
      addTearDown(sub.close);

      final notifier = element.read(searchControllerProvider.notifier);
      await pumpEventQueue();
      expect(repo.recordedQueries.length, 0);

      // First run an active search
      notifier.search(query: 'active', immediate: true);
      await pumpEventQueue();
      expect(repo.recordedQueries.length, 1);

      // Clear query
      notifier.search(query: '');
      await pumpEventQueue();

      // No new API call should be sent and state should be empty
      expect(repo.recordedQueries.length, 1);
      expect(element.read(searchControllerProvider).value, isEmpty);
    });
  });
}
