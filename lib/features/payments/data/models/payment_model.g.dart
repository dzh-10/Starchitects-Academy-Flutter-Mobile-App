// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentInitResponseImpl _$$PaymentInitResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentInitResponseImpl(
      paymentId: json['payment_id'] as String,
      checkoutUrl: json['checkout_url'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$PaymentInitResponseImplToJson(
        _$PaymentInitResponseImpl instance) =>
    <String, dynamic>{
      'payment_id': instance.paymentId,
      'checkout_url': instance.checkoutUrl,
      'status': instance.status,
    };

_$PaymentVerifyResponseImpl _$$PaymentVerifyResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentVerifyResponseImpl(
      paymentId: json['payment_id'] as String,
      status: json['status'] as String,
      courseId: json['course_id'] as String?,
      paidAmount: (json['paid_amount'] as num?)?.toDouble(),
      paidAt: json['paid_at'] == null
          ? null
          : DateTime.parse(json['paid_at'] as String),
    );

Map<String, dynamic> _$$PaymentVerifyResponseImplToJson(
        _$PaymentVerifyResponseImpl instance) =>
    <String, dynamic>{
      'payment_id': instance.paymentId,
      'status': instance.status,
      'course_id': instance.courseId,
      'paid_amount': instance.paidAmount,
      'paid_at': instance.paidAt?.toIso8601String(),
    };
