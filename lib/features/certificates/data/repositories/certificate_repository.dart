import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/core/api/api_client.dart';
import 'package:starchitects_app/core/api/api_endpoints.dart';
import 'package:starchitects_app/features/certificates/data/models/certificate_model.dart';

part 'certificate_repository.g.dart';

/// Repository for certificate-related API calls.
/// Handles fetching certificate list and downloading certificate PDFs.
class CertificateRepository {
  final Dio _apiClient;

  CertificateRepository({required Dio Dio}) : _apiClient = Dio;

  // ─── Certificates List ────────────────────────────────────────────────

  /// Fetch all certificates for the current student.
  Future<List<CertificateModel>> getCertificates() async {
    final response = await _apiClient.get(ApiEndpoints.certificates);
    final data = response.data;

    if (data is List) {
      return data
          .map((e) => CertificateModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    // Handle wrapped response: { "data": [...] }
    if (data is Map<String, dynamic> && data.containsKey('data')) {
      final list = data['data'] as List;
      return list
          .map((e) => CertificateModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  // ─── Download Certificate ─────────────────────────────────────────────

  /// Download a certificate PDF as raw bytes.
  /// Returns Uint8List of the PDF file.
  Future<Uint8List> downloadCertificate(String id) async {
    final response = await _apiClient.get<List<int>>(
      ApiEndpoints.certificateDownload(id),
      options: Options(
        responseType: ResponseType.bytes,
        headers: {
          'Accept': 'application/pdf',
        },
      ),
    );

    return Uint8List.fromList(response.data!);
  }
}

@riverpod
CertificateRepository certificateRepository(Ref ref) {
  return CertificateRepository(
    Dio: ref.read(apiClientProvider),
  );
}
