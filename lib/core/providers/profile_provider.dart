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

  Future<void> fetchProfile(BuildContext context, {bool silent = false}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Force a delay before fetching to allow server to process any recent updates
      await Future.delayed(const Duration(milliseconds: 300));
      _profile = await _profileService.fetchProfile();
      _error = null;
    } catch (e) {
      _error = e.toString();
      if (!silent) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_error!), backgroundColor: Colors.red),
        );
      }
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
      // Save the values we're trying to update
      final String currentName = name.trim();
      final String currentLastName = lastName.trim();
      
      // Simple logging
      print('Sending profile update: name="$currentName", lastName="$currentLastName"');
      
      // Call the service to update profile
      final success = await _profileService.updateProfile(
        name: currentName,
        lastName: currentLastName,
        email: email,
        phone: phone,
        birthDate: birthDate,
        gender: gender,
      );

      if (success) {
        // Give the server some time to process
        await Future.delayed(const Duration(seconds: 3));
        
        // Refresh profile data
        _profile = null; // Clear cache
        await fetchProfile(context, silent: true);
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        
        // If the profile data doesn't show our updates yet, manually update the local model
        // This gives immediate feedback to the user even if the server is slow to reflect changes
        if (_profile != null) {
          final fetchedName = _profile!.name.trim();
          final fetchedLastName = _profile!.lastName.trim();
          
          if (fetchedName != currentName || fetchedLastName != currentLastName) {
            print('Server returned old data, updating local model');
            _profile = UserProfile(
              id: _profile!.id,
              name: currentName,
              lastName: currentLastName,
              email: _profile!.email,
              photo: _profile!.photo,
              phone: _profile!.phone,
              birthday: _profile!.birthday,
              birthdayDate: _profile!.birthdayDate,
              gender: _profile!.gender,
            );
            notifyListeners();
          }
        }

        return true;
      } else {
        throw Exception('Server returned error status');
      }
    } catch (e) {
      _error = e.toString();
      print('Profile update error: $_error');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Update failed: ${_error!}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      return false;
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }
}
