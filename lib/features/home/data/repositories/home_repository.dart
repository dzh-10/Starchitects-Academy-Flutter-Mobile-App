import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/core/api/api_client.dart';
import 'package:starchitects_app/core/api/api_endpoints.dart';
import 'package:starchitects_app/features/home/data/models/dashboard_model.dart';

part 'home_repository.g.dart';

class HomeRepository {
  final Dio _apiClient;

  HomeRepository(this._apiClient);

  /// Fetch dashboard statistics for the current student
  Future<DashboardStats> getDashboardStats() async {
    final response = await _apiClient.get(ApiEndpoints.studentDashboard);
    return DashboardStats.fromJson(response.data as Map<String, dynamic>);
  }

  /// Fetch the list of courses the student should continue learning
  Future<List<ContinueLearningItem>> getContinueLearning() async {
    final response = await _apiClient.get(ApiEndpoints.continueLearning);
    final list = response.data as List<dynamic>;
    return list
        .map((e) =>
            ContinueLearningItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Fetch featured/promoted courses for the home carousel
  Future<List<FeaturedCourse>> getFeaturedCourses() async {
    final response = await _apiClient.get(ApiEndpoints.featuredCourses);
    final list = response.data as List<dynamic>;
    return list
        .map((e) => FeaturedCourse.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
HomeRepository homeRepository(Ref ref) {
  final Dio = ref.read(apiClientProvider);
  return HomeRepository(Dio);
}
