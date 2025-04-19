import 'dart:convert';
import 'package:babay_mobile/core/service_locator.dart';
import 'package:babay_mobile/data/models/user_profile.dart';
import 'package:babay_mobile/data/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  static const String baseUrl = 'http://babay.pro/app';
  static const String tokenKey = 'jwt_token'; // Same key as AuthService
  final SharedPreferences _prefs;

  ProfileService(this._prefs);

  String? get token {
    final savedToken = _prefs.getString(tokenKey);
    print('ProfileService - Retrieved token: $savedToken'); // Debug log
    return savedToken;
  }

  Future<UserProfile> fetchProfile() async {
    final token = locator<AuthService>().token; // Retrieve the token
    if (token == null) {
      throw Exception('No authentication token found');
    }

    try {
      final url = Uri.parse('$baseUrl/profile.php');
      print('Request URL: $token'); // Debug log
      final response = await http.get(
        url,
        headers: {
          'Token': token, // Send the token in the request header
          'Lang': 'en', // Optional: send the language if required
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('Response headers: ${response.headers}');

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['status'] == 'OK' && data['data'] != null) {
          return UserProfile.fromJson(data['data']);
        } else {
          throw Exception(data['message'] ?? 'Failed to parse profile data');
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw Exception(data['message'] ?? 'Authentication failed');
      } else {
        throw Exception(
          data['message'] ?? 'Failed to load profile: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        throw Exception(
          'Network connection error. Please check your internet connection.',
        );
      }
      rethrow;
    }
  }
}
