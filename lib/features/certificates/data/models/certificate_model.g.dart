// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CertificateModelImpl _$$CertificateModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CertificateModelImpl(
      id: json['id'] as String,
      courseId: json['course_id'] as String,
      courseTitle: json['course_title'] as String,
      studentName: json['student_name'] as String,
      issuedAt: DateTime.parse(json['issued_at'] as String),
      certificateUrl: json['certificate_url'] as String?,
      downloadUrl: json['download_url'] as String?,
    );

Map<String, dynamic> _$$CertificateModelImplToJson(
        _$CertificateModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'course_title': instance.courseTitle,
      'student_name': instance.studentName,
      'issued_at': instance.issuedAt.toIso8601String(),
      'certificate_url': instance.certificateUrl,
      'download_url': instance.downloadUrl,
    };
