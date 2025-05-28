import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:babay_mobile/presentation/screens/home/partner_details_screen.dart';

// App theme colors - matching the app's theme
const Color primaryColor = Color(0xFF6A1B9A);
const Color secondaryColor = Color(0xFF9C27B0);
const Color accentColor = Color(0xFFE1BEE7);
const Color backgroundColor = Color(0xFFF5F5F5);

class PartnersScreen extends StatefulWidget {
  const PartnersScreen({super.key});

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> {
  @override
  Widget build(BuildContext context) {
    // Partners data (Hamkorlar) - same as in HomeScreen
    final List<Map<String, dynamic>> partners = [
      {
        'name': 'Mane',
        'logo': 'assets/images/kebab.png',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'BON!',
        'logo': 'assets/images/sweet.png',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'Lotus Spa',
        'logo': 'assets/images/manti.png',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'Tashkent City',
        'logo': 'assets/images/plow.png',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'Optera',
        'logo': 'assets/images/kebab.png',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'Qanotchi',
        'logo': 'assets/images/qanotchi.jpg',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'Optera',
        'logo': 'assets/images/kebab.png',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'Qanotchi',
        'logo': 'assets/images/qanotchi.jpg',
        'color': const Color(0xFFF5F5F5),
      },
      // Adding more partners to show scrolling capability
      {
        'name': 'Mane',
        'logo': 'assets/images/kebab.png',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'BON!',
        'logo': 'assets/images/sweet.png',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'Lotus Spa',
        'logo': 'assets/images/manti.png',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'Tashkent City',
        'logo': 'assets/images/plow.png',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'Optera',
        'logo': 'assets/images/kebab.png',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'Qanotchi',
        'logo': 'assets/images/qanotchi.jpg',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'Optera',
        'logo': 'assets/images/kebab.png',
        'color': const Color(0xFFF5F5F5),
      },
      {
        'name': 'Qanotchi',
        'logo': 'assets/images/qanotchi.jpg',
        'color': const Color(0xFFF5F5F5),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hamkorlar',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: partners.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Open details screen on tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PartnerDetailsScreen(
                      partner: partners[index],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    partners[index]['logo'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          partners[index]['name'],
                          style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
