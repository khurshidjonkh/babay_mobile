import 'package:babay_mobile/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://babay.pro';
  static const String authEndpoint = '/app/auth.php';
  static const String tokenKey = 'jwt_token';

  final SharedPreferences _prefs;
  final Dio _dio;

  AuthService(this._prefs)
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          contentType: 'multipart/form-data',
          responseType: ResponseType.json,
        ),
      );

  // Get saved JWT token
  String? get token {
    String? token = _prefs.getString(tokenKey);
    logger.d('Retrieved token: $token');
    return token;
  }

  // Save JWT token
  Future<void> _saveToken(String token) async {
    await _prefs.setString(tokenKey, token);
  }

  // Clear JWT token (for logout)
  Future<void> clearToken() async {
    await _prefs.remove(tokenKey);
  }

  // Send phone number to get verification code (step 1)
  Future<bool> sendPhoneNumber(String phone) async {
    try {
      logger.d('Sending phone number: $phone');

      final formData = FormData.fromMap({'phone': phone});

      final response = await _dio.post(authEndpoint, data: formData);

      logger.d('Response: ${response.data}');

      if (response.data['status'] == 'OK') {
        return true;
      } else {
        logger.e('Error: ${response.data['message']}');
        return false;
      }
    } catch (e) {
      logger.e('Error sending phone number: $e');
      return false;
    }
  }

  // Verify phone number with code (step 2)
  Future<String?> verifyCode(String phone, String code) async {
    try {
      logger.d('Verifying code: $code for phone: $phone');

      final formData = FormData.fromMap({'phone': phone, 'sms_code': code});

      final response = await _dio.post(authEndpoint, data: formData);

      logger.d('Response: ${response.data}');

      if (response.data['status'] == 'OK' &&
          response.data['data']['token'] != null) {
        final rawToken = response.data['data']['token'] as String;
        await _saveToken(rawToken);
        return rawToken;
      } else {
        logger.e('Error: ${response.data['message']}');
        return null;
      }
    } catch (e) {
      logger.e('Error verifying code: $e');
      return null;
    }
  }
}
