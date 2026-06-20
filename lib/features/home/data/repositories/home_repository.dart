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

  Future<DashboardStats> getDashboardStats() async {
    final response = await _apiClient.get(ApiEndpoints.studentDashboard);
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return DashboardStats.fromJson(data);
    }
    throw Exception('Invalid response format');
  }

  Future<List<ContinueLearningItem>> getContinueLearning() async {
    final response = await _apiClient.get(ApiEndpoints.continueLearning);
    final raw = response.data;
    final list = raw is List
        ? raw
        : (raw is Map && raw['data'] is List)
            ? raw['data'] as List<dynamic>
            : <dynamic>[];
    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => ContinueLearningItem.fromJson(e))
        .toList();
  }

  Future<List<FeaturedCourse>> getFeaturedCourses() async {
    final response = await _apiClient.get(ApiEndpoints.featuredCourses);
    final raw = response.data;
    final list = raw is List
        ? raw
        : (raw is Map && raw['data'] is List)
            ? raw['data'] as List<dynamic>
            : <dynamic>[];
    return list
        .whereType<Map<String, dynamic>>()
        .map((e) => FeaturedCourse.fromJson(e))
        .toList();
  }
}

@riverpod
HomeRepository homeRepository(Ref ref) {
  final Dio = ref.read(apiClientProvider);
  return HomeRepository(Dio);
}
