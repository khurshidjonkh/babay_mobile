import 'dart:convert';
import 'package:babay_mobile/utils/logger.dart';
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

      final headers = {'Token': rawToken, 'Lang': 'en'};
      final response = await http.get(Uri.parse(baseUrl), headers: headers);
      final data = json.decode(response.body);
      logger.d('Profile response: $data');

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

  Future<bool> updateProfile({
    required String name,
    required String lastName,
    required String email,
    required String phone,
    required DateTime birthDate,
    required String gender,
  }) async {
    try {
      // Get token
      final rawToken = locator<AuthService>().token;
      if (rawToken == null) {
        throw Exception('No token available');
      }

      // Start with base URL
      String url = 'https://babay.pro/app/profile.php?';

      // Build query parameters - only include fields that have values
      List<String> params = [];

      // Add name if provided
      if (name.trim().isNotEmpty) {
        params.add('name=${Uri.encodeComponent(name.trim())}');
      }

      // Add last_name if provided
      if (lastName.trim().isNotEmpty) {
        params.add('last_name=${Uri.encodeComponent(lastName.trim())}');
      }

      // Add email if provided
      if (email.trim().isNotEmpty) {
        params.add('email=${Uri.encodeComponent(email.trim())}');
      }

      // Add phone if provided
      if (phone.trim().isNotEmpty) {
        params.add('personal_phone=${Uri.encodeComponent(phone.trim())}');
      }

      // Add birthday if valid
      if (birthDate.year > 1900) {
        final formattedDate =
            '${birthDate.year}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}';
        params.add('personal_birthday=$formattedDate');
      }

      // Add gender if provided
      if (gender.trim().isNotEmpty) {
        params.add('personal_gender=${Uri.encodeComponent(gender.trim())}');
      }

      // Make sure we have at least one parameter to update
      if (params.isEmpty) {
        throw Exception('No profile fields provided for update');
      }

      // Join parameters with &
      url += params.join('&');

      logger.d('Sending POST request to URL: $url');

      // Set header - ONLY Token as shown in your Postman
      final headers = {'Token': rawToken};

      // Send POST request with the URL containing parameters
      final response = await http.post(Uri.parse(url), headers: headers);

      final data = json.decode(response.body);
      logger.d('Profile update response: $data');

      if (response.statusCode == 200 && data['status'] == 'OK') {
        logger.d('Server returned OK status');
        return true;
      } else {
        throw Exception(data['message'] ?? 'Failed to update profile');
      }
    } catch (e) {
      logger.e('Error updating profile: $e');
      rethrow;
    }
  }
}
