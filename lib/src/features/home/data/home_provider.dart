import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../search/data/search_repository.dart';
import '../../search/data/search_models.dart';

part 'home_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<SearchResult>> recentMembers(Ref ref) async {
  final repo = ref.read(searchRepositoryProvider);
  return repo.searchMembers(limit: 5);
}
