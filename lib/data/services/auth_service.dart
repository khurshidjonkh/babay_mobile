import 'dart:io';
import 'package:babay_mobile/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'https://babay.pro';
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
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          followRedirects: true, // Follow redirects automatically
          validateStatus: (status) {
            return status != null &&
                status < 500; // Accept all status codes below 500
          },
        ),
      ) {
    // Add interceptors for better error handling
    _dio.interceptors.add(
      LogInterceptor(responseBody: true, requestBody: true, error: true),
    );
  }

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

      // Send as JSON as per API specification
      final response = await _dio.post(
        authEndpoint,
        data: {'phone': phone},
        options: Options(followRedirects: true),
      );

      logger.d('Response: ${response.data}');

      if (response.data['status'] == 'OK') {
        return true;
      } else {
        logger.e('Error response: ${response.data}');
        return false;
      }
    } on SocketException catch (e) {
      logger.e('Socket exception: $e');
      return false;
    } on DioException catch (e) {
      logger.e('Dio exception: ${e.type} - ${e.message}');
      return false;
    } catch (e) {
      logger.e('Error sending phone number: $e');
      return false;
    }
  }

  // Verify phone number with code (step 2)
  Future<String?> verifyCode(String phone, String code) async {
    try {
      logger.d('Verifying code: $code for phone: $phone');

      // Send as JSON as per API specification
      final response = await _dio.post(
        authEndpoint,
        data: {'phone': phone, 'sms_code': code},
        options: Options(followRedirects: true),
      );

      logger.d('Response: ${response.data}');

      if (response.data['status'] == 'OK' &&
          response.data['data'] != null &&
          response.data['data']['token'] != null) {
        final rawToken = response.data['data']['token'] as String;
        await _saveToken(rawToken);
        return rawToken;
      } else {
        // Extract error message from API response
        final errorMessage = response.data['message'] ?? 'Unknown error';
        logger.e('Error: $errorMessage');
        return null;
      }
    } on SocketException catch (e) {
      logger.e('Socket exception: $e');
      return null;
    } on DioException catch (e) {
      logger.e('Dio exception: ${e.type} - ${e.message}');
      return null;
    } catch (e) {
      logger.e('Error verifying code: $e');
      return null;
    }
  }
}
