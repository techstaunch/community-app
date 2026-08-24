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
    try {
      final repo = ref.read(familyRepositoryProvider);
      return await repo.getFamilyHierarchy();
    } catch (e) {
      return null;
    }
  }

  Future<void> addFamilyMember(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(familyRepositoryProvider);
      await repo.addFamilyMember(data);
      return await repo.getFamilyHierarchy();
    });
  }
}
