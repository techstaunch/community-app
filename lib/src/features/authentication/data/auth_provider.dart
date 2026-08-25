import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'auth_repository.dart';
import '../../../core/storage/secure_storage_provider.dart';

part 'auth_provider.g.dart';

enum AuthState { unauthenticated, loading, onboarding, pendingVerification, verified, error }

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  String? currentMobileNumber;
  String? currentPurpose;
  Timer? _refreshTimer;

  @override
  AuthState build() {
    ref.onDispose(() {
      _refreshTimer?.cancel();
    });
    
    // Check auth status on app start
    Future.microtask(() => checkAuthStatus());
    
    return AuthState.loading;
  }

  Future<void> checkAuthStatus() async {
    final token = await ref.read(authStorageProvider.notifier).getAccessToken();
    if (token != null) {
      state = AuthState.verified;
      _startPeriodicRefresh();
    } else {
      state = AuthState.unauthenticated;
    }
  }

  void _startPeriodicRefresh() {
    _refreshTimer?.cancel();
    // Refresh token every 15 minutes
    _refreshTimer = Timer.periodic(const Duration(minutes: 15), (_) async {
      try {
        final repo = ref.read(authRepositoryProvider);
        final refreshToken = await ref.read(authStorageProvider.notifier).getRefreshToken();
        if (refreshToken != null) {
          final response = await repo.refreshToken(refreshToken);
          if (response.success && response.data != null) {
             await ref.read(authStorageProvider.notifier).saveTokens(
               accessToken: response.data!.accessToken!,
               refreshToken: response.data!.refreshToken!,
             );
          } else {
            // Force logout on failed refresh
            logout();
          }
        }
      } catch (e) {
        logout();
      }
    });
  }

  Future<void> requestOtp(String mobileNumber, {String? purpose}) async {
    currentMobileNumber = mobileNumber;
    if (purpose != null) {
      currentPurpose = purpose;
    }
    state = AuthState.loading;
    try {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.requestOtp(mobileNumber, purpose: currentPurpose ?? 'Login');
      if (response.success) {
        state = AuthState.pendingVerification;
      } else {
        state = AuthState.error;
      }
    } catch (e) {
      state = AuthState.error;
    }
  }

  Future<void> verifyOtp(String mobileNumber, String code) async {
    state = AuthState.loading;
    try {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.verifyOtp(mobileNumber, code, purpose: currentPurpose ?? 'Login');
      
      if (response.success && response.data != null) {
        // Save tokens
        await ref.read(authStorageProvider.notifier).saveTokens(
          accessToken: response.data!.accessToken!,
          refreshToken: response.data!.refreshToken!,
        );
        
        if (response.data!.isNewUser == true || currentPurpose == 'Registration') {
          state = AuthState.onboarding;
        } else {
          state = AuthState.verified;
          _startPeriodicRefresh();
        }
      } else {
        state = AuthState.error;
      }
    } catch (e) {
      state = AuthState.error;
    }
  }

  void resetToLogin() {
    currentMobileNumber = null;
    currentPurpose = null;
    state = AuthState.unauthenticated;
  }

  Future<void> logout() async {
    _refreshTimer?.cancel();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.logout();
    } catch (_) {} // Ignore logout errors
    finally {
      await ref.read(authStorageProvider.notifier).clearTokens();
      state = AuthState.unauthenticated;
    }
  }
}
