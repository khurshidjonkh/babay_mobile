import 'package:flutter/foundation.dart';
import '../../data/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  bool _isLoading = false;
  String? _error;

  AuthProvider(this._authService);

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _authService.token != null;

  // Send phone number to get verification code
  Future<bool> sendPhoneNumber(String phone) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _authService.sendPhoneNumber(phone);
      _isLoading = false;
      if (!result) {
        _error = 'Failed to send verification code';
      }
      notifyListeners();
      return result;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Verify phone number with code
  Future<bool> verifyCode(String phone, String code) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _authService.verifyCode(phone, code);
      _isLoading = false;
      if (!result) {
        _error = 'Invalid verification code';
      }
      notifyListeners();
      return result;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _authService.clearToken();
    notifyListeners();
  }
}
