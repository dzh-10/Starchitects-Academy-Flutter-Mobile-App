/// Starchitects Academy API Exceptions
/// Custom exception classes with user-friendly Arabic error messages

/// Base API exception
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// No internet connection
class NetworkException extends ApiException {
  const NetworkException({
    super.message = 'لا يوجد اتصال بالإنترنت. يرجى التحقق من اتصالك والمحاولة مرة أخرى.',
    super.statusCode,
    super.data,
  });
}

/// Request timed out
class RequestTimeoutException extends ApiException {
  const RequestTimeoutException({
    super.message = 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.',
    super.statusCode,
    super.data,
  });
}

/// Server error (500+)
class ServerException extends ApiException {
  const ServerException({
    super.message = 'حدث خطأ في الخادم. يرجى المحاولة لاحقاً.',
    super.statusCode,
    super.data,
  });
}

/// Unauthorized (401)
class UnauthorizedException extends ApiException {
  const UnauthorizedException({
    super.message = 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.',
    super.statusCode = 401,
    super.data,
  });
}

/// Forbidden (403)
class ForbiddenException extends ApiException {
  const ForbiddenException({
    super.message = 'ليس لديك صلاحية للوصول إلى هذا المحتوى.',
    super.statusCode = 403,
    super.data,
  });
}

/// Not found (404)
class NotFoundException extends ApiException {
  const NotFoundException({
    super.message = 'المحتوى المطلوب غير موجود.',
    super.statusCode = 404,
    super.data,
  });
}

/// Validation error (422) with field-level errors
class ValidationException extends ApiException {
  final Map<String, List<String>> fieldErrors;

  const ValidationException({
    super.message = 'يرجى التحقق من البيانات المدخلة.',
    super.statusCode = 422,
    super.data,
    this.fieldErrors = const {},
  });

  /// Get the first error message for a specific field
  String? fieldError(String field) {
    final errors = fieldErrors[field];
    return errors != null && errors.isNotEmpty ? errors.first : null;
  }

  /// Get all error messages as a single flat list
  List<String> get allErrors =>
      fieldErrors.values.expand((errors) => errors).toList();

  @override
  String toString() =>
      'ValidationException($statusCode): $message | Fields: $fieldErrors';
}

/// Unknown / unhandled error
class UnknownException extends ApiException {
  const UnknownException({
    super.message = 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.',
    super.statusCode,
    super.data,
  });
}
