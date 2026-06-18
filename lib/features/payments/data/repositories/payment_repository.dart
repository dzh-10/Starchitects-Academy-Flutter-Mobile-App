import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/core/api/api_client.dart';
import 'package:starchitects_app/core/api/api_endpoints.dart';
import 'package:starchitects_app/features/payments/data/models/payment_model.dart';

part 'payment_repository.g.dart';

/// Repository for payment-related API calls.
/// Handles Chargily payment initiation and status verification.
class PaymentRepository {
  final Dio _apiClient;

  PaymentRepository({required Dio Dio}) : _apiClient = Dio;

  // ─── Initiate Payment ─────────────────────────────────────────────────

  /// Initiates a payment for a course.
  /// Returns the Chargily checkout URL for redirecting the user.
  Future<PaymentInitResponse> initiatePayment(String courseId) async {
    final response = await _apiClient.post(
      ApiEndpoints.paymentsInitiate,
      data: {'course_id': courseId},
    );

    return PaymentInitResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  // ─── Verify Payment ──────────────────────────────────────────────────

  /// Verifies the status of a payment.
  /// Used to poll after the user completes the checkout flow.
  Future<PaymentVerifyResponse> verifyPayment(String paymentId) async {
    final response = await _apiClient.get(
      ApiEndpoints.paymentVerify(paymentId),
    );

    return PaymentVerifyResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}

@riverpod
PaymentRepository paymentRepository(Ref ref) {
  return PaymentRepository(
    Dio: ref.read(apiClientProvider),
  );
}
