import 'package:babay_mobile/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/screen_background.dart';
import '../widgets/coupon_details_dialog.dart';
import 'notifications_screen.dart';
import 'business_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFaolSelected = true;

  final List<Map<String, dynamic>> coupons = [
    {
      'name': 'Safia',
      'logo': 'assets/images/safia.jpg',
      'amount': 50000.0,
      'color': const Color(0xFFE8E5FF),
    },
    {
      'name': 'Korzinka',
      'logo': 'assets/images/korzinka.png',
      'amount': 50000.0,
      'color': const Color(0xFF9C27B0),
    },
    {
      'name': 'Qanotchi',
      'logo': 'assets/images/qanotchi.jpg',
      'amount': 50000.0,
      'color': Colors.red,
    },
    {
      'name': 'Safia',
      'logo': 'assets/images/safia.jpg',
      'amount': 50000.0,
      'color': const Color(0xFFE8E5FF),
    },
    {
      'name': 'Korzinka',
      'logo': 'assets/images/korzinka.png',
      'amount': 50000.0,
      'color': const Color(0xFF9C27B0),
    },
    {
      'name': 'Qanotchi',
      'logo': 'assets/images/qanotchi.jpg',
      'amount': 50000.0,
      'color': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.language),
            onSelected: (String value) {
              // set app language based on value
            },
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(value: 'uz', child: Text('🇺🇿 Uzbek')),
                  PopupMenuItem<String>(
                    value: 'ru',
                    child: Text('🇷🇺 Russian'),
                  ),
                  PopupMenuItem<String>(
                    value: 'en',
                    child: Text('🇬🇧 English'),
                  ),
                ],
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: ScreenBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() => isFaolSelected = true);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            isFaolSelected
                                ? Colors.grey.shade400
                                : Colors.grey.shade50,
                      ),
                      child: Text(
                        'Faol',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight:
                              isFaolSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() => isFaolSelected = false);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            !isFaolSelected
                                ? Colors.grey.shade400
                                : Colors.grey.shade50,
                      ),
                      child: Text(
                        'Arxiv',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight:
                              !isFaolSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BusinessScreen(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'BaBay',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Business',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  top: 24,
                  bottom: 32,
                  left: 16,
                  right: 16,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: coupons.length,
                itemBuilder: (context, index) {
                  final coupon = coupons[index];
                  return Transform.translate(
                    offset: Offset(0, -index * 90.0),
                    child: Container(
                      height: 160,
                      margin: const EdgeInsets.only(bottom: 64),
                      child: Material(
                        elevation: 4,
                        color: coupon['color'],
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => CouponDetailsDialog(coupon: coupon),
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Image.asset(
                                          coupon['logo'],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      coupon['name'],
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '7/10',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '${coupon['amount'].toInt()} UZS',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value: 0.7,
                                    backgroundColor: Colors.grey.shade200,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          Colors.black,
                                        ),
                                    minHeight: 8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
