import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/screen_background.dart';
import 'notifications_screen.dart';

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
          onPressed: () {},
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
          IconButton(
            icon: const Icon(Icons.language_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {},
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
                onPressed: () {},
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
              child: SingleChildScrollView(
                child: Column(
                children:
                    coupons.asMap().entries.map((entry) {
                      final coupon = entry.value;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // Handle card tap
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(color: coupon['color']),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(coupon['logo']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        coupon['name'],
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '7/10',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Stack(
                                    children: [
                                      Container(
                                        height: 2,
                                        width: double.infinity,
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                      Container(
                                        height: 2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.7,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            1,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.3 -
                                            4,
                                        top: -3,
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${coupon['amount'].toInt()} UZS kupon aktiv..',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Tugash muddati: 24.04.2025',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
