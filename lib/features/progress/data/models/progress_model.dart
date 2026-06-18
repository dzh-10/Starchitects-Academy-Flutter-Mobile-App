import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_model.freezed.dart';
part 'progress_model.g.dart';

/// Overall student progress across all courses.
@freezed
abstract class OverallProgress with _$OverallProgress {
  const factory OverallProgress({
    @JsonKey(name: 'total_courses') required int totalCourses,
    @JsonKey(name: 'completed_courses') required int completedCourses,
    @JsonKey(name: 'total_lessons') required int totalLessons,
    @JsonKey(name: 'completed_lessons') required int completedLessons,
    @JsonKey(name: 'overall_percent') required double overallPercent,
    @JsonKey(name: 'weekly_hours') @Default([]) List<double> weeklyHours,
    @JsonKey(name: 'course_progress')
    @Default([])
    List<CourseProgressItem> courseProgress,
  }) = _OverallProgress;

  factory OverallProgress.fromJson(Map<String, dynamic> json) =>
      _$OverallProgressFromJson(json);
}

/// Progress for an individual course.
@freezed
abstract class CourseProgressItem with _$CourseProgressItem {
  const factory CourseProgressItem({
    @JsonKey(name: 'course_id') required String courseId,
    @JsonKey(name: 'course_title') required String courseTitle,
    @JsonKey(name: 'course_thumbnail') String? courseThumbnail,
    @JsonKey(name: 'completed_lessons') required int completedLessons,
    @JsonKey(name: 'total_lessons') required int totalLessons,
    @JsonKey(name: 'progress_percent') required double progressPercent,
    @JsonKey(name: 'last_accessed') DateTime? lastAccessed,
  }) = _CourseProgressItem;

  factory CourseProgressItem.fromJson(Map<String, dynamic> json) =>
      _$CourseProgressItemFromJson(json);
}
