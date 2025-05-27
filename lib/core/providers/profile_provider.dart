import 'package:flutter/material.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService;
  UserProfile? _profile;
  bool _isLoading = false;
  bool _isUpdating = false;
  String? _error;

  ProfileProvider(this._profileService);

  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  bool get isUpdating => _isUpdating;
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
  
  Future<bool> updateProfile({
    required BuildContext context,
    required String name,
    required String lastName,
    required String email,
    required String phone,
    required DateTime birthDate,
    required String gender,
  }) async {
    _isUpdating = true;
    _error = null;
    notifyListeners();
    
    try {
      final success = await _profileService.updateProfile(
        name: name,
        lastName: lastName,
        email: email,
        phone: phone,
        birthDate: birthDate,
        gender: gender,
      );
      
      if (success) {
        // Refresh profile data after successful update
        await fetchProfile(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        return true;
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      _error = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_error!), backgroundColor: Colors.red),
      );
      return false;
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }
}
