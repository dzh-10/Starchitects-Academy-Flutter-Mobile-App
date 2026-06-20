import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/core/api/api_client.dart';
import 'package:starchitects_app/core/api/api_endpoints.dart';
import 'package:starchitects_app/features/profile/data/models/notification_model.dart';

part 'profile_repository.g.dart';

class ProfileRepository {
  final Dio _apiClient;

  ProfileRepository({required Dio Dio}) : _apiClient = Dio;

  Future<List<NotificationModel>> getNotifications() async {
    final response = await _apiClient.get(ApiEndpoints.notifications);
    final data = response.data;

    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map((e) => NotificationModel.fromJson(e))
          .toList();
    }

    if (data is Map<String, dynamic> && data.containsKey('data')) {
      final list = data['data'] as List;
      return list
          .whereType<Map<String, dynamic>>()
          .map((e) => NotificationModel.fromJson(e))
          .toList();
    }

    return [];
  }

  Future<void> markNotificationRead(String id) async {
    await _apiClient.put(ApiEndpoints.markNotificationRead(id));
  }

  Future<void> markAllRead() async {
    await _apiClient.put(ApiEndpoints.markAllNotificationsRead);
  }

  Future<void> registerFcmToken(String token) async {
    await _apiClient.post(
      ApiEndpoints.registerFcmToken,
      data: {'token': token},
    );
  }
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(
    Dio: ref.read(apiClientProvider),
  );
}
