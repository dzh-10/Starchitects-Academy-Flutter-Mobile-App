import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

@freezed
class Course with _$Course {
  factory Course({
    required int id,
    required String title,
    required String slug,
    String? description,
    String? thumbnail,
    @JsonKey(name: 'instructor_name') required String instructorName,
    @JsonKey(name: 'is_free') required bool isFree,
    double? price,
    double? rating,
    @JsonKey(name: 'enrolled_count') int? enrolledCount,
    @JsonKey(name: 'lessons_count') int? lessonsCount,
  }) = _Course;
  
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}

@freezed
class Lesson with _$Lesson {
  factory Lesson({
    required int id,
    required String title,
    String? description,
    @JsonKey(name: 'video_url') String? videoUrl,
    int? duration, // in seconds
    @JsonKey(name: 'is_free') bool? isFree,
    @JsonKey(name: 'is_completed') bool? isCompleted,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}

@freezed
class Section with _$Section {
  factory Section({
    required int id,
    required String title,
    required List<Lesson> lessons,
  }) = _Section;

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);
}
