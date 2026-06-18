// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OverallProgressImpl _$$OverallProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$OverallProgressImpl(
      totalCourses: (json['total_courses'] as num).toInt(),
      completedCourses: (json['completed_courses'] as num).toInt(),
      totalLessons: (json['total_lessons'] as num).toInt(),
      completedLessons: (json['completed_lessons'] as num).toInt(),
      overallPercent: (json['overall_percent'] as num).toDouble(),
      weeklyHours: (json['weekly_hours'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
      courseProgress: (json['course_progress'] as List<dynamic>?)
              ?.map(
                  (e) => CourseProgressItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$OverallProgressImplToJson(
        _$OverallProgressImpl instance) =>
    <String, dynamic>{
      'total_courses': instance.totalCourses,
      'completed_courses': instance.completedCourses,
      'total_lessons': instance.totalLessons,
      'completed_lessons': instance.completedLessons,
      'overall_percent': instance.overallPercent,
      'weekly_hours': instance.weeklyHours,
      'course_progress': instance.courseProgress,
    };

_$CourseProgressItemImpl _$$CourseProgressItemImplFromJson(
        Map<String, dynamic> json) =>
    _$CourseProgressItemImpl(
      courseId: json['course_id'] as String,
      courseTitle: json['course_title'] as String,
      courseThumbnail: json['course_thumbnail'] as String?,
      completedLessons: (json['completed_lessons'] as num).toInt(),
      totalLessons: (json['total_lessons'] as num).toInt(),
      progressPercent: (json['progress_percent'] as num).toDouble(),
      lastAccessed: json['last_accessed'] == null
          ? null
          : DateTime.parse(json['last_accessed'] as String),
    );

Map<String, dynamic> _$$CourseProgressItemImplToJson(
        _$CourseProgressItemImpl instance) =>
    <String, dynamic>{
      'course_id': instance.courseId,
      'course_title': instance.courseTitle,
      'course_thumbnail': instance.courseThumbnail,
      'completed_lessons': instance.completedLessons,
      'total_lessons': instance.totalLessons,
      'progress_percent': instance.progressPercent,
      'last_accessed': instance.lastAccessed?.toIso8601String(),
    };
