import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/api_constants.dart';
import '../storage/secure_storage.dart';
import '../../features/auth/domain/auth_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Language': 'ar',
      },
    ),
  );

  dio.interceptors.add(AuthInterceptor(
    storage: secureStorage,
    dio: dio,
    onLogout: () {
      ref.read(authNotifierProvider.notifier).logout();
    },
  ));
  
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
      error: true,
    ),
  );

  return dio;
});

class AuthInterceptor extends Interceptor {
  final SecureStorageService storage;
  final Dio dio;
  final void Function() onLogout;
  bool _isRefreshing = false;

  AuthInterceptor({
    required this.storage,
    required this.dio,
    required this.onLogout,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isAuthRoute = options.path.contains(ApiConstants.login) ||
        options.path.contains(ApiConstants.register);

    if (!isAuthRoute) {
      final token = await storage.getToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      if (!_isRefreshing) {
        _isRefreshing = true;
        try {
          // محاولة تجديد التوكن
          // TODO: استبدل المسار بمسار تجديد التوكن الفعلي إذا كان متوفراً في الباك إند
          // final refreshResponse = await dio.post('/api/v1/refresh');
          // final newToken = refreshResponse.data['token'];
          // await storage.saveToken(newToken);
          
          // إذا نجح التجديد، أعد إرسال الطلب الأصلي
          // err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          // final retryResponse = await dio.fetch(err.requestOptions);
          // _isRefreshing = false;
          // return handler.resolve(retryResponse);
          
          // في غياب نقطة تجديد التوكن، نقوم بتسجيل الخروج
          _isRefreshing = false;
          onLogout();
          return handler.next(err);
        } catch (e) {
          _isRefreshing = false;
          onLogout();
          return handler.next(err);
        }
      }
    }
    handler.next(err);
  }
}