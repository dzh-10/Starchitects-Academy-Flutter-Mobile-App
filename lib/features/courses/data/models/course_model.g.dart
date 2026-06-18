// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] as String?,
      instructorName: json['instructor_name'] as String,
      isFree: json['is_free'] as bool,
      price: (json['price'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      enrolledCount: (json['enrolled_count'] as num?)?.toInt(),
      lessonsCount: (json['lessons_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'instructor_name': instance.instructorName,
      'is_free': instance.isFree,
      'price': instance.price,
      'rating': instance.rating,
      'enrolled_count': instance.enrolledCount,
      'lessons_count': instance.lessonsCount,
    };

_$LessonImpl _$$LessonImplFromJson(Map<String, dynamic> json) => _$LessonImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      videoUrl: json['video_url'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      isFree: json['is_free'] as bool?,
      isCompleted: json['is_completed'] as bool?,
    );

Map<String, dynamic> _$$LessonImplToJson(_$LessonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'video_url': instance.videoUrl,
      'duration': instance.duration,
      'is_free': instance.isFree,
      'is_completed': instance.isCompleted,
    };

_$SectionImpl _$$SectionImplFromJson(Map<String, dynamic> json) =>
    _$SectionImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SectionImplToJson(_$SectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'lessons': instance.lessons,
    };
