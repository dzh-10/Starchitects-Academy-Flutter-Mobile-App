import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starchitects_app/core/api/api_exceptions.dart';
import 'package:starchitects_app/core/storage/secure_storage.dart';
import '../network/dio_client.dart';

part 'api_client.g.dart';

@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) {
  return ref.watch(dioProvider);
}

Exception _mapDioException(DioException error) {
  if (error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.sendTimeout) {
    return const NetworkException(message: 'انتهى وقت الاتصال');
  }

  if (error.response != null) {
    switch (error.response?.statusCode) {
      case 401:
        return const UnauthorizedException(message: 'غير مصرح. يرجى تسجيل الدخول مجدداً.');
      case 403:
        return const ForbiddenException(message: 'ليس لديك صلاحية الوصول.');
      case 404:
        return const NotFoundException(message: 'المورد غير موجود.');
      case 422:
        final data = error.response?.data;
        if (data is Map<String, dynamic> && data.containsKey('errors')) {
          final errors = data['errors'] as Map<String, dynamic>;
          final firstErrorMsg = errors.values.first.first.toString();
          return ValidationException(message: firstErrorMsg);
        }
        return const ValidationException(message: 'بيانات غير صالحة.');
      case 500:
        return const ServerException(message: 'خطأ في الخادم. يرجى المحاولة لاحقاً.');
      default:
        return ApiException(message: 'خطأ غير معروف: \${error.response?.statusCode}');
    }
  }

  return const NetworkException(message: 'لا يوجد اتصال بالإنترنت');
}
