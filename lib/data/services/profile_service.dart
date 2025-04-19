import 'dart:convert';
import 'package:babay_mobile/core/service_locator.dart';
import 'package:babay_mobile/data/models/user_profile.dart';
import 'package:babay_mobile/data/services/auth_service.dart';

class ProfileService {
  static const String baseUrl = 'http://babay.pro/app/profile.php';

  Future<UserProfile> fetchProfile() async {
    try {
      // Debug: Print token before making request
      final token = locator<AuthService>().token;
      print('Attempting to fetch profile with token: $token');

      final response = await locator<AuthService>().authenticatedRequest(
        'GET',
        baseUrl,
        body: {'Lang': 'en'},
      );

      final data = json.decode(response.body);
      print('Profile API Response: $data'); // Debug log

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
