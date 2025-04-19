import 'dart:convert';
import 'package:babay_mobile/data/models/user_profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final String baseUrl = 'http://babay.pro';
  final SharedPreferences _prefs;

  ProfileService(this._prefs);

  Future<UserProfile> fetchProfile() async {
    final token = _prefs.getString('token');
    if (token == null) {
      throw Exception('No authentication token found');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/app/profile.php'),
        headers: {'Token': token, 'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserProfile.fromJson(data);
      } else if (response.statusCode == 401) {
        throw Exception('Invalid token');
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
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
