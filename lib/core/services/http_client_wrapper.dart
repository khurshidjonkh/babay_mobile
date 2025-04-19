import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/services/auth_service.dart';
import '../../presentation/screens/phone_input_screen.dart';
import 'navigation_service.dart';

class HttpClientWrapper {
  final AuthService _authService;
  final NavigationService _navigationService;

  HttpClientWrapper(this._authService, this._navigationService);

  Map<String, String> _addAuthHeader(Map<String, String>? headers) {
    final token = _authService.token;
    if (token == null) return headers ?? {};

    print('Raw token from AuthService: $token'); // Debug log

    // Ensure token format
    final cleanToken = token.trim().replaceAll('Bearer ', '');
    final authHeaders = {'Authorization': 'Bearer $cleanToken'};
    print(
      'Formatted Authorization header: ${authHeaders['Authorization']}',
    ); // Debug log
    return headers != null ? {...headers, ...authHeaders} : authHeaders;
  }

  Future<http.Response> get(String url, {Map<String, String>? headers}) async {
    try {
      final finalHeaders = _addAuthHeader(headers);
      
      // Print complete request details
      print('\n=== HTTP Request ===');
      print('URL: $url');
      print('Method: GET');
      finalHeaders.forEach((key, value) {
        print('Header - $key: $value');
      });
      print('==================\n');
      
      final response = await http.get(
        Uri.parse(url),
        headers: finalHeaders,
      );
      // Print complete response details
      print('\n=== HTTP Response ===');
      print('Status Code: ${response.statusCode}');
      print('Response Headers:');
      response.headers.forEach((key, value) {
        print('$key: $value');
      });
      print('Response Body: ${response.body}');
      print('==================\n');

      if (response.statusCode == 403) {
        final data = json.decode(response.body);
        print('Token error: ${data['message']}');

        // Clear token
        await _authService.clearToken();

        // Navigate to phone input screen
        await _navigationService.navigateToReplacement(
          const PhoneInputScreen(),
        );
      }

      return response;
    } catch (e) {
      print('HTTP Error: $e');
      rethrow;
    }
  }

  Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    try {
      final finalHeaders = _addAuthHeader(headers);
      
      // Print complete request details
      print('\n=== HTTP Request ===');
      print('URL: $url');
      print('Method: POST');
      finalHeaders.forEach((key, value) {
        print('Header - $key: $value');
      });
      if (body != null) {
        print('Body: $body');
      }
      print('==================\n');

      final response = await http.post(
        Uri.parse(url),
        headers: finalHeaders,
        body: body,
        encoding: encoding,
      );

      // Print complete response details
      print('\n=== HTTP Response ===');
      print('Status Code: ${response.statusCode}');
      print('Response Headers:');
      response.headers.forEach((key, value) {
        print('$key: $value');
      });
      print('Response Body: ${response.body}');
      print('==================\n');

      if (response.statusCode == 403) {
        final data = json.decode(response.body);
        print('Token error: ${data['message']}');

        // Clear token
        await _authService.clearToken();

        // Navigate to phone input screen
        await _navigationService.navigateToReplacement(
          const PhoneInputScreen(),
        );
      }

      return response;
    } catch (e) {
      print('HTTP Error: $e');
      rethrow;
    }
  }
}
