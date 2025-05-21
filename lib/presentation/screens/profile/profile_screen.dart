import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/providers/profile_provider.dart';
import '../../../data/models/user_profile_model.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch profile data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(
        context,
        listen: false,
      ).fetchProfile(context);
    });
  }

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
              final profile =
                  Provider.of<ProfileProvider>(context, listen: false).profile;
              if (profile != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => EditProfileScreen(
                          initialName: '${profile.name} ${profile.lastName}',
                          initialPhone: profile.phone,
                          initialEmail: profile.email,
                          initialBirthDate:
                              profile.birthdayDate != null
                                  ? DateTime.tryParse(profile.birthdayDate!) ??
                                      DateTime(1998, 1, 1)
                                  : DateTime(1998, 1, 1),
                        ),
                  ),
                ).then((_) {
                  // Refresh profile data when returning from edit screen
                  Provider.of<ProfileProvider>(
                    context,
                    listen: false,
                  ).fetchProfile(context);
                });
              }
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
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, _) {
          if (profileProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final UserProfile? profile = profileProvider.profile;

          if (profile == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Profile data not available',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => profileProvider.fetchProfile(context),
                    child: Text('Retry', style: GoogleFonts.poppins()),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child:
                          profile.photo != null && profile.photo!.isNotEmpty
                              ? Image.network(
                                profile.photo!,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                                errorBuilder:
                                    (context, error, stackTrace) => const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                              )
                              : Image.asset(
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
                    '${profile.name} ${profile.lastName}',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  _buildInfoRow(Icons.phone, profile.phone),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.email, profile.email),
                  const SizedBox(height: 32),
                  QrImageView(
                    data: profile.id, // User's ID for QR code
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
          );
        },
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
