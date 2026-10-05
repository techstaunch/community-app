import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'profile_repository.dart';
import 'profile_models.dart';

part 'profile_provider.g.dart';

@riverpod
Future<UserProfile> memberProfile(Ref ref, String id) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getMemberProfile(id);
}

@riverpod
Future<List<String>> statesList(Ref ref) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getStates();
}

@riverpod
Future<List<String>> citiesList(Ref ref, String state) async {
  final trimmed = state.trim();
  if (trimmed.isEmpty) {
    return const [];
  }
  final repo = ref.read(profileRepositoryProvider);
  return repo.getCities(trimmed);
}

@riverpod
Future<List<String>> businessCategoriesList(Ref ref) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getBusinessCategories();
}

@riverpod
Future<List<UserProfile>> blockedUsers(Ref ref) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.getBlockedUsers();
}

@riverpod
Future<bool> blockStatus(Ref ref, String userId) async {
  final repo = ref.read(profileRepositoryProvider);
  return repo.checkBlockStatus(userId);
}

@Riverpod(keepAlive: true)
class ProfileController extends _$ProfileController {
  @override
  FutureOr<UserProfile?> build() async {
    return _fetchProfile();
  }

  Future<UserProfile?> _fetchProfile() async {
    final repo = ref.read(profileRepositoryProvider);
    return repo.getOwnProfile();
  }

  Future<void> refresh() async {
    final previousState = state;
    state = await AsyncValue.guard(_fetchProfile);
    if (state.hasError &&
        previousState.hasValue &&
        previousState.value != null) {
      state = AsyncValue.data(previousState.requireValue);
    }
  }

  Future<void> updateCoreProfile(Map<String, dynamic> data) async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(profileRepositoryProvider);
      await repo.updateCoreProfile(data);
      final refreshed = await repo.getOwnProfile();
      state = AsyncValue.data(refreshed);
    } catch (e) {
      if (previousState.hasValue) {
        state = AsyncValue.data(previousState.value!);
      } else {
        state = AsyncValue.error(e, StackTrace.current);
      }
      rethrow;
    }
  }

  Future<void> updateJobDetails(Map<String, dynamic> data) async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(profileRepositoryProvider);
      await repo.updateJobDetails(data);
      final refreshed = await repo.getOwnProfile();
      state = AsyncValue.data(refreshed);
    } catch (e, st) {
      state = previousState.hasValue
          ? AsyncValue.data(previousState.value!)
          : AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateBusinessDetails(Map<String, dynamic> data) async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(profileRepositoryProvider);
      await repo.updateBusinessDetails(data);
      final refreshed = await repo.getOwnProfile();
      state = AsyncValue.data(refreshed);
    } catch (e, st) {
      state = previousState.hasValue
          ? AsyncValue.data(previousState.value!)
          : AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> deleteJobDetails() async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(profileRepositoryProvider);
      await repo.deleteJobDetails();
      final refreshed = await repo.getOwnProfile();
      state = AsyncValue.data(refreshed);
    } catch (e, st) {
      state = previousState.hasValue
          ? AsyncValue.data(previousState.value!)
          : AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> deleteBusinessDetails() async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(profileRepositoryProvider);
      await repo.deleteBusinessDetails();
      final refreshed = await repo.getOwnProfile();
      state = AsyncValue.data(refreshed);
    } catch (e, st) {
      state = previousState.hasValue
          ? AsyncValue.data(previousState.value!)
          : AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updatePrivacySettings(Map<String, dynamic> data) async {
    try {
      final repo = ref.read(profileRepositoryProvider);

      // We must send the *full* payload to the backend, so we merge it with existing state first
      if (state.hasValue && state.value != null) {
        final currentProfile = state.value!;
        final currentPrivacy =
            currentProfile.privacySettings ?? const PrivacySettings();

        final updatedPrivacy = currentPrivacy.copyWith(
          showMobileNumber: data.containsKey('showMobileNumber')
              ? data['showMobileNumber'] as bool
              : currentPrivacy.showMobileNumber ?? true,
          showEmail: data.containsKey('showEmail')
              ? data['showEmail'] as bool
              : currentPrivacy.showEmail ?? true,
          showGotra: data.containsKey('showGotra')
              ? data['showGotra'] as bool
              : currentPrivacy.showGotra ?? true,
          showFamilyInfo: data.containsKey('showFamilyInfo')
              ? data['showFamilyInfo'] as bool
              : currentPrivacy.showFamilyInfo ?? true,
          showMaternalInfo: data.containsKey('showMaternalInfo')
              ? data['showMaternalInfo'] as bool
              : currentPrivacy.showMaternalInfo ?? true,
          showBusinessInfo: data.containsKey('showBusinessInfo')
              ? data['showBusinessInfo'] as bool
              : currentPrivacy.showBusinessInfo ?? true,
          showProfessionalInfo: data.containsKey('showProfessionalInfo')
              ? data['showProfessionalInfo'] as bool
              : currentPrivacy.showProfessionalInfo ?? true,
          showInstagram: data.containsKey('showInstagram')
              ? data['showInstagram'] as bool
              : currentPrivacy.showInstagram ?? true,
          showFacebook: data.containsKey('showFacebook')
              ? data['showFacebook'] as bool
              : currentPrivacy.showFacebook ?? true,
          showLinkedin: data.containsKey('showLinkedin')
              ? data['showLinkedin'] as bool
              : currentPrivacy.showLinkedin ?? true,
          showTwitter: data.containsKey('showTwitter')
              ? data['showTwitter'] as bool
              : currentPrivacy.showTwitter ?? true,
          isFindmatch: data.containsKey('isFindmatch')
              ? data['isFindmatch'] as bool
              : currentPrivacy.isFindmatch ?? false,
        );

        // Optimistically update the UI to avoid waiting for network
        state = AsyncValue.data(
          currentProfile.copyWith(privacySettings: updatedPrivacy),
        );

        // Send the fully assembled payload so the backend doesn't overwrite other fields with null
        await repo.updatePrivacySettings(updatedPrivacy.toJson());

        // Optionally fetch the full profile in the background just to be absolutely in sync
        final refreshed = await repo.getOwnProfile();
        if (state.hasValue && state.value != null) {
          state = AsyncValue.data(refreshed);
        }
      } else {
        // Fallback if state was somehow empty
        await repo.updatePrivacySettings(data);
        final refreshed = await repo.getOwnProfile();
        state = AsyncValue.data(refreshed);
      }
    } catch (e) {
      // Fallback: re-fetch the profile to restore correct state if API failed
      final repo = ref.read(profileRepositoryProvider);
      final reverted = await repo.getOwnProfile();
      state = AsyncValue.data(reverted);
    }
  }

  Future<void> uploadProfilePhoto(String filePath) async {
    try {
      final repo = ref.read(profileRepositoryProvider);
      await repo.uploadProfilePhoto(filePath);
      final refreshed = await repo.getOwnProfile();
      state = AsyncValue.data(refreshed);
    } catch (e) {
      // Don't wipe the screen, just swallow or handle error here.
    }
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
