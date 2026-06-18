// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$overallProgressHash() => r'a3a80289509797aa164d8800b90cf22bf026f56a';

/// Fetches overall student progress for the dashboard.
///
/// Copied from [overallProgress].
@ProviderFor(overallProgress)
final overallProgressProvider =
    AutoDisposeFutureProvider<OverallProgress>.internal(
  overallProgress,
  name: r'overallProgressProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$overallProgressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OverallProgressRef = AutoDisposeFutureProviderRef<OverallProgress>;
String _$courseProgressHash() => r'8fae3df90211d87575d8b4cbd94c6b1ecd56bb5e';

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

/// Fetches detailed progress for a specific course.
///
/// Copied from [courseProgress].
@ProviderFor(courseProgress)
const courseProgressProvider = CourseProgressFamily();

/// Fetches detailed progress for a specific course.
///
/// Copied from [courseProgress].
class CourseProgressFamily extends Family<AsyncValue<CourseProgressItem>> {
  /// Fetches detailed progress for a specific course.
  ///
  /// Copied from [courseProgress].
  const CourseProgressFamily();

  /// Fetches detailed progress for a specific course.
  ///
  /// Copied from [courseProgress].
  CourseProgressProvider call(
    String courseId,
  ) {
    return CourseProgressProvider(
      courseId,
    );
  }

  @override
  CourseProgressProvider getProviderOverride(
    covariant CourseProgressProvider provider,
  ) {
    return call(
      provider.courseId,
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
  String? get name => r'courseProgressProvider';
}

/// Fetches detailed progress for a specific course.
///
/// Copied from [courseProgress].
class CourseProgressProvider
    extends AutoDisposeFutureProvider<CourseProgressItem> {
  /// Fetches detailed progress for a specific course.
  ///
  /// Copied from [courseProgress].
  CourseProgressProvider(
    String courseId,
  ) : this._internal(
          (ref) => courseProgress(
            ref as CourseProgressRef,
            courseId,
          ),
          from: courseProgressProvider,
          name: r'courseProgressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseProgressHash,
          dependencies: CourseProgressFamily._dependencies,
          allTransitiveDependencies:
              CourseProgressFamily._allTransitiveDependencies,
          courseId: courseId,
        );

  CourseProgressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.courseId,
  }) : super.internal();

  final String courseId;

  @override
  Override overrideWith(
    FutureOr<CourseProgressItem> Function(CourseProgressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseProgressProvider._internal(
        (ref) => create(ref as CourseProgressRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        courseId: courseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CourseProgressItem> createElement() {
    return _CourseProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseProgressProvider && other.courseId == courseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CourseProgressRef on AutoDisposeFutureProviderRef<CourseProgressItem> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseProgressProviderElement
    extends AutoDisposeFutureProviderElement<CourseProgressItem>
    with CourseProgressRef {
  _CourseProgressProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseProgressProvider).courseId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
