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

  /// Fetch list of live sessions with optional filters.
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

    final list = response.data as List<dynamic>;
    return list
        .map((e) => SessionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Request a LiveKit token to join a session room.
  Future<LiveKitTokenResponse> getSessionToken(String sessionId) async {
    final response = await _apiClient.post(
      ApiEndpoints.sessionToken(sessionId),
    );

    return LiveKitTokenResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}

@riverpod
LiveSessionRepository liveSessionRepository(Ref ref) {
  final Dio = ref.read(apiClientProvider);
  return LiveSessionRepository(Dio);
}
