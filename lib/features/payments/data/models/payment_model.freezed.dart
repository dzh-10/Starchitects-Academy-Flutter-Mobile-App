// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentInitResponse _$PaymentInitResponseFromJson(Map<String, dynamic> json) {
  return _PaymentInitResponse.fromJson(json);
}

/// @nodoc
mixin _$PaymentInitResponse {
  @JsonKey(name: 'payment_id')
  String get paymentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'checkout_url')
  String get checkoutUrl => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentInitResponseCopyWith<PaymentInitResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentInitResponseCopyWith<$Res> {
  factory $PaymentInitResponseCopyWith(
          PaymentInitResponse value, $Res Function(PaymentInitResponse) then) =
      _$PaymentInitResponseCopyWithImpl<$Res, PaymentInitResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'payment_id') String paymentId,
      @JsonKey(name: 'checkout_url') String checkoutUrl,
      String status});
}

/// @nodoc
class _$PaymentInitResponseCopyWithImpl<$Res, $Val extends PaymentInitResponse>
    implements $PaymentInitResponseCopyWith<$Res> {
  _$PaymentInitResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? checkoutUrl = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      checkoutUrl: null == checkoutUrl
          ? _value.checkoutUrl
          : checkoutUrl // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentInitResponseImplCopyWith<$Res>
    implements $PaymentInitResponseCopyWith<$Res> {
  factory _$$PaymentInitResponseImplCopyWith(_$PaymentInitResponseImpl value,
          $Res Function(_$PaymentInitResponseImpl) then) =
      __$$PaymentInitResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'payment_id') String paymentId,
      @JsonKey(name: 'checkout_url') String checkoutUrl,
      String status});
}

/// @nodoc
class __$$PaymentInitResponseImplCopyWithImpl<$Res>
    extends _$PaymentInitResponseCopyWithImpl<$Res, _$PaymentInitResponseImpl>
    implements _$$PaymentInitResponseImplCopyWith<$Res> {
  __$$PaymentInitResponseImplCopyWithImpl(_$PaymentInitResponseImpl _value,
      $Res Function(_$PaymentInitResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? checkoutUrl = null,
    Object? status = null,
  }) {
    return _then(_$PaymentInitResponseImpl(
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      checkoutUrl: null == checkoutUrl
          ? _value.checkoutUrl
          : checkoutUrl // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentInitResponseImpl implements _PaymentInitResponse {
  const _$PaymentInitResponseImpl(
      {@JsonKey(name: 'payment_id') required this.paymentId,
      @JsonKey(name: 'checkout_url') required this.checkoutUrl,
      required this.status});

  factory _$PaymentInitResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentInitResponseImplFromJson(json);

  @override
  @JsonKey(name: 'payment_id')
  final String paymentId;
  @override
  @JsonKey(name: 'checkout_url')
  final String checkoutUrl;
  @override
  final String status;

  @override
  String toString() {
    return 'PaymentInitResponse(paymentId: $paymentId, checkoutUrl: $checkoutUrl, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentInitResponseImpl &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.checkoutUrl, checkoutUrl) ||
                other.checkoutUrl == checkoutUrl) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, paymentId, checkoutUrl, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentInitResponseImplCopyWith<_$PaymentInitResponseImpl> get copyWith =>
      __$$PaymentInitResponseImplCopyWithImpl<_$PaymentInitResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentInitResponseImplToJson(
      this,
    );
  }
}

abstract class _PaymentInitResponse implements PaymentInitResponse {
  const factory _PaymentInitResponse(
      {@JsonKey(name: 'payment_id') required final String paymentId,
      @JsonKey(name: 'checkout_url') required final String checkoutUrl,
      required final String status}) = _$PaymentInitResponseImpl;

  factory _PaymentInitResponse.fromJson(Map<String, dynamic> json) =
      _$PaymentInitResponseImpl.fromJson;

  @override
  @JsonKey(name: 'payment_id')
  String get paymentId;
  @override
  @JsonKey(name: 'checkout_url')
  String get checkoutUrl;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$PaymentInitResponseImplCopyWith<_$PaymentInitResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentVerifyResponse _$PaymentVerifyResponseFromJson(
    Map<String, dynamic> json) {
  return _PaymentVerifyResponse.fromJson(json);
}

/// @nodoc
mixin _$PaymentVerifyResponse {
  @JsonKey(name: 'payment_id')
  String get paymentId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'course_id')
  String? get courseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_amount')
  double? get paidAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_at')
  DateTime? get paidAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentVerifyResponseCopyWith<PaymentVerifyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentVerifyResponseCopyWith<$Res> {
  factory $PaymentVerifyResponseCopyWith(PaymentVerifyResponse value,
          $Res Function(PaymentVerifyResponse) then) =
      _$PaymentVerifyResponseCopyWithImpl<$Res, PaymentVerifyResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'payment_id') String paymentId,
      String status,
      @JsonKey(name: 'course_id') String? courseId,
      @JsonKey(name: 'paid_amount') double? paidAmount,
      @JsonKey(name: 'paid_at') DateTime? paidAt});
}

/// @nodoc
class _$PaymentVerifyResponseCopyWithImpl<$Res,
        $Val extends PaymentVerifyResponse>
    implements $PaymentVerifyResponseCopyWith<$Res> {
  _$PaymentVerifyResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? status = null,
    Object? courseId = freezed,
    Object? paidAmount = freezed,
    Object? paidAt = freezed,
  }) {
    return _then(_value.copyWith(
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: freezed == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentVerifyResponseImplCopyWith<$Res>
    implements $PaymentVerifyResponseCopyWith<$Res> {
  factory _$$PaymentVerifyResponseImplCopyWith(
          _$PaymentVerifyResponseImpl value,
          $Res Function(_$PaymentVerifyResponseImpl) then) =
      __$$PaymentVerifyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'payment_id') String paymentId,
      String status,
      @JsonKey(name: 'course_id') String? courseId,
      @JsonKey(name: 'paid_amount') double? paidAmount,
      @JsonKey(name: 'paid_at') DateTime? paidAt});
}

/// @nodoc
class __$$PaymentVerifyResponseImplCopyWithImpl<$Res>
    extends _$PaymentVerifyResponseCopyWithImpl<$Res,
        _$PaymentVerifyResponseImpl>
    implements _$$PaymentVerifyResponseImplCopyWith<$Res> {
  __$$PaymentVerifyResponseImplCopyWithImpl(_$PaymentVerifyResponseImpl _value,
      $Res Function(_$PaymentVerifyResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = null,
    Object? status = null,
    Object? courseId = freezed,
    Object? paidAmount = freezed,
    Object? paidAt = freezed,
  }) {
    return _then(_$PaymentVerifyResponseImpl(
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: freezed == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String?,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentVerifyResponseImpl implements _PaymentVerifyResponse {
  const _$PaymentVerifyResponseImpl(
      {@JsonKey(name: 'payment_id') required this.paymentId,
      required this.status,
      @JsonKey(name: 'course_id') this.courseId,
      @JsonKey(name: 'paid_amount') this.paidAmount,
      @JsonKey(name: 'paid_at') this.paidAt});

  factory _$PaymentVerifyResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentVerifyResponseImplFromJson(json);

  @override
  @JsonKey(name: 'payment_id')
  final String paymentId;
  @override
  final String status;
  @override
  @JsonKey(name: 'course_id')
  final String? courseId;
  @override
  @JsonKey(name: 'paid_amount')
  final double? paidAmount;
  @override
  @JsonKey(name: 'paid_at')
  final DateTime? paidAt;

  @override
  String toString() {
    return 'PaymentVerifyResponse(paymentId: $paymentId, status: $status, courseId: $courseId, paidAmount: $paidAmount, paidAt: $paidAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentVerifyResponseImpl &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, paymentId, status, courseId, paidAmount, paidAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentVerifyResponseImplCopyWith<_$PaymentVerifyResponseImpl>
      get copyWith => __$$PaymentVerifyResponseImplCopyWithImpl<
          _$PaymentVerifyResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentVerifyResponseImplToJson(
      this,
    );
  }
}

abstract class _PaymentVerifyResponse implements PaymentVerifyResponse {
  const factory _PaymentVerifyResponse(
          {@JsonKey(name: 'payment_id') required final String paymentId,
          required final String status,
          @JsonKey(name: 'course_id') final String? courseId,
          @JsonKey(name: 'paid_amount') final double? paidAmount,
          @JsonKey(name: 'paid_at') final DateTime? paidAt}) =
      _$PaymentVerifyResponseImpl;

  factory _PaymentVerifyResponse.fromJson(Map<String, dynamic> json) =
      _$PaymentVerifyResponseImpl.fromJson;

  @override
  @JsonKey(name: 'payment_id')
  String get paymentId;
  @override
  String get status;
  @override
  @JsonKey(name: 'course_id')
  String? get courseId;
  @override
  @JsonKey(name: 'paid_amount')
  double? get paidAmount;
  @override
  @JsonKey(name: 'paid_at')
  DateTime? get paidAt;
  @override
  @JsonKey(ignore: true)
  _$$PaymentVerifyResponseImplCopyWith<_$PaymentVerifyResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
