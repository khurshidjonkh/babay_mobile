import 'package:babay_mobile/presentation/widgets/profile_shimmer.dart';
import 'package:babay_mobile/presentation/widgets/babay_gold_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/providers/profile_provider.dart';
import '../../../data/models/user_profile_model.dart';
import 'edit_profile_screen.dart';

// App theme colors
const Color primaryColor = Color(0xFF6A1B9A);
const Color secondaryColor = Color(0xFF9C27B0);
const Color accentColor = Color(0xFFE1BEE7);
const Color backgroundColor = Color(0xFFF5F5F5);

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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Mening Profilim',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/edit-03-solid-rounded.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
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
                          initialGender: profile.gender,
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
        ],
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, _) {
          if (profileProvider.isLoading) {
            return const ProfileShimmer();
          }

          final UserProfile? profile = profileProvider.profile;

          if (profile == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Profil ma\'lumotlari mavjud emas',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Iltimos, qaytadan urinib ko\'ring',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => profileProvider.fetchProfile(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Qaytadan urinib ko\'ring',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                  // Profile Photo Section
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[200],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: _buildProfileImage(profile),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Name Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!, width: 1),
                    ),
                    child: Column(
                      children: [
                        Text(
                          (profile.name.isEmpty && profile.lastName.isEmpty)
                              ? 'Noma\'lum'
                              : '${profile.name} ${profile.lastName}',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'To\'liq ism',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Contact Information Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aloqa ma\'lumotlari',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          'assets/icons/call-02-solid-rounded.svg',
                          profile.phone,
                          'Telefon raqam',
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          'assets/icons/mail-02-solid-rounded.svg',
                          profile.email,
                          'Email',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // BaBay Gold Card
                  const BaBayGoldCard(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileImage(UserProfile profile) {
    if (profile.photo != null && profile.photo!.isNotEmpty) {
      final imageUrl =
          profile.photo!.startsWith('http')
              ? profile.photo!
              : 'https://babay.pro${profile.photo}';

      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: 120,
        height: 120,
        placeholder:
            (context, url) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.person, size: 50, color: Colors.grey),
            ),
        errorWidget:
            (context, url, error) =>
                const Icon(Icons.person, size: 50, color: Colors.grey),
      );
    } else {
      return const Icon(Icons.person, size: 50, color: Colors.grey);
    }
  }

  Widget _buildInfoRow(String iconPath, String text, String label) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            iconPath,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
