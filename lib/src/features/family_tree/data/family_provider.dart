import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'family_repository.dart';
import 'family_models.dart';

part 'family_provider.g.dart';

@riverpod
class FamilyController extends _$FamilyController {
  @override
  FutureOr<FamilyTreeNode?> build() async {
    return _fetchHierarchy();
  }

  Future<FamilyTreeNode?> _fetchHierarchy() async {
    final repo = ref.read(familyRepositoryProvider);
    return await repo.getFamilyHierarchy();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchHierarchy());
  }

  Future<void> addFamilyMember(Map<String, dynamic> data) async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(familyRepositoryProvider);
      await repo.addFamilyMember(data);
      final newTree = await repo.getFamilyHierarchy();
      state = AsyncValue.data(newTree);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> updateFamilyMember(String id, Map<String, dynamic> data) async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(familyRepositoryProvider);
      await repo.updateFamilyMember(id, data);
      final newTree = await repo.getFamilyHierarchy();
      state = AsyncValue.data(newTree);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> deleteFamilyMember(String id) async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(familyRepositoryProvider);
      await repo.deleteFamilyMember(id);
      final newTree = await repo.getFamilyHierarchy();
      state = AsyncValue.data(newTree);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }
}

@riverpod
Future<FamilyTreeNode?> memberFamilyTree(Ref ref, String userId) async {
  final repo = ref.read(familyRepositoryProvider);
  return await repo.getFamilyHierarchy(focusUserId: userId);
}
