// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseDetailHash() => r'508f8d41447d628f1aa2b0d658f9acd44c91a6ed';

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

/// See also [courseDetail].
@ProviderFor(courseDetail)
const courseDetailProvider = CourseDetailFamily();

/// See also [courseDetail].
class CourseDetailFamily extends Family<AsyncValue<Course>> {
  /// See also [courseDetail].
  const CourseDetailFamily();

  /// See also [courseDetail].
  CourseDetailProvider call(
    String slug,
  ) {
    return CourseDetailProvider(
      slug,
    );
  }

  @override
  CourseDetailProvider getProviderOverride(
    covariant CourseDetailProvider provider,
  ) {
    return call(
      provider.slug,
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
  String? get name => r'courseDetailProvider';
}

/// See also [courseDetail].
class CourseDetailProvider extends AutoDisposeFutureProvider<Course> {
  /// See also [courseDetail].
  CourseDetailProvider(
    String slug,
  ) : this._internal(
          (ref) => courseDetail(
            ref as CourseDetailRef,
            slug,
          ),
          from: courseDetailProvider,
          name: r'courseDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseDetailHash,
          dependencies: CourseDetailFamily._dependencies,
          allTransitiveDependencies:
              CourseDetailFamily._allTransitiveDependencies,
          slug: slug,
        );

  CourseDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.slug,
  }) : super.internal();

  final String slug;

  @override
  Override overrideWith(
    FutureOr<Course> Function(CourseDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseDetailProvider._internal(
        (ref) => create(ref as CourseDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        slug: slug,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Course> createElement() {
    return _CourseDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseDetailProvider && other.slug == slug;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, slug.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CourseDetailRef on AutoDisposeFutureProviderRef<Course> {
  /// The parameter `slug` of this provider.
  String get slug;
}

class _CourseDetailProviderElement
    extends AutoDisposeFutureProviderElement<Course> with CourseDetailRef {
  _CourseDetailProviderElement(super.provider);

  @override
  String get slug => (origin as CourseDetailProvider).slug;
}

String _$courseLessonsHash() => r'6d9a81b481251d341b170993ee8d79abb6ba4805';

/// See also [courseLessons].
@ProviderFor(courseLessons)
const courseLessonsProvider = CourseLessonsFamily();

/// See also [courseLessons].
class CourseLessonsFamily extends Family<AsyncValue<List<Section>>> {
  /// See also [courseLessons].
  const CourseLessonsFamily();

  /// See also [courseLessons].
  CourseLessonsProvider call(
    int courseId,
  ) {
    return CourseLessonsProvider(
      courseId,
    );
  }

  @override
  CourseLessonsProvider getProviderOverride(
    covariant CourseLessonsProvider provider,
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
  String? get name => r'courseLessonsProvider';
}

/// See also [courseLessons].
class CourseLessonsProvider extends AutoDisposeFutureProvider<List<Section>> {
  /// See also [courseLessons].
  CourseLessonsProvider(
    int courseId,
  ) : this._internal(
          (ref) => courseLessons(
            ref as CourseLessonsRef,
            courseId,
          ),
          from: courseLessonsProvider,
          name: r'courseLessonsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseLessonsHash,
          dependencies: CourseLessonsFamily._dependencies,
          allTransitiveDependencies:
              CourseLessonsFamily._allTransitiveDependencies,
          courseId: courseId,
        );

  CourseLessonsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.courseId,
  }) : super.internal();

  final int courseId;

  @override
  Override overrideWith(
    FutureOr<List<Section>> Function(CourseLessonsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseLessonsProvider._internal(
        (ref) => create(ref as CourseLessonsRef),
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
  AutoDisposeFutureProviderElement<List<Section>> createElement() {
    return _CourseLessonsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseLessonsProvider && other.courseId == courseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CourseLessonsRef on AutoDisposeFutureProviderRef<List<Section>> {
  /// The parameter `courseId` of this provider.
  int get courseId;
}

class _CourseLessonsProviderElement
    extends AutoDisposeFutureProviderElement<List<Section>>
    with CourseLessonsRef {
  _CourseLessonsProviderElement(super.provider);

  @override
  int get courseId => (origin as CourseLessonsProvider).courseId;
}

String _$coursesNotifierHash() => r'b77dd7af505b48b690c09da58457d5f00b62e19b';

/// See also [CoursesNotifier].
@ProviderFor(CoursesNotifier)
final coursesNotifierProvider = AutoDisposeNotifierProvider<CoursesNotifier,
    AsyncValue<List<Course>>>.internal(
  CoursesNotifier.new,
  name: r'coursesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$coursesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CoursesNotifier = AutoDisposeNotifier<AsyncValue<List<Course>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
