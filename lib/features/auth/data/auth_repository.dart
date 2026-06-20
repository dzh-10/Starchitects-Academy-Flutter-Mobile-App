import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/storage/secure_storage.dart';

class AuthRepository {
  final Dio _dio;
  final SecureStorageService _storage;

  AuthRepository(this._dio, this._storage);

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(ApiConstants.login, data: {
      'email': email,
      'password': password,
    });
    
    // Extract token and user depending on API response shape
    final data = response.data['data'] ?? response.data;
    final token = data['token'] ?? response.data['token'];
    
    if (token != null && token.toString().isNotEmpty) {
      await _storage.saveToken(token.toString());
    }
    
    return data;
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(ApiConstants.register, data: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password,
    });
    
    final data = response.data['data'] ?? response.data;
    final token = data['token'] ?? response.data['token'];
    
    if (token != null && token.toString().isNotEmpty) {
      await _storage.saveToken(token.toString());
    }
    
    return data;
  }

  Future<Map<String, dynamic>> getUser() async {
    final response = await _dio.get(ApiConstants.user);
    return response.data['data'] ?? response.data;
  }

  Future<bool> hasToken() async {
    final token = await _storage.getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    try {
      await _dio.post(ApiConstants.logout);
    } catch (_) {
      // Ignore network errors on logout, we still want to delete token locally
    } finally {
      await _storage.deleteToken();
    }
  }
}