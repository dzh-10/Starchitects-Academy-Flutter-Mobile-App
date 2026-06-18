import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_model.freezed.dart';
part 'session_model.g.dart';

/// Live session model representing a scheduled or active LiveKit session.
@freezed
abstract class SessionModel with _$SessionModel {
  const factory SessionModel({
    required String id,
    required String title,
    @JsonKey(name: 'course_id') required String courseId,
    @JsonKey(name: 'course_name') required String courseName,
    @JsonKey(name: 'scheduled_at') required DateTime scheduledAt,
    required String status,
    @JsonKey(name: 'instructor_name') String? instructorName,
    @JsonKey(name: 'instructor_avatar') String? instructorAvatar,
    @JsonKey(name: 'participants_count') @Default(0) int participantsCount,
    @JsonKey(name: 'duration_minutes') int? durationMinutes,
  }) = _SessionModel;

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);
}

/// Token response from the backend for joining a LiveKit room.
@freezed
abstract class LiveKitTokenResponse with _$LiveKitTokenResponse {
  const factory LiveKitTokenResponse({
    required String token,
    required String url,
    required String identity,
    @JsonKey(name: 'room_name') required String roomName,
  }) = _LiveKitTokenResponse;

  factory LiveKitTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$LiveKitTokenResponseFromJson(json);
}
