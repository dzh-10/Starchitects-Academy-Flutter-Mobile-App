import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/features/certificates/data/models/certificate_model.dart';
import 'package:starchitects_app/features/certificates/data/repositories/certificate_repository.dart';

part 'certificate_provider.g.dart';

// ─── Certificates List Provider ─────────────────────────────────────────

/// Provides the list of certificates for the current student.
/// Auto-refreshes when invalidated.
@riverpod
Future<List<CertificateModel>> certificatesList(Ref ref) async {
  final repo = ref.read(certificateRepositoryProvider);
  return repo.getCertificates();
}
