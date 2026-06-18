import 'package:freezed_annotation/freezed_annotation.dart';

part 'certificate_model.freezed.dart';
part 'certificate_model.g.dart';

/// Model for student course completion certificates.
/// Contains the certificate metadata, preview URL, and download URL.
@freezed
abstract class CertificateModel with _$CertificateModel {
  const factory CertificateModel({
    required String id,
    @JsonKey(name: 'course_id') required String courseId,
    @JsonKey(name: 'course_title') required String courseTitle,
    @JsonKey(name: 'student_name') required String studentName,
    @JsonKey(name: 'issued_at') required DateTime issuedAt,
    @JsonKey(name: 'certificate_url') String? certificateUrl,
    @JsonKey(name: 'download_url') String? downloadUrl,
  }) = _CertificateModel;

  factory CertificateModel.fromJson(Map<String, dynamic> json) =>
      _$CertificateModelFromJson(json);
}
