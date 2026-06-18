// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionModelImpl _$$SessionModelImplFromJson(Map<String, dynamic> json) =>
    _$SessionModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      courseId: json['course_id'] as String,
      courseName: json['course_name'] as String,
      scheduledAt: DateTime.parse(json['scheduled_at'] as String),
      status: json['status'] as String,
      instructorName: json['instructor_name'] as String?,
      instructorAvatar: json['instructor_avatar'] as String?,
      participantsCount: (json['participants_count'] as num?)?.toInt() ?? 0,
      durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SessionModelImplToJson(_$SessionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'course_id': instance.courseId,
      'course_name': instance.courseName,
      'scheduled_at': instance.scheduledAt.toIso8601String(),
      'status': instance.status,
      'instructor_name': instance.instructorName,
      'instructor_avatar': instance.instructorAvatar,
      'participants_count': instance.participantsCount,
      'duration_minutes': instance.durationMinutes,
    };

_$LiveKitTokenResponseImpl _$$LiveKitTokenResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$LiveKitTokenResponseImpl(
      token: json['token'] as String,
      url: json['url'] as String,
      identity: json['identity'] as String,
      roomName: json['room_name'] as String,
    );

Map<String, dynamic> _$$LiveKitTokenResponseImplToJson(
        _$LiveKitTokenResponseImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'url': instance.url,
      'identity': instance.identity,
      'room_name': instance.roomName,
    };
