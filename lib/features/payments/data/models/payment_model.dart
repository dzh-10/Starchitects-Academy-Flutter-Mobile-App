import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

/// Response from POST /payments/initiate
/// Contains the Chargily checkout URL for redirecting the user.
@freezed
abstract class PaymentInitResponse with _$PaymentInitResponse {
  const factory PaymentInitResponse({
    @JsonKey(name: 'payment_id') required String paymentId,
    @JsonKey(name: 'checkout_url') required String checkoutUrl,
    required String status,
  }) = _PaymentInitResponse;

  factory PaymentInitResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentInitResponseFromJson(json);
}

/// Response from GET /payments/{id}/verify
/// Used to poll the payment status after the user completes checkout.
@freezed
abstract class PaymentVerifyResponse with _$PaymentVerifyResponse {
  const factory PaymentVerifyResponse({
    @JsonKey(name: 'payment_id') required String paymentId,
    required String status,
    @JsonKey(name: 'course_id') String? courseId,
    @JsonKey(name: 'paid_amount') double? paidAmount,
    @JsonKey(name: 'paid_at') DateTime? paidAt,
  }) = _PaymentVerifyResponse;

  factory PaymentVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentVerifyResponseFromJson(json);
}
