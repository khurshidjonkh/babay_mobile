import 'package:babay_mobile/presentation/screens/card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home/home_screen.dart';
import 'search/search_screen.dart';
import 'notifications_screen.dart';
import 'profile/profile_screen.dart';

// App theme colors from HomeScreen
const Color primaryColor = Color(0xFF6A1B9A);
const Color secondaryColor = Color(0xFF9C27B0);
const Color accentColor = Color(0xFFE1BEE7);
const Color backgroundColor = Color(0xFFF5F5F5);

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          _buildBottomNavigationBarItem(
            icon: 'assets/icons/home-02-stroke-rounded.svg',
            activeIcon: 'assets/icons/home-02-solid-rounded.svg',
          ),
          _buildBottomNavigationBarItem(
            icon: 'assets/icons/document-attachment-stroke-rounded.svg',
            activeIcon: 'assets/icons/document-attachment-solid-rounded.svg',
          ),
          _buildBottomNavigationBarItem(
            icon: 'assets/icons/search-02-stroke-rounded.svg',
            activeIcon: 'assets/icons/search-02-solid-rounded.svg',
          ),
          _buildBottomNavigationBarItem(
            icon: 'assets/icons/notification-01-stroke-rounded.svg',
            activeIcon: 'assets/icons/notification-01-solid-rounded.svg',
          ),
          _buildBottomNavigationBarItem(
            icon: 'assets/icons/user-circle-stroke-rounded.svg',
            activeIcon: 'assets/icons/user-circle-solid-rounded.svg',
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required String icon,
    required String activeIcon,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
      ),
      activeIcon: SvgPicture.asset(
        activeIcon,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
      ),
      label: '',
    );
  }
}
