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

    final authHeaders = {'Authorization': token};
    print('Authorization header: ${authHeaders['Authorization']}'); // Debug log

    // Merge headers, giving priority to auth headers
    final mergedHeaders = {...(headers ?? {}), ...authHeaders};
    return mergedHeaders;
  }

  Future<http.Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    try {
      final finalHeaders = _addAuthHeader(headers);

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

      print('\n=== HTTP Response ===');
      print('Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response Body: ${response.body}');
      print('==================\n');

      if (response.statusCode == 403) {
        final data = json.decode(response.body);
        print('Token error: ${data['message']}');

        // Clear token if expired/invalid
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
