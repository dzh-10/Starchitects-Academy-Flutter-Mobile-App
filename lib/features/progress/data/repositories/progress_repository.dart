import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/core/api/api_client.dart';
import 'package:starchitects_app/core/api/api_endpoints.dart';
import 'package:starchitects_app/features/progress/data/models/progress_model.dart';

part 'progress_repository.g.dart';

class ProgressRepository {
  final Dio _apiClient;

  ProgressRepository(this._apiClient);

  /// Fetch overall student progress across all courses.
  Future<OverallProgress> getOverallProgress() async {
    final response = await _apiClient.get(ApiEndpoints.studentProgress);
    return OverallProgress.fromJson(response.data as Map<String, dynamic>);
  }

  /// Fetch detailed progress for a specific course.
  Future<CourseProgressItem> getCourseProgress(String courseId) async {
    final response = await _apiClient.get(
      ApiEndpoints.courseProgress(courseId),
    );
    return CourseProgressItem.fromJson(response.data as Map<String, dynamic>);
  }
}

@riverpod
ProgressRepository progressRepository(Ref ref) {
  final Dio = ref.read(apiClientProvider);
  return ProgressRepository(Dio);
}
