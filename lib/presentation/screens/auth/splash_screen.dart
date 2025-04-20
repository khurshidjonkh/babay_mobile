import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:babay_mobile/core/providers/auth_provider.dart';
import 'package:babay_mobile/presentation/screens/main/home_screen.dart';
import 'package:babay_mobile/presentation/screens/auth/phone_input_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _animationController.forward();

    // Check auth status and navigate after splash animation
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final isAuthenticated = authProvider.isAuthenticated;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder:
              (_) =>
                  isAuthenticated
                      ? const HomeScreen()
                      : const PhoneInputScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
