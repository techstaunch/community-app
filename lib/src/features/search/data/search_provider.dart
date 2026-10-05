import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'search_repository.dart';
import 'search_models.dart';

part 'search_provider.g.dart';

@riverpod
class SearchController extends _$SearchController {
  int _page = 1;
  bool _hasMore = true;
  Timer? _debounceTimer;
  int _searchExecutionId = 0;

  String? _query;
  String? _state;
  String? _city;
  String? _gender;
  String? _gotra;
  String? _surname;
  String? _businessCategory;
  String? _occupation;
  int? _ageMin;
  int? _ageMax;

  int _tab = 0;
  int get currentTab => _tab;

  bool get hasActiveSearchOrFilter {
    final hasQuery = _query != null && _query!.trim().isNotEmpty;
    final hasFilter = activeFiltersCount > 0;
    return hasQuery || hasFilter;
  }

  @override
  FutureOr<List<SearchResult>> build() async {
    _page = 1;
    _hasMore = true;
    _searchExecutionId = 0;
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    if (!hasActiveSearchOrFilter) {
      return const [];
    }
    return _fetchResults();
  }

  Future<List<SearchResult>> _fetchResults() async {
    final repo = ref.read(searchRepositoryProvider);
    if (_tab == 1) {
      return await repo.findMatchMembers(
        fullName: _query,
        query: _query,
        state: _state,
        city: _city,
        gender: _gender,
        gotra: _gotra,
        surname: _surname,
        occupation: _occupation,
        ageMin: _ageMin,
        ageMax: _ageMax,
        page: _page,
        limit: 10,
      );
    }
    return await repo.searchMembers(
      fullName: _query,
      query: _query,
      state: _state,
      city: _city,
      gender: _gender,
      gotra: _gotra,
      surname: _surname,
      businessCategory: _businessCategory,
      occupation: _occupation,
      ageMin: _ageMin,
      ageMax: _ageMax,
      page: _page,
      limit: 10,
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || !_hasMore) return;

    final currentList = state.value ?? [];

    // In Riverpod 2+, simply doing AsyncLoading wipes the previous data,
    // unless we use `copyWithPrevious`. Since it's internal and gives warnings,
    // we can just await the future and update state manually to avoid losing UI.

    try {
      _page++;
      final newResults = await _fetchResults();
      if (newResults.isEmpty) {
        _hasMore = false;
      }
      state = AsyncData([...currentList, ...newResults]);
    } catch (e, st) {
      state = AsyncError<List<SearchResult>>(e, st);
    }
  }

  Future<void> refresh() async {
    _debounceTimer?.cancel();
    _page = 1;
    _hasMore = true;
    await _executeSearch();
  }

  int? get currentAgeMin => _ageMin;
  int? get currentAgeMax => _ageMax;
  String? get currentGender => _gender;
  String? get currentOccupation => _occupation;
  String? get currentState => _state;
  String? get currentCity => _city;
  String? get currentGotra => _gotra;
  String? get currentSurname => _surname;
  String? get currentBusinessCategory => _businessCategory;

  int get activeFiltersCount {
    int count = 0;
    if (_state != null && _state!.isNotEmpty) count++;
    if (_city != null && _city!.isNotEmpty) count++;
    if (_gender != null && _gender!.isNotEmpty) count++;
    if (_gotra != null && _gotra!.isNotEmpty) count++;
    if (_surname != null && _surname!.isNotEmpty) count++;
    if (_businessCategory != null && _businessCategory!.isNotEmpty) count++;
    if (_occupation != null && _occupation!.isNotEmpty) count++;
    if (_ageMin != null) count++;
    if (_ageMax != null) count++;
    return count;
  }

  Future<void> _executeSearch() async {
    final executionId = ++_searchExecutionId;
    if (!ref.mounted) return;
    if (!hasActiveSearchOrFilter) {
      state = const AsyncData([]);
      return;
    }
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() => _fetchResults());
    if (ref.mounted && executionId == _searchExecutionId) {
      state = result;
    }
  }

  void clearFiltersAndSearch() async {
    _debounceTimer?.cancel();
    _query = null;
    _state = null;
    _city = null;
    _gender = null;
    _gotra = null;
    _surname = null;
    _businessCategory = null;
    _occupation = null;
    _ageMin = null;
    _ageMax = null;
    _page = 1;
    _hasMore = true;

    state = const AsyncData([]);
  }

  void applyAdvancedFilters({
    String? stateName,
    String? gender,
    String? occupation,
    int? ageMin,
    int? ageMax,
    String? city,
    String? gotra,
    String? surname,
    String? businessCategory,
  }) async {
    _debounceTimer?.cancel();
    _state = stateName;
    _gender = gender;
    _occupation = occupation;
    _ageMin = ageMin;
    _ageMax = ageMax;
    _city = city;
    _gotra = gotra;
    _surname = surname;
    _businessCategory = businessCategory;

    _page = 1;
    _hasMore = true;

    await _executeSearch();
  }

  void switchTab(int tab) async {
    if (_tab == tab) return;
    _debounceTimer?.cancel();
    _tab = tab;
    _page = 1;
    _hasMore = true;
    if (tab == 0) {
      _gender = null;
      _gotra = null;
      _surname = null;
      _ageMin = null;
      _ageMax = null;
    } else {
      _businessCategory = null;
    }
    if (hasActiveSearchOrFilter) {
      await _executeSearch();
    } else {
      state = const AsyncData([]);
    }
  }

  void search({
    String? query,
    String? fullName,
    String? stateName,
    String? city,
    String? gender,
    String? gotra,
    String? surname,
    String? businessCategory,
    String? occupation,
    int? ageMin,
    int? ageMax,
    bool immediate = false,
  }) {
    final nameInput = fullName ?? query;
    _query = nameInput ?? _query;
    _state = stateName ?? _state;
    _city = city ?? _city;
    _gender = gender ?? _gender;
    _gotra = gotra ?? _gotra;
    _surname = surname ?? _surname;
    _businessCategory = businessCategory ?? _businessCategory;
    _occupation = occupation ?? _occupation;
    _ageMin = ageMin ?? _ageMin;
    _ageMax = ageMax ?? _ageMax;

    _page = 1;
    _hasMore = true;

    _debounceTimer?.cancel();

    // If query is emptied and no filters are active, clear immediately without network call
    if ((_query == null || _query!.trim().isEmpty) && activeFiltersCount == 0) {
      _searchExecutionId++;
      state = const AsyncData([]);
      return;
    }

    if (immediate) {
      _executeSearch();
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      _executeSearch();
    });
  }
}
