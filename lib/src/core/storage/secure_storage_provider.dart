import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../utils/api_endpoints.dart';

part 'secure_storage_provider.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@Riverpod(keepAlive: true)
class AuthStorage extends _$AuthStorage {
  @override
  FutureOr<void> build() {}

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    final storage = ref.read(secureStorageProvider);
    await storage.write(key: ApiEndpoints.accessTokenKey, value: accessToken);
    await storage.write(key: ApiEndpoints.refreshTokenKey, value: refreshToken);
  }

  Future<void> clearTokens() async {
    final storage = ref.read(secureStorageProvider);
    await storage.delete(key: ApiEndpoints.accessTokenKey);
    await storage.delete(key: ApiEndpoints.refreshTokenKey);
  }

  Future<String?> getAccessToken() async {
    final storage = ref.read(secureStorageProvider);
    return await storage.read(key: ApiEndpoints.accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    final storage = ref.read(secureStorageProvider);
    return await storage.read(key: ApiEndpoints.refreshTokenKey);
  }
}
