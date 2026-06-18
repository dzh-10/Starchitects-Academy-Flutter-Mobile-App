import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_model.freezed.dart';
part 'dashboard_model.g.dart';

/// Dashboard statistics for the student's home screen
@freezed
abstract class DashboardStats with _$DashboardStats {
  const factory DashboardStats({
    @JsonKey(name: 'enrolled_courses') @Default(0) int enrolledCourses,
    @JsonKey(name: 'completed_lessons') @Default(0) int completedLessons,
    @JsonKey(name: 'certificates_earned') @Default(0) int certificatesEarned,
  }) = _DashboardStats;

  factory DashboardStats.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsFromJson(json);
}

/// A course the student was recently learning, shown in "Continue Learning"
@freezed
abstract class ContinueLearningItem with _$ContinueLearningItem {
  const factory ContinueLearningItem({
    @JsonKey(name: 'course_id') required String courseId,
    @JsonKey(name: 'course_title') required String courseTitle,
    @JsonKey(name: 'course_thumbnail') @Default('') String courseThumbnail,
    @JsonKey(name: 'last_lesson_title') @Default('') String lastLessonTitle,
    @JsonKey(name: 'progress_percent') @Default(0.0) double progressPercent,
  }) = _ContinueLearningItem;

  factory ContinueLearningItem.fromJson(Map<String, dynamic> json) =>
      _$ContinueLearningItemFromJson(json);
}

/// A featured/promoted course shown on the home carousel
@freezed
abstract class FeaturedCourse with _$FeaturedCourse {
  const factory FeaturedCourse({
    required String id,
    required String title,
    @Default('') String thumbnail,
    @JsonKey(name: 'instructor_name') @Default('') String instructorName,
    @Default(0.0) double rating,
    @JsonKey(name: 'students_count') @Default(0) int studentsCount,
    double? price,
    @JsonKey(name: 'is_free') @Default(false) bool isFree,
    @Default('') String category,
  }) = _FeaturedCourse;

  factory FeaturedCourse.fromJson(Map<String, dynamic> json) =>
      _$FeaturedCourseFromJson(json);
}
