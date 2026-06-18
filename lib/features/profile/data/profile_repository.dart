import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_service.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(apiServiceProvider));
});

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  Future<dynamic> getUserCertificates() {
    return _apiService.getUserCertificates();
  }
}
