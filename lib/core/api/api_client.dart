import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/core/api/api_exceptions.dart';
import 'package:starchitects_app/core/storage/secure_storage.dart';
import '../network/dio_client.dart';

part 'api_client.g.dart';

/// Dio API client configured with auth interceptor, error mapping,
/// and debug logging. Provided as a keepAlive Riverpod provider.
@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) {
  return ref.watch(dioProvider);
}

/// Maps DioException to our custom ApiException hierarchy
ApiException _mapDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const RequestTimeoutException();

    case DioExceptionType.connectionError:
      return const NetworkException();

    case DioExceptionType.badResponse:
      return _mapStatusCode(error.response);

    case DioExceptionType.cancel:
      return const ApiException(message: 'ØªÙ… Ø¥Ù„ØºØ§Ø¡ Ø§Ù„Ø·Ù„Ø¨.');

    case DioExceptionType.badCertificate:
      return const ApiException(
        message: 'Ø®Ø·Ø£ ÙÙŠ Ø´Ù‡Ø§Ø¯Ø© Ø§Ù„Ø£Ù…Ø§Ù†. ÙŠØ±Ø¬Ù‰ Ø§Ù„ØªØ­Ù‚Ù‚ Ù…Ù† Ø§ØªØµØ§Ù„Ùƒ.',
      );

    case DioExceptionType.unknown:
    default:
      // Check for SocketException (network issues)
      if (error.error != null &&
          error.error.toString().contains('SocketException')) {
        return const NetworkException();
      }
      return const UnknownException();
  }
}

/// Maps HTTP status codes to specific ApiException types
ApiException _mapStatusCode(Response? response) {
  final statusCode = response?.statusCode;
  final data = response?.data;

  switch (statusCode) {
    case 401:
      return UnauthorizedException(
        message: _extractMessage(data) ??
            'Ø§Ù†ØªÙ‡Øª ØµÙ„Ø§Ø­ÙŠØ© Ø§Ù„Ø¬Ù„Ø³Ø©. ÙŠØ±Ø¬Ù‰ ØªØ³Ø¬ÙŠÙ„ Ø§Ù„Ø¯Ø®ÙˆÙ„ Ù…Ø±Ø© Ø£Ø®Ø±Ù‰.',
      );

    case 403:
      return ForbiddenException(
        message: _extractMessage(data) ??
            'Ù„ÙŠØ³ Ù„Ø¯ÙŠÙƒ ØµÙ„Ø§Ø­ÙŠØ© Ù„Ù„ÙˆØµÙˆÙ„ Ø¥Ù„Ù‰ Ù‡Ø°Ø§ Ø§Ù„Ù…Ø­ØªÙˆÙ‰.',
      );

    case 404:
      return NotFoundException(
        message: _extractMessage(data) ?? 'Ø§Ù„Ù…Ø­ØªÙˆÙ‰ Ø§Ù„Ù…Ø·Ù„ÙˆØ¨ ØºÙŠØ± Ù…ÙˆØ¬ÙˆØ¯.',
      );

    case 422:
      final fieldErrors = _extractFieldErrors(data);
      return ValidationException(
        message: _extractMessage(data) ?? 'ÙŠØ±Ø¬Ù‰ Ø§Ù„ØªØ­Ù‚Ù‚ Ù…Ù† Ø§Ù„Ø¨ÙŠØ§Ù†Ø§Øª Ø§Ù„Ù…Ø¯Ø®Ù„Ø©.',
        fieldErrors: fieldErrors,
        statusCode: 422,
        data: data,
      );

    case 429:
      return const ApiException(
        message: 'Ø·Ù„Ø¨Ø§Øª ÙƒØ«ÙŠØ±Ø© Ø¬Ø¯Ø§Ù‹. ÙŠØ±Ø¬Ù‰ Ø§Ù„Ø§Ù†ØªØ¸Ø§Ø± Ù‚Ù„ÙŠÙ„Ø§Ù‹.',
        statusCode: 429,
      );

    default:
      if (statusCode != null && statusCode >= 500) {
        return ServerException(
          message: _extractMessage(data) ??
              'Ø­Ø¯Ø« Ø®Ø·Ø£ ÙÙŠ Ø§Ù„Ø®Ø§Ø¯Ù…. ÙŠØ±Ø¬Ù‰ Ø§Ù„Ù…Ø­Ø§ÙˆÙ„Ø© Ù„Ø§Ø­Ù‚Ø§Ù‹.',
          statusCode: statusCode,
        );
      }
      return UnknownException(
        message: _extractMessage(data) ??
            'Ø­Ø¯Ø« Ø®Ø·Ø£ ØºÙŠØ± Ù…ØªÙˆÙ‚Ø¹. ÙŠØ±Ø¬Ù‰ Ø§Ù„Ù…Ø­Ø§ÙˆÙ„Ø© Ù…Ø±Ø© Ø£Ø®Ø±Ù‰.',
        statusCode: statusCode,
      );
  }
}

/// Extract the main error message from a response body
String? _extractMessage(dynamic data) {
  if (data is Map<String, dynamic>) {
    return data['message'] as String?;
  }
  return null;
}

/// Extract field-level validation errors from a 422 response
Map<String, List<String>> _extractFieldErrors(dynamic data) {
  if (data is Map<String, dynamic> && data.containsKey('errors')) {
    final errors = data['errors'];
    if (errors is Map<String, dynamic>) {
      return errors.map(
        (key, value) => MapEntry(
          key,
          (value is List) ? value.map((e) => e.toString()).toList() : [value.toString()],
        ),
      );
    }
  }
  return {};
}
