// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$paymentVerifyHash() => r'5c1d7e7ba0bf00605837e03bfa8ebf974a6d2010';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Polls the payment verification endpoint for a given paymentId.
/// Used to check if the payment was successful after the user
/// completes the Chargily checkout flow.
///
/// Copied from [paymentVerify].
@ProviderFor(paymentVerify)
const paymentVerifyProvider = PaymentVerifyFamily();

/// Polls the payment verification endpoint for a given paymentId.
/// Used to check if the payment was successful after the user
/// completes the Chargily checkout flow.
///
/// Copied from [paymentVerify].
class PaymentVerifyFamily extends Family<AsyncValue<PaymentVerifyResponse>> {
  /// Polls the payment verification endpoint for a given paymentId.
  /// Used to check if the payment was successful after the user
  /// completes the Chargily checkout flow.
  ///
  /// Copied from [paymentVerify].
  const PaymentVerifyFamily();

  /// Polls the payment verification endpoint for a given paymentId.
  /// Used to check if the payment was successful after the user
  /// completes the Chargily checkout flow.
  ///
  /// Copied from [paymentVerify].
  PaymentVerifyProvider call(
    String paymentId,
  ) {
    return PaymentVerifyProvider(
      paymentId,
    );
  }

  @override
  PaymentVerifyProvider getProviderOverride(
    covariant PaymentVerifyProvider provider,
  ) {
    return call(
      provider.paymentId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'paymentVerifyProvider';
}

/// Polls the payment verification endpoint for a given paymentId.
/// Used to check if the payment was successful after the user
/// completes the Chargily checkout flow.
///
/// Copied from [paymentVerify].
class PaymentVerifyProvider
    extends AutoDisposeFutureProvider<PaymentVerifyResponse> {
  /// Polls the payment verification endpoint for a given paymentId.
  /// Used to check if the payment was successful after the user
  /// completes the Chargily checkout flow.
  ///
  /// Copied from [paymentVerify].
  PaymentVerifyProvider(
    String paymentId,
  ) : this._internal(
          (ref) => paymentVerify(
            ref as PaymentVerifyRef,
            paymentId,
          ),
          from: paymentVerifyProvider,
          name: r'paymentVerifyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$paymentVerifyHash,
          dependencies: PaymentVerifyFamily._dependencies,
          allTransitiveDependencies:
              PaymentVerifyFamily._allTransitiveDependencies,
          paymentId: paymentId,
        );

  PaymentVerifyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.paymentId,
  }) : super.internal();

  final String paymentId;

  @override
  Override overrideWith(
    FutureOr<PaymentVerifyResponse> Function(PaymentVerifyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PaymentVerifyProvider._internal(
        (ref) => create(ref as PaymentVerifyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        paymentId: paymentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PaymentVerifyResponse> createElement() {
    return _PaymentVerifyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentVerifyProvider && other.paymentId == paymentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, paymentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PaymentVerifyRef on AutoDisposeFutureProviderRef<PaymentVerifyResponse> {
  /// The parameter `paymentId` of this provider.
  String get paymentId;
}

class _PaymentVerifyProviderElement
    extends AutoDisposeFutureProviderElement<PaymentVerifyResponse>
    with PaymentVerifyRef {
  _PaymentVerifyProviderElement(super.provider);

  @override
  String get paymentId => (origin as PaymentVerifyProvider).paymentId;
}

String _$paymentInitHash() => r'd5c5fcb99e6cf21336aced392c4122920c88440f';

/// Manages payment initiation state.
/// Call [initiatePayment] with a courseId to start the payment flow.
///
/// Copied from [PaymentInit].
@ProviderFor(PaymentInit)
final paymentInitProvider = AutoDisposeAsyncNotifierProvider<PaymentInit,
    PaymentInitResponse?>.internal(
  PaymentInit.new,
  name: r'paymentInitProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$paymentInitHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PaymentInit = AutoDisposeAsyncNotifier<PaymentInitResponse?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
