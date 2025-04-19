import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://babay.pro/app/auth.php';
  static const String tokenKey = 'jwt_token';

  final SharedPreferences _prefs;

  AuthService(this._prefs);

  // Get saved JWT token
  String? get token {
    final savedToken = _prefs.getString(tokenKey);
    print('Retrieved token: $savedToken'); // Debug log
    return savedToken;
  }

  // Save JWT token
  Future<void> _saveToken(String token) async {
    print('Saving token: $token'); // Debug log
    await _prefs.setString(tokenKey, token); // Save the token
    final savedToken = _prefs.getString(
      tokenKey,
    ); // Retrieve the token to verify
    print('Verified saved token: $savedToken'); // Debug log
  }

  // Clear JWT token (for logout)
  Future<void> clearToken() async {
    await _prefs.remove(tokenKey);
  }

  // Send phone number to get verification code
  Future<bool> sendPhoneNumber(String phone) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'phone': phone}, // Use form data as is
      );

      final data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        return true;
      } else {
        print('Error: ${data['message']}');
        return false;
      }
    } catch (e) {
      print('Error sending phone number: $e');
      return false;
    }
  }

  // Verify phone number with code
  Future<String?> verifyCode(String phone, String code) async {
    try {
      // For testing: Accept any 4-digit code since backend isn't sending real codes
      if (code.length != 4) {
        return null;
      }

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'phone': phone,
          'sms_code': code,
        }, // Use form data instead of jsonEncode
      );

      final data = jsonDecode(response.body);
      if (data['status'] == 'OK' && data['data']['token'] != null) {
        final token = data['data']['token'] as String;
        await _saveToken(token);
        return token;
      } else {
        print('Error: ${data['message']}');
        return null;
      }
    } catch (e) {
      print('Error verifying code: $e');
      return null;
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
      'Content-Type': 'application/x-www-form-urlencoded',
      'Token': token,
    };

    switch (method.toUpperCase()) {
      case 'GET':
        return http.get(Uri.parse(endpoint), headers: headers);
      case 'POST':
        return http.post(
          Uri.parse(endpoint),
          headers: headers,
          body:
              body, // body should already be Map<String, String> for form-urlencoded
        );
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }
}
