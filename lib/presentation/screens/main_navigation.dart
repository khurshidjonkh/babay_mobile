import 'package:babay_mobile/presentation/screens/card_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_screen.dart';
import 'qr_scanner_screen.dart';
import 'offers/search_screen.dart';
import 'notifications_screen.dart';
import 'profile/profile_screen.dart';

// App theme colors from HomeScreen
const Color primaryColor = Color(0xFF6A1B9A);
const Color secondaryColor = Color(0xFF9C27B0);
const Color accentColor = Color(0xFFE1BEE7);
const Color backgroundColor = Color(0xFFF5F5F5);

// Gradient colors for the selected item
const LinearGradient selectedGradient = LinearGradient(
  colors: [Color(0xFF6A1B9A), Color(0xFF9C27B0)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // List of screens for the bottom navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const CardScreen(), // Using this as "Carts" screen for now
    const SearchScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -1),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_outlined, Icons.home),
            _buildNavItem(1, Icons.article_outlined, Icons.article),
            _buildNavItem(2, Icons.search_outlined, Icons.search),
            _buildNavItem(3, Icons.notifications_outlined, Icons.notifications),
            _buildNavItem(4, Icons.person_outline, Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData unselectedIcon,
    IconData selectedIcon,
  ) {
    final isSelected = _currentIndex == index;

    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration:
            isSelected
                ? BoxDecoration(
                  gradient: selectedGradient,
                  borderRadius: BorderRadius.circular(20),
                )
                : null,
        child: Icon(
          isSelected ? selectedIcon : unselectedIcon,
          color: isSelected ? Colors.white : Colors.grey,
          size: 24,
        ),
      ),
    );
  }
}
