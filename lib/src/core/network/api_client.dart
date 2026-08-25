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
      if (e.response?.statusCode == 401 && e.requestOptions.path != ApiEndpoints.authRefresh) {
        final authStorage = ref.read(authStorageProvider.notifier);
        final refreshToken = await authStorage.getRefreshToken();
        
        if (refreshToken != null) {
          try {
            // Use a clean Dio instance to avoid interceptor loops
            final refreshDio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
            final response = await refreshDio.post(
              ApiEndpoints.authRefresh,
              data: {'refreshToken': refreshToken},
            );
            
            final data = response.data['data'];
            final newAccessToken = data['accessToken'];
            final newRefreshToken = data['refreshToken'];
            
            if (newAccessToken != null && newRefreshToken != null) {
              await authStorage.saveTokens(
                accessToken: newAccessToken,
                refreshToken: newRefreshToken,
              );
              
              // Retry the original request with the new access token
              final opts = e.requestOptions;
              opts.headers['Authorization'] = 'Bearer $newAccessToken';
              
              // Fetch retry
              final retryDio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
              final retryResponse = await retryDio.fetch(opts);
              return handler.resolve(retryResponse);
            }
          } catch (refreshError) {
            // Refresh failed (e.g., refresh token expired)
            await authStorage.clearTokens();
          }
        } else {
          await authStorage.clearTokens();
        }
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
