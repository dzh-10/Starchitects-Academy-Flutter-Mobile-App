// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certificate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CertificateModel _$CertificateModelFromJson(Map<String, dynamic> json) {
  return _CertificateModel.fromJson(json);
}

/// @nodoc
mixin _$CertificateModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'course_id')
  String get courseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'course_title')
  String get courseTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'student_name')
  String get studentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'issued_at')
  DateTime get issuedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'certificate_url')
  String? get certificateUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'download_url')
  String? get downloadUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CertificateModelCopyWith<CertificateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CertificateModelCopyWith<$Res> {
  factory $CertificateModelCopyWith(
          CertificateModel value, $Res Function(CertificateModel) then) =
      _$CertificateModelCopyWithImpl<$Res, CertificateModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'course_id') String courseId,
      @JsonKey(name: 'course_title') String courseTitle,
      @JsonKey(name: 'student_name') String studentName,
      @JsonKey(name: 'issued_at') DateTime issuedAt,
      @JsonKey(name: 'certificate_url') String? certificateUrl,
      @JsonKey(name: 'download_url') String? downloadUrl});
}

/// @nodoc
class _$CertificateModelCopyWithImpl<$Res, $Val extends CertificateModel>
    implements $CertificateModelCopyWith<$Res> {
  _$CertificateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? courseTitle = null,
    Object? studentName = null,
    Object? issuedAt = null,
    Object? certificateUrl = freezed,
    Object? downloadUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      courseTitle: null == courseTitle
          ? _value.courseTitle
          : courseTitle // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      issuedAt: null == issuedAt
          ? _value.issuedAt
          : issuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      certificateUrl: freezed == certificateUrl
          ? _value.certificateUrl
          : certificateUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CertificateModelImplCopyWith<$Res>
    implements $CertificateModelCopyWith<$Res> {
  factory _$$CertificateModelImplCopyWith(_$CertificateModelImpl value,
          $Res Function(_$CertificateModelImpl) then) =
      __$$CertificateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'course_id') String courseId,
      @JsonKey(name: 'course_title') String courseTitle,
      @JsonKey(name: 'student_name') String studentName,
      @JsonKey(name: 'issued_at') DateTime issuedAt,
      @JsonKey(name: 'certificate_url') String? certificateUrl,
      @JsonKey(name: 'download_url') String? downloadUrl});
}

/// @nodoc
class __$$CertificateModelImplCopyWithImpl<$Res>
    extends _$CertificateModelCopyWithImpl<$Res, _$CertificateModelImpl>
    implements _$$CertificateModelImplCopyWith<$Res> {
  __$$CertificateModelImplCopyWithImpl(_$CertificateModelImpl _value,
      $Res Function(_$CertificateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? courseTitle = null,
    Object? studentName = null,
    Object? issuedAt = null,
    Object? certificateUrl = freezed,
    Object? downloadUrl = freezed,
  }) {
    return _then(_$CertificateModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      courseTitle: null == courseTitle
          ? _value.courseTitle
          : courseTitle // ignore: cast_nullable_to_non_nullable
              as String,
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      issuedAt: null == issuedAt
          ? _value.issuedAt
          : issuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      certificateUrl: freezed == certificateUrl
          ? _value.certificateUrl
          : certificateUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      downloadUrl: freezed == downloadUrl
          ? _value.downloadUrl
          : downloadUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CertificateModelImpl implements _CertificateModel {
  const _$CertificateModelImpl(
      {required this.id,
      @JsonKey(name: 'course_id') required this.courseId,
      @JsonKey(name: 'course_title') required this.courseTitle,
      @JsonKey(name: 'student_name') required this.studentName,
      @JsonKey(name: 'issued_at') required this.issuedAt,
      @JsonKey(name: 'certificate_url') this.certificateUrl,
      @JsonKey(name: 'download_url') this.downloadUrl});

  factory _$CertificateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CertificateModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'course_id')
  final String courseId;
  @override
  @JsonKey(name: 'course_title')
  final String courseTitle;
  @override
  @JsonKey(name: 'student_name')
  final String studentName;
  @override
  @JsonKey(name: 'issued_at')
  final DateTime issuedAt;
  @override
  @JsonKey(name: 'certificate_url')
  final String? certificateUrl;
  @override
  @JsonKey(name: 'download_url')
  final String? downloadUrl;

  @override
  String toString() {
    return 'CertificateModel(id: $id, courseId: $courseId, courseTitle: $courseTitle, studentName: $studentName, issuedAt: $issuedAt, certificateUrl: $certificateUrl, downloadUrl: $downloadUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CertificateModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.courseTitle, courseTitle) ||
                other.courseTitle == courseTitle) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.issuedAt, issuedAt) ||
                other.issuedAt == issuedAt) &&
            (identical(other.certificateUrl, certificateUrl) ||
                other.certificateUrl == certificateUrl) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, courseId, courseTitle,
      studentName, issuedAt, certificateUrl, downloadUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CertificateModelImplCopyWith<_$CertificateModelImpl> get copyWith =>
      __$$CertificateModelImplCopyWithImpl<_$CertificateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CertificateModelImplToJson(
      this,
    );
  }
}

abstract class _CertificateModel implements CertificateModel {
  const factory _CertificateModel(
          {required final String id,
          @JsonKey(name: 'course_id') required final String courseId,
          @JsonKey(name: 'course_title') required final String courseTitle,
          @JsonKey(name: 'student_name') required final String studentName,
          @JsonKey(name: 'issued_at') required final DateTime issuedAt,
          @JsonKey(name: 'certificate_url') final String? certificateUrl,
          @JsonKey(name: 'download_url') final String? downloadUrl}) =
      _$CertificateModelImpl;

  factory _CertificateModel.fromJson(Map<String, dynamic> json) =
      _$CertificateModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'course_id')
  String get courseId;
  @override
  @JsonKey(name: 'course_title')
  String get courseTitle;
  @override
  @JsonKey(name: 'student_name')
  String get studentName;
  @override
  @JsonKey(name: 'issued_at')
  DateTime get issuedAt;
  @override
  @JsonKey(name: 'certificate_url')
  String? get certificateUrl;
  @override
  @JsonKey(name: 'download_url')
  String? get downloadUrl;
  @override
  @JsonKey(ignore: true)
  _$$CertificateModelImplCopyWith<_$CertificateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
