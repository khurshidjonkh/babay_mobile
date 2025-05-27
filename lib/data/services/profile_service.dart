import 'dart:convert';
import 'package:babay_mobile/utils/logger.dart';
import 'package:http/http.dart' as http;
import 'package:babay_mobile/core/service_locator.dart';
import 'package:babay_mobile/data/services/auth_service.dart';
import 'package:babay_mobile/data/models/user_profile_model.dart';
import 'package:intl/intl.dart';

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
      final rawToken = locator<AuthService>().token;

      if (rawToken == null) {
        throw Exception('No token available');
      }

      final headers = {
        'Token': rawToken,
        'Lang': 'en',
        'Content-Type': 'application/json',
      };

      // Format the date as YYYY-MM-DD for the API
      final formattedBirthDate = DateFormat('yyyy-MM-dd').format(birthDate);

      final body = json.encode({
        'name': name,
        'last_name': lastName,
        'email': email,
        'personal_phone': phone,
        'personal_birthday': formattedBirthDate,
        'personal_gender': gender,
      });

      logger.d('Updating profile with data: $body');

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: body,
      );

      final data = json.decode(response.body);
      logger.d('Profile update response: $data');

      if (response.statusCode == 200 && data['status'] == 'OK') {
        return true;
      } else {
        throw Exception(
          data['message'] ?? 'Failed to update profile: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        throw Exception(
          'Network connection error. Please check your internet connection.',
        );
      }
      logger.e('Error updating profile: $e');
      rethrow;
    }
  }
}
