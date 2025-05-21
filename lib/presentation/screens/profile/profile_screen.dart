import 'package:babay_mobile/core/service_locator.dart';
import 'package:babay_mobile/data/services/profile_service.dart';
import 'package:babay_mobile/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Mening Profilim',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => EditProfileScreen(
                        initialName: 'User Test',
                        initialPhone: '998991234567',
                        initialEmail: 'test@example.com',
                        initialBirthDate: DateTime(
                          1998,
                          1,
                          1,
                        ), // You might want to add this to your profile model
                      ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.language, color: Colors.black),
            onPressed: () {
              showCupertinoModalBottomSheet(
                context: context,
                builder:
                    (context) => Material(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40,
                            height: 4,
                            margin: const EdgeInsets.only(top: 12, bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          ListTile(
                            leading: const Text(
                              '🇺🇿',
                              style: TextStyle(fontSize: 20),
                            ),
                            title: Text('Uzbek', style: GoogleFonts.poppins()),
                            onTap: () {
                              Navigator.pop(context, 'uz');
                              // Set language here
                            },
                          ),
                          ListTile(
                            leading: const Text(
                              '🇷🇺',
                              style: TextStyle(fontSize: 20),
                            ),
                            title: Text(
                              'Russian',
                              style: GoogleFonts.poppins(),
                            ),
                            onTap: () {
                              Navigator.pop(context, 'ru');
                              // Set language here
                            },
                          ),
                          ListTile(
                            leading: const Text(
                              '🇬🇧',
                              style: TextStyle(fontSize: 20),
                            ),
                            title: Text(
                              'English',
                              style: GoogleFonts.poppins(),
                            ),
                            onTap: () {
                              Navigator.pop(context, 'en');
                              // Set language here
                            },
                          ),
                        ],
                      ),
                    ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'assets/images/user.png',
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                    errorBuilder:
                        (context, error, stackTrace) => const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'User Test',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoRow(Icons.phone, '998991234567'),
              const SizedBox(height: 12),
              _buildInfoRow(Icons.email, 'test@example.com'),
              const SizedBox(height: 32),
              QrImageView(
                data: '1234567890', // User's ID for QR code
                version: QrVersions.auto,
                size: 200.0,
              ),
              const SizedBox(height: 16),
              Text(
                'Cashback olish uchun QR kodni kassirga ko\'rsating',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.purple,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 12),
        Text(
          text,
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}
