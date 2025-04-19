import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateToReplacement(Widget screen) {
    return navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void pop() {
    navigatorKey.currentState!.pop();
  }
}
