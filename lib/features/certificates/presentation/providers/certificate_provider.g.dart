// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$certificatesListHash() => r'fceb362a4c30462dc6c508198f378a7805b499b3';

/// Provides the list of certificates for the current student.
/// Auto-refreshes when invalidated.
///
/// Copied from [certificatesList].
@ProviderFor(certificatesList)
final certificatesListProvider =
    AutoDisposeFutureProvider<List<CertificateModel>>.internal(
  certificatesList,
  name: r'certificatesListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$certificatesListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CertificatesListRef
    = AutoDisposeFutureProviderRef<List<CertificateModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
