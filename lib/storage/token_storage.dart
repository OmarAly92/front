// lib/storage/token_storage.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> storeToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }

  static Future<void> storeUserType(String userType) async {
    await _storage.write(key: 'user_type', value: userType);
  }

  static Future<String?> getUserType() async {
    return await _storage.read(key: 'user_type');
  }
}
