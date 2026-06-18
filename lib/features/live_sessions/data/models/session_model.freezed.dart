// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) {
  return _SessionModel.fromJson(json);
}

/// @nodoc
mixin _$SessionModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'course_id')
  String get courseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'course_name')
  String get courseName => throw _privateConstructorUsedError;
  @JsonKey(name: 'scheduled_at')
  DateTime get scheduledAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'instructor_name')
  String? get instructorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'instructor_avatar')
  String? get instructorAvatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'participants_count')
  int get participantsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionModelCopyWith<SessionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionModelCopyWith<$Res> {
  factory $SessionModelCopyWith(
          SessionModel value, $Res Function(SessionModel) then) =
      _$SessionModelCopyWithImpl<$Res, SessionModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      @JsonKey(name: 'course_id') String courseId,
      @JsonKey(name: 'course_name') String courseName,
      @JsonKey(name: 'scheduled_at') DateTime scheduledAt,
      String status,
      @JsonKey(name: 'instructor_name') String? instructorName,
      @JsonKey(name: 'instructor_avatar') String? instructorAvatar,
      @JsonKey(name: 'participants_count') int participantsCount,
      @JsonKey(name: 'duration_minutes') int? durationMinutes});
}

/// @nodoc
class _$SessionModelCopyWithImpl<$Res, $Val extends SessionModel>
    implements $SessionModelCopyWith<$Res> {
  _$SessionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? courseId = null,
    Object? courseName = null,
    Object? scheduledAt = null,
    Object? status = null,
    Object? instructorName = freezed,
    Object? instructorAvatar = freezed,
    Object? participantsCount = null,
    Object? durationMinutes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      instructorName: freezed == instructorName
          ? _value.instructorName
          : instructorName // ignore: cast_nullable_to_non_nullable
              as String?,
      instructorAvatar: freezed == instructorAvatar
          ? _value.instructorAvatar
          : instructorAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      participantsCount: null == participantsCount
          ? _value.participantsCount
          : participantsCount // ignore: cast_nullable_to_non_nullable
              as int,
      durationMinutes: freezed == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionModelImplCopyWith<$Res>
    implements $SessionModelCopyWith<$Res> {
  factory _$$SessionModelImplCopyWith(
          _$SessionModelImpl value, $Res Function(_$SessionModelImpl) then) =
      __$$SessionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      @JsonKey(name: 'course_id') String courseId,
      @JsonKey(name: 'course_name') String courseName,
      @JsonKey(name: 'scheduled_at') DateTime scheduledAt,
      String status,
      @JsonKey(name: 'instructor_name') String? instructorName,
      @JsonKey(name: 'instructor_avatar') String? instructorAvatar,
      @JsonKey(name: 'participants_count') int participantsCount,
      @JsonKey(name: 'duration_minutes') int? durationMinutes});
}

/// @nodoc
class __$$SessionModelImplCopyWithImpl<$Res>
    extends _$SessionModelCopyWithImpl<$Res, _$SessionModelImpl>
    implements _$$SessionModelImplCopyWith<$Res> {
  __$$SessionModelImplCopyWithImpl(
      _$SessionModelImpl _value, $Res Function(_$SessionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? courseId = null,
    Object? courseName = null,
    Object? scheduledAt = null,
    Object? status = null,
    Object? instructorName = freezed,
    Object? instructorAvatar = freezed,
    Object? participantsCount = null,
    Object? durationMinutes = freezed,
  }) {
    return _then(_$SessionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      courseName: null == courseName
          ? _value.courseName
          : courseName // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledAt: null == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      instructorName: freezed == instructorName
          ? _value.instructorName
          : instructorName // ignore: cast_nullable_to_non_nullable
              as String?,
      instructorAvatar: freezed == instructorAvatar
          ? _value.instructorAvatar
          : instructorAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      participantsCount: null == participantsCount
          ? _value.participantsCount
          : participantsCount // ignore: cast_nullable_to_non_nullable
              as int,
      durationMinutes: freezed == durationMinutes
          ? _value.durationMinutes
          : durationMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionModelImpl implements _SessionModel {
  const _$SessionModelImpl(
      {required this.id,
      required this.title,
      @JsonKey(name: 'course_id') required this.courseId,
      @JsonKey(name: 'course_name') required this.courseName,
      @JsonKey(name: 'scheduled_at') required this.scheduledAt,
      required this.status,
      @JsonKey(name: 'instructor_name') this.instructorName,
      @JsonKey(name: 'instructor_avatar') this.instructorAvatar,
      @JsonKey(name: 'participants_count') this.participantsCount = 0,
      @JsonKey(name: 'duration_minutes') this.durationMinutes});

  factory _$SessionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey(name: 'course_id')
  final String courseId;
  @override
  @JsonKey(name: 'course_name')
  final String courseName;
  @override
  @JsonKey(name: 'scheduled_at')
  final DateTime scheduledAt;
  @override
  final String status;
  @override
  @JsonKey(name: 'instructor_name')
  final String? instructorName;
  @override
  @JsonKey(name: 'instructor_avatar')
  final String? instructorAvatar;
  @override
  @JsonKey(name: 'participants_count')
  final int participantsCount;
  @override
  @JsonKey(name: 'duration_minutes')
  final int? durationMinutes;

  @override
  String toString() {
    return 'SessionModel(id: $id, title: $title, courseId: $courseId, courseName: $courseName, scheduledAt: $scheduledAt, status: $status, instructorName: $instructorName, instructorAvatar: $instructorAvatar, participantsCount: $participantsCount, durationMinutes: $durationMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.courseName, courseName) ||
                other.courseName == courseName) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.instructorName, instructorName) ||
                other.instructorName == instructorName) &&
            (identical(other.instructorAvatar, instructorAvatar) ||
                other.instructorAvatar == instructorAvatar) &&
            (identical(other.participantsCount, participantsCount) ||
                other.participantsCount == participantsCount) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      courseId,
      courseName,
      scheduledAt,
      status,
      instructorName,
      instructorAvatar,
      participantsCount,
      durationMinutes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionModelImplCopyWith<_$SessionModelImpl> get copyWith =>
      __$$SessionModelImplCopyWithImpl<_$SessionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionModelImplToJson(
      this,
    );
  }
}

abstract class _SessionModel implements SessionModel {
  const factory _SessionModel(
          {required final String id,
          required final String title,
          @JsonKey(name: 'course_id') required final String courseId,
          @JsonKey(name: 'course_name') required final String courseName,
          @JsonKey(name: 'scheduled_at') required final DateTime scheduledAt,
          required final String status,
          @JsonKey(name: 'instructor_name') final String? instructorName,
          @JsonKey(name: 'instructor_avatar') final String? instructorAvatar,
          @JsonKey(name: 'participants_count') final int participantsCount,
          @JsonKey(name: 'duration_minutes') final int? durationMinutes}) =
      _$SessionModelImpl;

  factory _SessionModel.fromJson(Map<String, dynamic> json) =
      _$SessionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'course_id')
  String get courseId;
  @override
  @JsonKey(name: 'course_name')
  String get courseName;
  @override
  @JsonKey(name: 'scheduled_at')
  DateTime get scheduledAt;
  @override
  String get status;
  @override
  @JsonKey(name: 'instructor_name')
  String? get instructorName;
  @override
  @JsonKey(name: 'instructor_avatar')
  String? get instructorAvatar;
  @override
  @JsonKey(name: 'participants_count')
  int get participantsCount;
  @override
  @JsonKey(name: 'duration_minutes')
  int? get durationMinutes;
  @override
  @JsonKey(ignore: true)
  _$$SessionModelImplCopyWith<_$SessionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LiveKitTokenResponse _$LiveKitTokenResponseFromJson(Map<String, dynamic> json) {
  return _LiveKitTokenResponse.fromJson(json);
}

/// @nodoc
mixin _$LiveKitTokenResponse {
  String get token => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get identity => throw _privateConstructorUsedError;
  @JsonKey(name: 'room_name')
  String get roomName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LiveKitTokenResponseCopyWith<LiveKitTokenResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveKitTokenResponseCopyWith<$Res> {
  factory $LiveKitTokenResponseCopyWith(LiveKitTokenResponse value,
          $Res Function(LiveKitTokenResponse) then) =
      _$LiveKitTokenResponseCopyWithImpl<$Res, LiveKitTokenResponse>;
  @useResult
  $Res call(
      {String token,
      String url,
      String identity,
      @JsonKey(name: 'room_name') String roomName});
}

/// @nodoc
class _$LiveKitTokenResponseCopyWithImpl<$Res,
        $Val extends LiveKitTokenResponse>
    implements $LiveKitTokenResponseCopyWith<$Res> {
  _$LiveKitTokenResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? url = null,
    Object? identity = null,
    Object? roomName = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      identity: null == identity
          ? _value.identity
          : identity // ignore: cast_nullable_to_non_nullable
              as String,
      roomName: null == roomName
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LiveKitTokenResponseImplCopyWith<$Res>
    implements $LiveKitTokenResponseCopyWith<$Res> {
  factory _$$LiveKitTokenResponseImplCopyWith(_$LiveKitTokenResponseImpl value,
          $Res Function(_$LiveKitTokenResponseImpl) then) =
      __$$LiveKitTokenResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String token,
      String url,
      String identity,
      @JsonKey(name: 'room_name') String roomName});
}

/// @nodoc
class __$$LiveKitTokenResponseImplCopyWithImpl<$Res>
    extends _$LiveKitTokenResponseCopyWithImpl<$Res, _$LiveKitTokenResponseImpl>
    implements _$$LiveKitTokenResponseImplCopyWith<$Res> {
  __$$LiveKitTokenResponseImplCopyWithImpl(_$LiveKitTokenResponseImpl _value,
      $Res Function(_$LiveKitTokenResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? url = null,
    Object? identity = null,
    Object? roomName = null,
  }) {
    return _then(_$LiveKitTokenResponseImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      identity: null == identity
          ? _value.identity
          : identity // ignore: cast_nullable_to_non_nullable
              as String,
      roomName: null == roomName
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LiveKitTokenResponseImpl implements _LiveKitTokenResponse {
  const _$LiveKitTokenResponseImpl(
      {required this.token,
      required this.url,
      required this.identity,
      @JsonKey(name: 'room_name') required this.roomName});

  factory _$LiveKitTokenResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiveKitTokenResponseImplFromJson(json);

  @override
  final String token;
  @override
  final String url;
  @override
  final String identity;
  @override
  @JsonKey(name: 'room_name')
  final String roomName;

  @override
  String toString() {
    return 'LiveKitTokenResponse(token: $token, url: $url, identity: $identity, roomName: $roomName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveKitTokenResponseImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.identity, identity) ||
                other.identity == identity) &&
            (identical(other.roomName, roomName) ||
                other.roomName == roomName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, url, identity, roomName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveKitTokenResponseImplCopyWith<_$LiveKitTokenResponseImpl>
      get copyWith =>
          __$$LiveKitTokenResponseImplCopyWithImpl<_$LiveKitTokenResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiveKitTokenResponseImplToJson(
      this,
    );
  }
}

abstract class _LiveKitTokenResponse implements LiveKitTokenResponse {
  const factory _LiveKitTokenResponse(
          {required final String token,
          required final String url,
          required final String identity,
          @JsonKey(name: 'room_name') required final String roomName}) =
      _$LiveKitTokenResponseImpl;

  factory _LiveKitTokenResponse.fromJson(Map<String, dynamic> json) =
      _$LiveKitTokenResponseImpl.fromJson;

  @override
  String get token;
  @override
  String get url;
  @override
  String get identity;
  @override
  @JsonKey(name: 'room_name')
  String get roomName;
  @override
  @JsonKey(ignore: true)
  _$$LiveKitTokenResponseImplCopyWith<_$LiveKitTokenResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
