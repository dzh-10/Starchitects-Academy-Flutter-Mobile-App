import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_service.dart';
import 'models/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(apiServiceProvider));
});

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<AuthResponse> login(String email, String password) {
    return _apiService.login({
      'email': email,
      'password': password,
    });
  }

  Future<AuthResponse> register(String name, String email, String password, String passwordConfirmation) {
    return _apiService.register({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
  }

  Future<void> logout() {
    return _apiService.logout();
  }

  Future<User> getUser() {
    return _apiService.getUser();
  }
}
