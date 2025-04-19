import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/providers/profile_provider.dart';
import 'edit_profile_screen.dart';
import 'phone_input_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Check authentication and fetch profile data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      if (!authProvider.isAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PhoneInputScreen()),
        );
        return;
      }
      context.read<ProfileProvider>().fetchProfile(context);
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Mening Profilim',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Consumer<ProfileProvider>(
            builder: (context, provider, _) => IconButton(
              icon: const Icon(Icons.edit_outlined, color: Colors.black),
              onPressed: () {
                if (provider.profile != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      initialName: provider.profile!.name,
                      initialPhone: provider.profile!.phone,
                      initialEmail: provider.profile!.email,
                      initialBirthDate: DateTime(1998, 1, 1), // You might want to add this to your profile model
                    ),
                  ),
                );
                }
              },
            ),
          ),
        ],
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = provider.profile;
          if (profile == null) {
            return const Center(child: Text('No profile data available'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                backgroundImage: profile.image != null ? NetworkImage(profile.image!) : null,
                child: profile.image == null
                    ? const Icon(Icons.person, size: 50, color: Colors.white)
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                profile.name,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
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
