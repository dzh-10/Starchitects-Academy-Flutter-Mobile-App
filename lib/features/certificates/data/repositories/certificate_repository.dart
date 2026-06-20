import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/core/api/api_client.dart';
import 'package:starchitects_app/core/api/api_endpoints.dart';
import 'package:starchitects_app/features/certificates/data/models/certificate_model.dart';

part 'certificate_repository.g.dart';

class CertificateRepository {
  final Dio _apiClient;

  CertificateRepository({required Dio Dio}) : _apiClient = Dio;

  Future<List<CertificateModel>> getCertificates() async {
    final response = await _apiClient.get(ApiEndpoints.certificates);
    final data = response.data;

    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map((e) => CertificateModel.fromJson(e))
          .toList();
    }

    if (data is Map<String, dynamic> && data.containsKey('data')) {
      final list = data['data'] as List;
      return list
          .whereType<Map<String, dynamic>>()
          .map((e) => CertificateModel.fromJson(e))
          .toList();
    }

    return [];
  }

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
