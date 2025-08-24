import 'package:flutter/material.dart';
import 'package:babay_mobile/data/models/notification_model.dart';
import 'package:babay_mobile/data/services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService;
  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  String? _error;

  NotificationProvider(this._notificationService);

  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchNotifications({bool silent = false}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _notifications = await _notificationService.fetchNotifications();
      _error = null;
    } catch (e) {
      _error = e.toString();
      if (!silent) {
        // Handle session expiration
        if (_error!.contains('Session expired')) {
          // Navigate to login screen
          // This will be handled in the UI
        }
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAsRead(String notificationId, BuildContext context) async {
    // Validate notification ID
    if (notificationId.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid notification ID'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // Find the notification index
    final index = _notifications.indexWhere(
      (n) => n.displayId == notificationId,
    );
    if (index == -1) return;

    // Check if already read - if so, do nothing
    if (_notifications[index].read) {
      return;
    }

    // Optimistically update UI - remove blue dot immediately
    final originalNotification = _notifications[index];
    _notifications[index] = originalNotification.copyWith(read: true);
    notifyListeners();

    try {
      final success = await _notificationService.markAsRead(notificationId);
      if (!success) {
        // If API call failed, revert the change
        _notifications[index] = originalNotification;
        notifyListeners();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to mark notification as read'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      // If API call failed, revert the change
      _notifications[index] = originalNotification;
      notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
