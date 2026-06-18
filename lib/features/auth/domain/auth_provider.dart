import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/secure_storage.dart';
import '../data/auth_repository.dart';
import '../data/models/user_model.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  AsyncValue<User?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> checkAuth() async {
    state = const AsyncValue.loading();

    try {
      final token = await ref.read(secureStorageProvider).getToken();

      if (token != null && token.isNotEmpty) {
        final user = await ref.read(authRepositoryProvider).getUser();
        state = AsyncValue.data(user);
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      print('login: request start');

      final response = await ref
          .read(authRepositoryProvider)
          .login(email, password);
      print('login: api success');

      await ref.read(secureStorageProvider).saveToken(response.token);
      print('login: token saved');

      return response.user;
    });
  }

  Future<void> register(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      print('register: request start');

      final response = await ref.read(authRepositoryProvider).register(
            name,
            email,
            password,
            passwordConfirmation,
          );
      print('register: api success');

      await ref.read(secureStorageProvider).saveToken(response.token);
      print('register: token saved');

      return response.user;
    });
  }

  Future<void> logout() async {
    try {
      await ref.read(authRepositoryProvider).logout();
    } catch (_) {
      // Ignore API logout failure
    }

    await ref.read(secureStorageProvider).deleteToken();
    state = const AsyncValue.data(null);
  }
}