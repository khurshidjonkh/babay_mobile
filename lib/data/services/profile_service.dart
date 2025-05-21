import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:babay_mobile/core/service_locator.dart';
import 'package:babay_mobile/data/services/auth_service.dart';
import 'package:babay_mobile/data/models/user_profile_model.dart';

class ProfileService {
  static const String baseUrl = 'https://babay.pro/app/profile.php';

  Future<UserProfile> fetchProfile() async {
    try {
      final rawToken = locator<AuthService>().token;

      if (rawToken == null) {
        throw Exception('No token available');
      }

      // Use the dynamic header
      final headers = {'Token': rawToken, 'Lang': 'en'};

      final response = await http.get(Uri.parse(baseUrl), headers: headers);

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
