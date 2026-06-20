import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/core/api/api_client.dart';
import 'package:starchitects_app/core/api/api_endpoints.dart';
import 'package:starchitects_app/features/payments/data/models/payment_model.dart';

part 'payment_repository.g.dart';

class PaymentRepository {
  final Dio _apiClient;

  PaymentRepository({required Dio Dio}) : _apiClient = Dio;

  Future<PaymentInitResponse> initiatePayment(String courseId) async {
    final response = await _apiClient.post(
      ApiEndpoints.paymentsInitiate,
      data: {'course_id': courseId},
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return PaymentInitResponse.fromJson(data);
    }
    throw Exception('Invalid response format');
  }

  Future<PaymentVerifyResponse> verifyPayment(String paymentId) async {
    final response = await _apiClient.get(
      ApiEndpoints.paymentVerify(paymentId),
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return PaymentVerifyResponse.fromJson(data);
    }
    throw Exception('Invalid response format');
  }
}

@riverpod
PaymentRepository paymentRepository(Ref ref) {
  return PaymentRepository(
    Dio: ref.read(apiClientProvider),
  );
}
