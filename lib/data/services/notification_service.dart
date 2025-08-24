import 'dart:convert';
import 'package:babay_mobile/utils/logger.dart';
import 'package:http/http.dart' as http;
import 'package:babay_mobile/core/service_locator.dart';
import 'package:babay_mobile/data/services/auth_service.dart';
import 'package:babay_mobile/data/models/notification_model.dart';

class NotificationService {
  static const String baseUrl = 'https://babay.pro';
  static const String notificationsEndpoint = '/app/notification.php';
  static const String readEndpoint = '/app/notify_read.php';

  Future<List<NotificationModel>> fetchNotifications() async {
    try {
      final rawToken = locator<AuthService>().token;

      if (rawToken == null) {
        throw Exception('No token available');
      }

      final headers = {
        'Token': rawToken,
        'Accept': 'application/json; charset=utf-8',
        'Accept-Charset': 'utf-8',
      };

      final response = await http.get(
        Uri.parse('$baseUrl$notificationsEndpoint'),
        headers: headers,
      );

      // Ensure proper UTF-8 decoding
      final responseBody = utf8.decode(response.bodyBytes);
      logger.d('Raw response body: ${response.body}');
      logger.d('UTF-8 decoded body: $responseBody');
      final data = json.decode(responseBody);
      logger.d('Notifications response: $data');

      if (response.statusCode == 200) {
        if (data['status'] == 'OK' && data['data'] != null) {
          final List<dynamic> notificationsJson = data['data'];
          return notificationsJson
              .map((json) => NotificationModel.fromJson(json))
              .toList();
        } else {
          throw Exception(data['message'] ?? 'Failed to parse notifications');
        }
      } else if (response.statusCode == 401) {
        // Token expired, logout user
        await locator<AuthService>().clearToken();
        throw Exception('Session expired. Please login again.');
      } else {
        throw Exception(
          data['message'] ??
              'Failed to load notifications: ${response.statusCode}',
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

  Future<bool> markAsRead(String notificationId) async {
    try {
      final rawToken = locator<AuthService>().token;

      if (rawToken == null) {
        throw Exception('No token available');
      }

      // Validate notification ID
      if (notificationId.isEmpty) {
        throw Exception('Invalid notification ID');
      }

      final headers = {
        'Token': rawToken,
        'Accept': 'application/json; charset=utf-8',
        'Accept-Charset': 'utf-8',
      };

      final response = await http.post(
        Uri.parse('$baseUrl$readEndpoint?notify_id=$notificationId'),
        headers: headers,
      );

      // Ensure proper UTF-8 decoding
      final responseBody = utf8.decode(response.bodyBytes);
      logger.d('Raw response body: ${response.body}');
      logger.d('UTF-8 decoded body: $responseBody');
      final data = json.decode(responseBody);
      logger.d('Mark as read response: $data');

      if (response.statusCode == 200) {
        return data['status'] == 'OK';
      } else if (response.statusCode == 401) {
        // Token expired, logout user
        await locator<AuthService>().clearToken();
        throw Exception('Session expired. Please login again.');
      } else {
        throw Exception(
          data['message'] ??
              'Failed to mark notification as read: ${response.statusCode}',
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
