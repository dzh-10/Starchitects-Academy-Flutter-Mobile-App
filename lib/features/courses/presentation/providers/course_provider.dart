import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/features/courses/data/models/course_model.dart';
import 'package:starchitects_app/features/courses/data/repositories/course_repository.dart';

part 'course_provider.g.dart';

// ─── Filter State Providers ──────────────────────────────────────────

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  String? build() => null;
  void setCategory(String? category) => state = category;
}

/// Current search query text
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';
  void setQuery(String query) => state = query;
}

// ─── Data Providers ──────────────────────────────────────────────────

/// Course catalog filter parameters
class CourseFilterParams {
  final String? category;
  final String? search;
  final int page;

  const CourseFilterParams({
    this.category,
    this.search,
    this.page = 1,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseFilterParams &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          search == other.search &&
          page == other.page;

  @override
  int get hashCode => Object.hash(category, search, page);
}

/// Fetches paginated, filtered course list
@riverpod
Future<List<CourseModel>> courseCatalog(
  Ref ref,
  CourseFilterParams params,
) async {
  final repository = ref.read(courseRepositoryProvider);
  return repository.getCourses(
    category: params.category,
    search: params.search,
    page: params.page,
  );
}

/// Fetches full course detail by ID
@riverpod
Future<CourseModel> courseDetail(Ref ref, String courseId) async {
  final repository = ref.read(courseRepositoryProvider);
  return repository.getCourseDetail(courseId);
}

/// Fetches all lessons for a course
@riverpod
Future<List<LessonModel>> courseLessons(
    Ref ref, String courseId) async {
  final repository = ref.read(courseRepositoryProvider);
  return repository.getCourseLessons(courseId);
}

/// Fetches reviews for a course
@riverpod
Future<List<ReviewModel>> courseReviews(
    Ref ref, String courseId) async {
  final repository = ref.read(courseRepositoryProvider);
  return repository.getCourseReviews(courseId);
}

/// Enroll action notifier
@riverpod
class EnrollCourse extends _$EnrollCourse {
  @override
  FutureOr<void> build() {}

  Future<void> enroll(String courseId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(courseRepositoryProvider);
      await repository.enrollCourse(courseId);
      // Invalidate detail to refresh enrollment status
      ref.invalidate(courseDetailProvider(courseId));
    });
  }
}

/// Lesson progress update notifier
@riverpod
class LessonProgress extends _$LessonProgress {
  @override
  FutureOr<void> build() {}

  Future<void> updateProgress(String lessonId, double progressPercent) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(courseRepositoryProvider);
      await repository.updateLessonProgress(lessonId, progressPercent);
    });
  }
}
