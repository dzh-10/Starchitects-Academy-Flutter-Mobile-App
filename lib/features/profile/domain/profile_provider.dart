import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/profile_repository.dart';

part 'profile_provider.g.dart';

@riverpod
Future<dynamic> userCertificates(UserCertificatesRef ref) {
  return ref.read(profileRepositoryProvider).getUserCertificates();
}
