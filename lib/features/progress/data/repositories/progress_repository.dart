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

  Future<OverallProgress> getOverallProgress() async {
    final response = await _apiClient.get(ApiEndpoints.studentProgress);
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return OverallProgress.fromJson(data);
    }
    throw Exception('Invalid response format');
  }

  Future<CourseProgressItem> getCourseProgress(String courseId) async {
    final response = await _apiClient.get(
      ApiEndpoints.courseProgress(courseId),
    );
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return CourseProgressItem.fromJson(data);
    }
    throw Exception('Invalid response format');
  }
}

@riverpod
ProgressRepository progressRepository(Ref ref) {
  final Dio = ref.read(apiClientProvider);
  return ProgressRepository(Dio);
}
