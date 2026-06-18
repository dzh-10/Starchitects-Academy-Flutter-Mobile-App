// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dashboardStatsHash() => r'2b96f3936e61c1bc6a896705928e7ab3a86aa270';

/// Provides dashboard statistics (enrolled courses, completed lessons, certificates)
///
/// Copied from [dashboardStats].
@ProviderFor(dashboardStats)
final dashboardStatsProvider =
    AutoDisposeFutureProvider<DashboardStats>.internal(
  dashboardStats,
  name: r'dashboardStatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DashboardStatsRef = AutoDisposeFutureProviderRef<DashboardStats>;
String _$continueLearningHash() => r'1c59c8865bd28c56792c250ae3be4e4b59dcd491';

/// Provides the list of courses the student should continue learning
///
/// Copied from [continueLearning].
@ProviderFor(continueLearning)
final continueLearningProvider =
    AutoDisposeFutureProvider<List<ContinueLearningItem>>.internal(
  continueLearning,
  name: r'continueLearningProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$continueLearningHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ContinueLearningRef
    = AutoDisposeFutureProviderRef<List<ContinueLearningItem>>;
String _$featuredCoursesHash() => r'f2a2f14ddee0b4e385ace355da5939adf33c04ce';

/// Provides featured courses for the home carousel
///
/// Copied from [featuredCourses].
@ProviderFor(featuredCourses)
final featuredCoursesProvider =
    AutoDisposeFutureProvider<List<FeaturedCourse>>.internal(
  featuredCourses,
  name: r'featuredCoursesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$featuredCoursesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FeaturedCoursesRef = AutoDisposeFutureProviderRef<List<FeaturedCourse>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
