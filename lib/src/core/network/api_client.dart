import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../utils/api_endpoints.dart';
import '../storage/secure_storage_provider.dart';

part 'api_client.g.dart';

@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) {
  final dio = Dio(BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    headers: {'Content-Type': 'application/json'},
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final authStorage = ref.read(authStorageProvider.notifier);
      final token = await authStorage.getAccessToken();
      
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
    onError: (DioException e, handler) async {
      // Basic 401 handling
      if (e.response?.statusCode == 401) {
        // Here you would implement refresh token logic
        // If refresh fails, clear tokens and redirect to login
      }
      return handler.next(e);
    },
  ));

  // Add logging for network requests, parameters, and responses
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
  ));

  return dio;
}
