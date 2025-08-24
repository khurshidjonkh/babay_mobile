import 'package:babay_mobile/data/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  bool _isLoading = false;
  String? _error;
  String? phoneNumber;

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
      if (result) {
        phoneNumber = phone;
      } else {
        _error =
            'Tasdiqlash kodini yuborib bo\'lmadi. Iltimos, qaytadan urinib ko\'ring.';
      }
      notifyListeners();
      return result;
    } catch (e) {
      _isLoading = false;
      _error = 'Tarmoq xatosi. Iltimos, internet aloqangizni tekshiring.';
      notifyListeners();
      return false;
    }
  }

  // Verify phone number with code
  Future<bool> verifyCode(String code) async {
    if (phoneNumber == null) {
      _error = 'Telefon raqami topilmadi. Iltimos, qaytadan kiriting.';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _authService.verifyCode(phoneNumber!, code);
      _isLoading = false;
      if (token == null) {
        _error =
            'Tasdiqlash kodi noto\'g\'i. Iltimos, to\'g\'ri kodni kiriting.';
        notifyListeners();
        return false;
      }
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = 'Tarmoq xatosi. Iltimos, internet aloqangizni tekshiring.';
      notifyListeners();
      return false;
    }
  }

  // Clear error message
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Logout
  Future<void> logout() async {
    await _authService.clearToken();
    notifyListeners();
  }
}
