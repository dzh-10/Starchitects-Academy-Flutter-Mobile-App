import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/core/api/api_client.dart';
import 'package:starchitects_app/core/api/api_endpoints.dart';
import 'package:starchitects_app/features/live_sessions/data/models/session_model.dart';

part 'live_session_repository.g.dart';

class LiveSessionRepository {
  final Dio _apiClient;

  LiveSessionRepository(this._apiClient);

  Future<List<SessionModel>> getSessions({
    String? courseId,
    String? status,
  }) async {
    final queryParams = <String, dynamic>{};
    if (courseId != null && courseId.isNotEmpty) {
      queryParams['course_id'] = courseId;
    }
    if (status != null && status.isNotEmpty) {
      queryParams['status'] = status;
    }

    final response = await _apiClient.get(
      ApiEndpoints.liveSessions,
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
        .map((e) => SessionModel.fromJson(e))
        .toList();
  }

  Future<LiveKitTokenResponse> getSessionToken(String sessionId) async {
    final response = await _apiClient.post(
      ApiEndpoints.sessionToken(sessionId),
    );

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return LiveKitTokenResponse.fromJson(data);
    }
    throw Exception('Invalid response format');
  }
}

@riverpod
LiveSessionRepository liveSessionRepository(Ref ref) {
  final Dio = ref.read(apiClientProvider);
  return LiveSessionRepository(Dio);
}
