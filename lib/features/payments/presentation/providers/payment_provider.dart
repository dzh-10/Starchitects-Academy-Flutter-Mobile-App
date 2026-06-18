import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/features/payments/data/models/payment_model.dart';
import 'package:starchitects_app/features/payments/data/repositories/payment_repository.dart';

part 'payment_provider.g.dart';

// ─── Payment Initiation ─────────────────────────────────────────────────

/// Manages payment initiation state.
/// Call [initiatePayment] with a courseId to start the payment flow.
@riverpod
class PaymentInit extends _$PaymentInit {
  @override
  FutureOr<PaymentInitResponse?> build() {
    return null;
  }

  /// Initiate a payment for the given course.
  /// On success, returns the checkout URL and payment ID.
  Future<PaymentInitResponse> initiatePayment(String courseId) async {
    state = const AsyncLoading();
    final repo = ref.read(paymentRepositoryProvider);
    final result = await repo.initiatePayment(courseId);
    state = AsyncData(result);
    return result;
  }
}

// ─── Payment Verification ───────────────────────────────────────────────

/// Polls the payment verification endpoint for a given paymentId.
/// Used to check if the payment was successful after the user
/// completes the Chargily checkout flow.
@riverpod
Future<PaymentVerifyResponse> paymentVerify(Ref ref, String paymentId) async {
  final repo = ref.read(paymentRepositoryProvider);
  return repo.verifyPayment(paymentId);
}
