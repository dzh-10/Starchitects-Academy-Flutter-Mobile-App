// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseCatalogHash() => r'30fd27e60de95edec89af54f308040c52ddf9134';

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

/// Fetches paginated, filtered course list
///
/// Copied from [courseCatalog].
@ProviderFor(courseCatalog)
const courseCatalogProvider = CourseCatalogFamily();

/// Fetches paginated, filtered course list
///
/// Copied from [courseCatalog].
class CourseCatalogFamily extends Family<AsyncValue<List<CourseModel>>> {
  /// Fetches paginated, filtered course list
  ///
  /// Copied from [courseCatalog].
  const CourseCatalogFamily();

  /// Fetches paginated, filtered course list
  ///
  /// Copied from [courseCatalog].
  CourseCatalogProvider call(
    CourseFilterParams params,
  ) {
    return CourseCatalogProvider(
      params,
    );
  }

  @override
  CourseCatalogProvider getProviderOverride(
    covariant CourseCatalogProvider provider,
  ) {
    return call(
      provider.params,
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
  String? get name => r'courseCatalogProvider';
}

/// Fetches paginated, filtered course list
///
/// Copied from [courseCatalog].
class CourseCatalogProvider
    extends AutoDisposeFutureProvider<List<CourseModel>> {
  /// Fetches paginated, filtered course list
  ///
  /// Copied from [courseCatalog].
  CourseCatalogProvider(
    CourseFilterParams params,
  ) : this._internal(
          (ref) => courseCatalog(
            ref as CourseCatalogRef,
            params,
          ),
          from: courseCatalogProvider,
          name: r'courseCatalogProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseCatalogHash,
          dependencies: CourseCatalogFamily._dependencies,
          allTransitiveDependencies:
              CourseCatalogFamily._allTransitiveDependencies,
          params: params,
        );

  CourseCatalogProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final CourseFilterParams params;

  @override
  Override overrideWith(
    FutureOr<List<CourseModel>> Function(CourseCatalogRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseCatalogProvider._internal(
        (ref) => create(ref as CourseCatalogRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CourseModel>> createElement() {
    return _CourseCatalogProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseCatalogProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CourseCatalogRef on AutoDisposeFutureProviderRef<List<CourseModel>> {
  /// The parameter `params` of this provider.
  CourseFilterParams get params;
}

class _CourseCatalogProviderElement
    extends AutoDisposeFutureProviderElement<List<CourseModel>>
    with CourseCatalogRef {
  _CourseCatalogProviderElement(super.provider);

  @override
  CourseFilterParams get params => (origin as CourseCatalogProvider).params;
}

String _$courseDetailHash() => r'e486fcddd3f19d5aa9c9b2016ffb5d56cbdc8c17';

/// Fetches full course detail by ID
///
/// Copied from [courseDetail].
@ProviderFor(courseDetail)
const courseDetailProvider = CourseDetailFamily();

/// Fetches full course detail by ID
///
/// Copied from [courseDetail].
class CourseDetailFamily extends Family<AsyncValue<CourseModel>> {
  /// Fetches full course detail by ID
  ///
  /// Copied from [courseDetail].
  const CourseDetailFamily();

  /// Fetches full course detail by ID
  ///
  /// Copied from [courseDetail].
  CourseDetailProvider call(
    String courseId,
  ) {
    return CourseDetailProvider(
      courseId,
    );
  }

  @override
  CourseDetailProvider getProviderOverride(
    covariant CourseDetailProvider provider,
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
  String? get name => r'courseDetailProvider';
}

/// Fetches full course detail by ID
///
/// Copied from [courseDetail].
class CourseDetailProvider extends AutoDisposeFutureProvider<CourseModel> {
  /// Fetches full course detail by ID
  ///
  /// Copied from [courseDetail].
  CourseDetailProvider(
    String courseId,
  ) : this._internal(
          (ref) => courseDetail(
            ref as CourseDetailRef,
            courseId,
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
          courseId: courseId,
        );

  CourseDetailProvider._internal(
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
        courseId: courseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CourseModel> createElement() {
    return _CourseDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseDetailProvider && other.courseId == courseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CourseDetailRef on AutoDisposeFutureProviderRef<CourseModel> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseDetailProviderElement
    extends AutoDisposeFutureProviderElement<CourseModel> with CourseDetailRef {
  _CourseDetailProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseDetailProvider).courseId;
}

String _$courseLessonsHash() => r'51185fa75b832a44c20d47b6a55471a1ff66ced3';

/// Fetches all lessons for a course
///
/// Copied from [courseLessons].
@ProviderFor(courseLessons)
const courseLessonsProvider = CourseLessonsFamily();

/// Fetches all lessons for a course
///
/// Copied from [courseLessons].
class CourseLessonsFamily extends Family<AsyncValue<List<LessonModel>>> {
  /// Fetches all lessons for a course
  ///
  /// Copied from [courseLessons].
  const CourseLessonsFamily();

  /// Fetches all lessons for a course
  ///
  /// Copied from [courseLessons].
  CourseLessonsProvider call(
    String courseId,
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

/// Fetches all lessons for a course
///
/// Copied from [courseLessons].
class CourseLessonsProvider
    extends AutoDisposeFutureProvider<List<LessonModel>> {
  /// Fetches all lessons for a course
  ///
  /// Copied from [courseLessons].
  CourseLessonsProvider(
    String courseId,
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

  final String courseId;

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
        courseId: courseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<LessonModel>> createElement() {
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

mixin CourseLessonsRef on AutoDisposeFutureProviderRef<List<LessonModel>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseLessonsProviderElement
    extends AutoDisposeFutureProviderElement<List<LessonModel>>
    with CourseLessonsRef {
  _CourseLessonsProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseLessonsProvider).courseId;
}

String _$courseReviewsHash() => r'eb40658a4b592ec801ec0c63f860e9adcb392a85';

/// Fetches reviews for a course
///
/// Copied from [courseReviews].
@ProviderFor(courseReviews)
const courseReviewsProvider = CourseReviewsFamily();

/// Fetches reviews for a course
///
/// Copied from [courseReviews].
class CourseReviewsFamily extends Family<AsyncValue<List<ReviewModel>>> {
  /// Fetches reviews for a course
  ///
  /// Copied from [courseReviews].
  const CourseReviewsFamily();

  /// Fetches reviews for a course
  ///
  /// Copied from [courseReviews].
  CourseReviewsProvider call(
    String courseId,
  ) {
    return CourseReviewsProvider(
      courseId,
    );
  }

  @override
  CourseReviewsProvider getProviderOverride(
    covariant CourseReviewsProvider provider,
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
  String? get name => r'courseReviewsProvider';
}

/// Fetches reviews for a course
///
/// Copied from [courseReviews].
class CourseReviewsProvider
    extends AutoDisposeFutureProvider<List<ReviewModel>> {
  /// Fetches reviews for a course
  ///
  /// Copied from [courseReviews].
  CourseReviewsProvider(
    String courseId,
  ) : this._internal(
          (ref) => courseReviews(
            ref as CourseReviewsRef,
            courseId,
          ),
          from: courseReviewsProvider,
          name: r'courseReviewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseReviewsHash,
          dependencies: CourseReviewsFamily._dependencies,
          allTransitiveDependencies:
              CourseReviewsFamily._allTransitiveDependencies,
          courseId: courseId,
        );

  CourseReviewsProvider._internal(
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
    FutureOr<List<ReviewModel>> Function(CourseReviewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseReviewsProvider._internal(
        (ref) => create(ref as CourseReviewsRef),
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
  AutoDisposeFutureProviderElement<List<ReviewModel>> createElement() {
    return _CourseReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseReviewsProvider && other.courseId == courseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CourseReviewsRef on AutoDisposeFutureProviderRef<List<ReviewModel>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseReviewsProviderElement
    extends AutoDisposeFutureProviderElement<List<ReviewModel>>
    with CourseReviewsRef {
  _CourseReviewsProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseReviewsProvider).courseId;
}

String _$selectedCategoryHash() => r'562797e44b9619298f8a1b5b01d835f1b7982110';

/// See also [SelectedCategory].
@ProviderFor(SelectedCategory)
final selectedCategoryProvider =
    AutoDisposeNotifierProvider<SelectedCategory, String?>.internal(
  SelectedCategory.new,
  name: r'selectedCategoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedCategoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedCategory = AutoDisposeNotifier<String?>;
String _$searchQueryHash() => r'3c36752ee11b18a9f1e545eb1a7209a7222d91c9';

/// Current search query text
///
/// Copied from [SearchQuery].
@ProviderFor(SearchQuery)
final searchQueryProvider =
    AutoDisposeNotifierProvider<SearchQuery, String>.internal(
  SearchQuery.new,
  name: r'searchQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$searchQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchQuery = AutoDisposeNotifier<String>;
String _$enrollCourseHash() => r'f767c7cc7ab369fde2a9642744fa01f253ffb603';

/// Enroll action notifier
///
/// Copied from [EnrollCourse].
@ProviderFor(EnrollCourse)
final enrollCourseProvider =
    AutoDisposeAsyncNotifierProvider<EnrollCourse, void>.internal(
  EnrollCourse.new,
  name: r'enrollCourseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$enrollCourseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EnrollCourse = AutoDisposeAsyncNotifier<void>;
String _$lessonProgressHash() => r'07de75e11ac63a21440cd86e2052ddccbc42bba4';

/// Lesson progress update notifier
///
/// Copied from [LessonProgress].
@ProviderFor(LessonProgress)
final lessonProgressProvider =
    AutoDisposeAsyncNotifierProvider<LessonProgress, void>.internal(
  LessonProgress.new,
  name: r'lessonProgressProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lessonProgressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LessonProgress = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
