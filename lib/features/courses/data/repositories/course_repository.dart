import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/core/api/api_client.dart';
import 'package:starchitects_app/core/api/api_endpoints.dart';
import 'package:starchitects_app/features/courses/data/models/course_model.dart';

part 'course_repository.g.dart';

class CourseRepository {
  final Dio _apiClient;

  CourseRepository(this._apiClient);

  /// Fetch paginated list of courses with optional filters
  Future<List<CourseModel>> getCourses({
    String? category,
    String? search,
    int page = 1,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
    };
    if (category != null && category.isNotEmpty) {
      queryParams['category'] = category;
    }
    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    final response = await _apiClient.get(
      ApiEndpoints.courses,
      queryParameters: queryParams,
    );

    final list = response.data as List<dynamic>;
    return list
        .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Fetch detailed information for a single course
  Future<CourseModel> getCourseDetail(String id) async {
    final response = await _apiClient.get('${ApiEndpoints.courses}/$id');
    return CourseModel.fromJson(response.data as Map<String, dynamic>);
  }

  /// Fetch all lessons for a course
  Future<List<LessonModel>> getCourseLessons(String courseId) async {
    final response =
        await _apiClient.get('${ApiEndpoints.courses}/$courseId/lessons');
    final list = response.data as List<dynamic>;
    return list
        .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Enroll the current student in a course
  Future<void> enrollCourse(String courseId) async {
    await _apiClient.post('${ApiEndpoints.courses}/$courseId/enroll');
  }

  /// Get the video URL for a specific lesson
  Future<String> getLessonVideo(String lessonId) async {
    final response =
        await _apiClient.get(ApiEndpoints.lessonVideo(lessonId));
    return (response.data as Map<String, dynamic>)['url'] as String;
  }

  /// Update lesson watch progress
  Future<void> updateLessonProgress(
      String lessonId, double progressPercent) async {
    await _apiClient.post(
      ApiEndpoints.lessonProgress(lessonId),
      data: {'progress_percent': progressPercent},
    );
  }

  /// Fetch reviews for a course
  Future<List<ReviewModel>> getCourseReviews(String courseId) async {
    final response =
        await _apiClient.get('${ApiEndpoints.courses}/$courseId/reviews');
    final list = response.data as List<dynamic>;
    return list
        .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
CourseRepository courseRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return CourseRepository(apiClient);
}
