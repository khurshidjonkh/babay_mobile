import 'package:flutter/material.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService;
  UserProfile? _profile;
  bool _isLoading = false;
  String? _error;

  ProfileProvider(this._profileService);

  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProfile(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await _profileService.fetchProfile();
      _error = null;
    } catch (e) {
      _error = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_error!), backgroundColor: Colors.red),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
