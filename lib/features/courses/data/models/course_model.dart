import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_model.freezed.dart';

@freezed
class CourseModel with _$CourseModel {
  const CourseModel._();

  const factory CourseModel({
    required int id,
    required String title,
    required String slug,
    String? description,
    String? thumbnailUrl,
    required String instructorName,
    required bool isFree,
    required int price,
    double? rating,
    int? enrolledCount,
    int? lessonsCount,
  }) = _CourseModel;

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String?,
      thumbnailUrl: json['thumbnail'] as String? ?? json['image'] as String?,
      instructorName: (json['instructor'] is Map) 
          ? (json['instructor']['name'] as String? ?? '') 
          : (json['instructor_name'] as String? ?? ''),
      isFree: json['is_free'] == true || json['is_free'] == 1,
      price: (json['price'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble(),
      enrolledCount: json['enrolled_count'] as int?,
      lessonsCount: json['lessons_count'] as int?,
    );
  }
}

@freezed
class LessonModel with _$LessonModel {
  const LessonModel._();

  const factory LessonModel({
    required int id,
    required String title,
    String? description,
    String? videoUrl,
    int? duration,
    bool? isFree,
    bool? isCompleted,
  }) = _LessonModel;

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    final rawDuration = json['duration'];
    int? parsedDuration;
    if (rawDuration is int) {
      parsedDuration = rawDuration;
    } else if (rawDuration is String) {
      parsedDuration = int.tryParse(rawDuration);
    }

    return LessonModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      videoUrl: json['video_url'] as String?,
      duration: parsedDuration,
      isFree: json['is_free'] == true || json['is_free'] == 1,
      isCompleted: json['is_completed'] == true || json['is_completed'] == 1,
    );
  }
}

@freezed
class SectionModel with _$SectionModel {
  const SectionModel._();

  const factory SectionModel({
    required int id,
    required String title,
    required List<LessonModel> lessons,
  }) = _SectionModel;

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    final lessonsRaw = json['lessons'];
    List<LessonModel> parsedLessons = [];
    if (lessonsRaw is List) {
      parsedLessons = lessonsRaw
          .whereType<Map<String, dynamic>>()
          .map((e) => LessonModel.fromJson(e))
          .toList();
    }

    return SectionModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      lessons: parsedLessons,
    );
  }
}

@freezed
class ReviewModel with _$ReviewModel {
  const ReviewModel._();

  const factory ReviewModel({
    required int id,
    required String userName,
    required double rating,
    required String comment,
    String? avatarUrl,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as int? ?? 0,
      userName: json['user_name'] as String? ?? json['user']?['name'] as String? ?? 'User',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      comment: json['comment'] as String? ?? '',
      avatarUrl: json['avatar'] as String? ?? json['user']?['avatar'] as String?,
    );
  }
}
