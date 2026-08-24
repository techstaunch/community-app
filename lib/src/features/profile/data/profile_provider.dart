import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'profile_repository.dart';
import 'profile_models.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<UserProfile?> build() async {
    return _fetchProfile();
  }

  Future<UserProfile?> _fetchProfile() async {
    try {
      final repo = ref.read(profileRepositoryProvider);
      return await repo.getOwnProfile();
    } catch (e) {
      return null;
    }
  }

  Future<void> updateCoreProfile(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(profileRepositoryProvider);
      return await repo.updateCoreProfile(data);
    });
  }

  Future<void> updateJobDetails(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(profileRepositoryProvider);
      return await repo.updateJobDetails(data);
    });
  }

  Future<void> updateBusinessDetails(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(profileRepositoryProvider);
      return await repo.updateBusinessDetails(data);
    });
  }

  Future<void> uploadProfilePhoto(String filePath) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(profileRepositoryProvider);
      await repo.uploadProfilePhoto(filePath);
      return await repo.getOwnProfile();
    });
  }

  Future<void> deleteProfilePhoto() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(profileRepositoryProvider);
      await repo.deleteProfilePhoto();
      return await repo.getOwnProfile();
    });
  }
}
