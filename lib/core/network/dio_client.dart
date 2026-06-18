import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_constants.dart';
import '../storage/secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    receiveTimeout: const Duration(seconds: 15),
    connectTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
  ));

  dio.interceptors.add(AuthInterceptor(secureStorage));
  dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

  return dio;
});

class AuthInterceptor extends Interceptor {
  final SecureStorageService storage;
  
  AuthInterceptor(this.storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await storage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['Accept'] = 'application/json';
    options.headers['Accept-Language'] = 'ar';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token expired handled at provider level ideally
    }
    handler.next(err);
  }
}
