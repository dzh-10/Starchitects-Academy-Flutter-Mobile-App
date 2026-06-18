// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardStatsImpl _$$DashboardStatsImplFromJson(Map<String, dynamic> json) =>
    _$DashboardStatsImpl(
      enrolledCourses: (json['enrolled_courses'] as num?)?.toInt() ?? 0,
      completedLessons: (json['completed_lessons'] as num?)?.toInt() ?? 0,
      certificatesEarned: (json['certificates_earned'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DashboardStatsImplToJson(
        _$DashboardStatsImpl instance) =>
    <String, dynamic>{
      'enrolled_courses': instance.enrolledCourses,
      'completed_lessons': instance.completedLessons,
      'certificates_earned': instance.certificatesEarned,
    };

_$ContinueLearningItemImpl _$$ContinueLearningItemImplFromJson(
        Map<String, dynamic> json) =>
    _$ContinueLearningItemImpl(
      courseId: json['course_id'] as String,
      courseTitle: json['course_title'] as String,
      courseThumbnail: json['course_thumbnail'] as String? ?? '',
      lastLessonTitle: json['last_lesson_title'] as String? ?? '',
      progressPercent: (json['progress_percent'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$ContinueLearningItemImplToJson(
        _$ContinueLearningItemImpl instance) =>
    <String, dynamic>{
      'course_id': instance.courseId,
      'course_title': instance.courseTitle,
      'course_thumbnail': instance.courseThumbnail,
      'last_lesson_title': instance.lastLessonTitle,
      'progress_percent': instance.progressPercent,
    };

_$FeaturedCourseImpl _$$FeaturedCourseImplFromJson(Map<String, dynamic> json) =>
    _$FeaturedCourseImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String? ?? '',
      instructorName: json['instructor_name'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      studentsCount: (json['students_count'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toDouble(),
      isFree: json['is_free'] as bool? ?? false,
      category: json['category'] as String? ?? '',
    );

Map<String, dynamic> _$$FeaturedCourseImplToJson(
        _$FeaturedCourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'instructor_name': instance.instructorName,
      'rating': instance.rating,
      'students_count': instance.studentsCount,
      'price': instance.price,
      'is_free': instance.isFree,
      'category': instance.category,
    };
