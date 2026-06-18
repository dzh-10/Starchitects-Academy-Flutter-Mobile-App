// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$subscriptionPlansHash() => r'bcbc7b005bec31335a9671cd3db6c51825e260a8';

/// See also [subscriptionPlans].
@ProviderFor(subscriptionPlans)
final subscriptionPlansProvider = AutoDisposeFutureProvider<dynamic>.internal(
  subscriptionPlans,
  name: r'subscriptionPlansProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$subscriptionPlansHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SubscriptionPlansRef = AutoDisposeFutureProviderRef<dynamic>;
String _$checkoutNotifierHash() => r'2dd5abb9b344d6443886321827bbb38b2ec055e1';

/// See also [CheckoutNotifier].
@ProviderFor(CheckoutNotifier)
final checkoutNotifierProvider =
    AutoDisposeNotifierProvider<CheckoutNotifier, AsyncValue<String?>>.internal(
  CheckoutNotifier.new,
  name: r'checkoutNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$checkoutNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CheckoutNotifier = AutoDisposeNotifier<AsyncValue<String?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
