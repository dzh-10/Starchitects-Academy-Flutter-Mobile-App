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

    final raw = response.data;
    final list = raw is List
        ? raw
        : (raw is Map && raw['data'] is List)
            ? raw['data'] as List<dynamic>
            : <dynamic>[];
    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => CourseModel.fromJson(e))
        .toList();
  }

  Future<CourseModel> getCourseDetail(String id) async {
    final response = await _apiClient.get(ApiEndpoints.courseDetail(id));
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return CourseModel.fromJson(data);
    }
    throw Exception('Invalid response format');
  }

  Future<List<LessonModel>> getCourseLessons(String courseId) async {
    final response = await _apiClient.get(ApiEndpoints.courseLessons(courseId));
    final raw = response.data;
    final list = raw is List
        ? raw
        : (raw is Map && raw['data'] is List)
            ? raw['data'] as List<dynamic>
            : <dynamic>[];
    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => LessonModel.fromJson(e))
        .toList();
  }

  Future<void> enrollCourse(String courseId) async {
    await _apiClient.post(ApiEndpoints.enrollCourse(courseId));
  }

  Future<String> getLessonVideo(String lessonId) async {
    final response =
        await _apiClient.get(ApiEndpoints.lessonVideo(lessonId));
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return data['url'] as String? ?? '';
    }
    return '';
  }

  Future<void> updateLessonProgress(
      String lessonId, double progressPercent) async {
    await _apiClient.post(
      ApiEndpoints.lessonProgress(lessonId),
      data: {'progress_percent': progressPercent},
    );
  }

  Future<List<ReviewModel>> getCourseReviews(String courseId) async {
    final response = await _apiClient.get(ApiEndpoints.courseReviews(courseId));
    final raw = response.data;
    final list = raw is List
        ? raw
        : (raw is Map && raw['data'] is List)
            ? raw['data'] as List<dynamic>
            : <dynamic>[];
    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => ReviewModel.fromJson(e))
        .toList();
  }
}

@riverpod
CourseRepository courseRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return CourseRepository(apiClient);
}
