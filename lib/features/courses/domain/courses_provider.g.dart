// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseDetailHash() => r'94dcbc10e6c23a433698bf68c8176c219234f767';

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
class CourseDetailFamily extends Family<AsyncValue<CourseModel>> {
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
class CourseDetailProvider extends AutoDisposeFutureProvider<CourseModel> {
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
    FutureOr<CourseModel> Function(CourseDetailRef provider) create,
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
  AutoDisposeFutureProviderElement<CourseModel> createElement() {
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

mixin CourseDetailRef on AutoDisposeFutureProviderRef<CourseModel> {
  /// The parameter `slug` of this provider.
  String get slug;
}

class _CourseDetailProviderElement
    extends AutoDisposeFutureProviderElement<CourseModel> with CourseDetailRef {
  _CourseDetailProviderElement(super.provider);

  @override
  String get slug => (origin as CourseDetailProvider).slug;
}

String _$courseLessonsHash() => r'733ccbf5040dd0503a79591066bec4e23dcd5e7c';

/// See also [courseLessons].
@ProviderFor(courseLessons)
const courseLessonsProvider = CourseLessonsFamily();

/// See also [courseLessons].
class CourseLessonsFamily extends Family<AsyncValue<List<LessonModel>>> {
  /// See also [courseLessons].
  const CourseLessonsFamily();

  /// See also [courseLessons].
  CourseLessonsProvider call(
    String slug,
  ) {
    return CourseLessonsProvider(
      slug,
    );
  }

  @override
  CourseLessonsProvider getProviderOverride(
    covariant CourseLessonsProvider provider,
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
  String? get name => r'courseLessonsProvider';
}

/// See also [courseLessons].
class CourseLessonsProvider
    extends AutoDisposeFutureProvider<List<LessonModel>> {
  /// See also [courseLessons].
  CourseLessonsProvider(
    String slug,
  ) : this._internal(
          (ref) => courseLessons(
            ref as CourseLessonsRef,
            slug,
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
          slug: slug,
        );

  CourseLessonsProvider._internal(
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
    FutureOr<List<LessonModel>> Function(CourseLessonsRef provider) create,
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
        slug: slug,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<LessonModel>> createElement() {
    return _CourseLessonsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseLessonsProvider && other.slug == slug;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, slug.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CourseLessonsRef on AutoDisposeFutureProviderRef<List<LessonModel>> {
  /// The parameter `slug` of this provider.
  String get slug;
}

class _CourseLessonsProviderElement
    extends AutoDisposeFutureProviderElement<List<LessonModel>>
    with CourseLessonsRef {
  _CourseLessonsProviderElement(super.provider);

  @override
  String get slug => (origin as CourseLessonsProvider).slug;
}

String _$coursesNotifierHash() => r'd059d78b8a939d1d9e704b6683dd8bf180ed0beb';

/// See also [CoursesNotifier].
@ProviderFor(CoursesNotifier)
final coursesNotifierProvider = AutoDisposeNotifierProvider<CoursesNotifier,
    AsyncValue<List<CourseModel>>>.internal(
  CoursesNotifier.new,
  name: r'coursesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$coursesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CoursesNotifier = AutoDisposeNotifier<AsyncValue<List<CourseModel>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
