import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';
import 'auth_state.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/secure_storage.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      await _repository.login(email: email, password: password);
      // Immediately fetch user after token is saved
      await checkAuth();
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      rethrow;
    }
  }

  Future<void> register(
    String name,
    String email,
    String password, [
    String? confirmPassword,
  ]) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      await _repository.register(name: name, email: email, password: password);
      // Immediately fetch user after token is saved
      await checkAuth();
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      rethrow;
    }
  }

  Future<void> logout() async {
    // Calling backend logout and locally deleting token regardless of success
    await _repository.logout();
    state = const AuthState(status: AuthStatus.unauthenticated, userData: null);
  }

  Future<void> checkAuth() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final hasToken = await _repository.hasToken();
      if (!hasToken) {
        state = const AuthState(status: AuthStatus.unauthenticated, userData: null);
        return;
      }
      final userMap = await _repository.getUser();
      state = state.copyWith(
        status: AuthStatus.authenticated,
        userData: UserData.fromMap(userMap),
        errorMessage: null,
      );
    } catch (_) {
      // If getUser fails (e.g., 401 Unauthorized), safely mark as unauthenticated
      state = const AuthState(status: AuthStatus.unauthenticated, userData: null);
    }
  }
}

// Ensure the repository receives the interceptor-configured Dio and the SecureStorage
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(dioProvider),
    ref.read(secureStorageProvider),
  );
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});