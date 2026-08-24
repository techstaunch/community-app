import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../utils/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import 'auth_models.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(apiClientProvider));
}

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<AuthResponse> requestOtp(String mobileNumber, {String purpose = 'Login'}) async {
    final response = await _dio.post(
      ApiEndpoints.authLogin,
      data: {
        'mobileNumber': mobileNumber,
        'purpose': purpose,
      },
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> verifyOtp(String mobileNumber, String code, {String purpose = 'Login'}) async {
    final response = await _dio.post(
      ApiEndpoints.authVerifyOtp,
      data: {
        'mobileNumber': mobileNumber,
        'code': code,
        'purpose': purpose,
      },
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<void> logout() async {
    await _dio.post(ApiEndpoints.authLogout);
  }

  Future<AuthResponse> refreshToken(String refreshToken) async {
    final response = await _dio.post(
      ApiEndpoints.authRefresh,
      data: {
        'refreshToken': refreshToken,
      },
    );
    return AuthResponse.fromJson(response.data);
  }
}
