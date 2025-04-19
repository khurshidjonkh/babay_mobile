import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:babay_mobile/core/service_locator.dart';
import 'package:babay_mobile/data/models/user_profile.dart';
import 'package:babay_mobile/data/services/auth_service.dart';

class ProfileService {
  static const String baseUrl = 'http://babay.pro/app/profile.php';

  Future<UserProfile> fetchProfile() async {
    try {
      final rawToken = locator<AuthService>().token;
      print('Debug - Raw token: $rawToken');

      if (rawToken == null) {
        throw Exception('No token available');
      }

      // Use the dynamic token with Bearer prefix
      final formattedToken = 'Bearer $rawToken';
      print('Debug - Formatted token: $formattedToken');

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': formattedToken,
          'Accept': 'application/json',
          'Lang': 'en',
        },
      );

      print('\n=== Profile API Response ===');
      print('Status Code: ${response.statusCode}');
      print('Response Headers:');
      response.headers.forEach((key, value) => print('$key: $value'));
      print('Response Body: ${response.body}');
      print('========================\n');

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['status'] == 'OK' && data['data'] != null) {
          return UserProfile.fromJson(data['data']);
        } else {
          throw Exception(data['message'] ?? 'Failed to parse profile data');
        }
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
