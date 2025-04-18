import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://babay.pro/app/auth.php';
  static const String tokenKey = 'jwt_token';

  final SharedPreferences _prefs;

  AuthService(this._prefs);

  // Get saved JWT token
  String? get token => _prefs.getString(tokenKey);

  // Save JWT token
  Future<void> _saveToken(String token) async {
    await _prefs.setString(tokenKey, token);
  }

  // Clear JWT token (for logout)
  Future<void> clearToken() async {
    await _prefs.remove(tokenKey);
  }

  // Send phone number to get verification code
  Future<bool> sendPhoneNumber(String phone) async {
    try {
      // Mock API response since actual API isn't working
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      print('Error sending phone number: $e');
      return false;
    }
  }

  // Verify phone number with code
  Future<bool> verifyCode(String phone, String code) async {
    try {
      // Mock API response since actual API isn't working
      await Future.delayed(const Duration(seconds: 1));
      if (code.length == 4) {
        const mockToken = 'test_token_12345';
        await _prefs.setString(tokenKey, mockToken);
        return true;
      }
      return false;
    } catch (e) {
      print('Error verifying code: $e');
      return false;
    }
  }

  // Make authenticated request
  Future<http.Response> authenticatedRequest(
    String method,
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final token = this.token;
    if (token == null) {
      throw Exception('No token found');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Token': token,
    };

    switch (method.toUpperCase()) {
      case 'GET':
        return http.get(Uri.parse(endpoint), headers: headers);
      case 'POST':
        return http.post(
          Uri.parse(endpoint),
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }
}
