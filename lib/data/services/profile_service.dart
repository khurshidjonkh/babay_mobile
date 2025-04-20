import 'dart:convert';
import 'package:babay_mobile/utils/logger.dart';
import 'package:http/http.dart' as http;
import 'package:babay_mobile/core/service_locator.dart';
import 'package:babay_mobile/data/models/user_profile.dart';
import 'package:babay_mobile/data/services/auth_service.dart';

class ProfileService {
  static const String baseUrl = 'http://babay.pro/app/profile.php';

  Future<UserProfile> fetchProfile() async {
    try {
      final rawToken = locator<AuthService>().token;
      logger.d('Raw token: $rawToken');

      if (rawToken == null) {
        throw Exception('No token available');
      }

      // Use the dynamic token with Bearer prefix
      final formattedToken = 'Bearer $rawToken';
      logger.d('Formatted token: $formattedToken');

      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {'Authorization': formattedToken, 'Lang': 'en'},
      );

      logger.d('\n=== Profile API Response ===');
      logger.d('Status Code: ${response.statusCode}');
      logger.d('Response Headers:');
      response.headers.forEach((key, value) => logger.d('$key: $value'));
      logger.d('Response Body: ${response.body}');
      logger.d('========================\n');

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
