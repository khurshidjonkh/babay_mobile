import 'package:babay_mobile/presentation/screens/qr_scanner_screen.dart';
import 'package:babay_mobile/presentation/screens/offers/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../widgets/coupon_details_sheet.dart';
import 'notifications_screen.dart';
import 'profile/profile_screen.dart';

// Constants for card dimensions and visibility
const cardHeight = 160.0;
const topVisiblePartOfEachCard =
    cardHeight * 0.5; // How much of each card is visible initially

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFaolSelected = true;
  final _dragValue = ValueNotifier<double>(0);

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
      'color': const Color.fromARGB(255, 55, 221, 69),
    },
    {
      'name': 'Korzinka',
      'logo': 'assets/images/korzinka.png',
      'amount': 50000.0,
      'color': const Color.fromARGB(255, 231, 162, 201),
    },
    {
      'name': 'Qanotchi',
      'logo': 'assets/images/qanotchi.jpg',
      'amount': 50000.0,
      'color': const Color.fromARGB(255, 168, 157, 163),
    },
    {
      'name': 'Korzinka',
      'logo': 'assets/images/korzinka.png',
      'amount': 50000.0,
      'color': const Color.fromARGB(255, 183, 189, 131),
    },
    {
      'name': 'Qanotchi',
      'logo': 'assets/images/qanotchi.jpg',
      'amount': 50000.0,
      'color': const Color.fromARGB(255, 55, 153, 138),
    },
    {
      'name': 'Korzinka',
      'logo': 'assets/images/korzinka.png',
      'amount': 50000.0,
      'color': const Color.fromARGB(255, 181, 134, 141),
    },
    {
      'name': 'Qanotchi',
      'logo': 'assets/images/qanotchi.jpg',
      'amount': 50000.0,
      'color': const Color.fromARGB(255, 199, 210, 163),
    },
  ];

  final List<Map<String, dynamic>> archivedCoupons = [
    {
      'name': 'Safia',
      'logo': 'assets/images/safia.jpg',

      'amount': 50000.0,
      'expiry': '24.03.2025',
      'color': const Color(0xFFE8E5FF),
    },
    {
      'name': 'Korzinka',
      'logo': 'assets/images/korzinka.png',
      'amount': 50000.0,
      'expiry': '24.03.2025',
      'color': const Color(0xFF9C27B0),
    },
    {
      'name': 'Qanotchi',
      'logo': 'assets/images/qanotchi.jpg',
      'amount': 50000.0,
      'expiry': '24.03.2025',
      'color': const Color.fromARGB(255, 199, 210, 163),
    },
    {
      'name': 'Safia',
      'logo': 'assets/images/safia.jpg',

      'amount': 50000.0,
      'expiry': '24.03.2025',
      'color': const Color.fromARGB(255, 92, 90, 103),
    },
    {
      'name': 'Korzinka',
      'logo': 'assets/images/korzinka.png',
      'amount': 50000.0,
      'expiry': '24.03.2025',
      'color': const Color.fromARGB(255, 55, 153, 138),
    },
    {
      'name': 'Qanotchi',
      'logo': 'assets/images/qanotchi.jpg',
      'amount': 50000.0,
      'expiry': '24.03.2025',
      'color': const Color.fromARGB(255, 181, 134, 141),
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
          IconButton(
            icon: const Icon(Icons.language, color: Colors.black),
            onPressed: () {
              showCupertinoModalBottomSheet(
                context: context,
                builder:
                    (context) => Material(
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Text('🇺🇿'),
                            title: Text('Uzbek'),
                            onTap: () {
                              Navigator.pop(context, 'uz');
                              // Set language here
                            },
                          ),
                          ListTile(
                            leading: Text('🇷🇺'),
                            title: Text('Russian'),
                            onTap: () {
                              Navigator.pop(context, 'ru');
                              // Set language here
                            },
                          ),
                          ListTile(
                            leading: Text('🇬🇧'),
                            title: Text('English'),
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
      body: Column(
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
                              ? Colors.purple.shade300
                              : Colors.grey.shade50,
                    ),
                    child: Text(
                      'Faol',
                      style: GoogleFonts.poppins(
                        color: isFaolSelected ? Colors.white : Colors.black,
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
                              ? Colors.purple.shade300
                              : Colors.grey.shade50,
                    ),
                    child: Text(
                      'Arxiv',
                      style: GoogleFonts.poppins(
                        color: isFaolSelected ? Colors.black : Colors.white,
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
          if (isFaolSelected)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRScannerScreen(),
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
            child: ValueListenableBuilder<double>(
              valueListenable: _dragValue,
              builder: (context, value, _) {
                final currentList = isFaolSelected ? coupons : archivedCoupons;
                final scrollHeight =
                    topVisiblePartOfEachCard * (currentList.length - 1) +
                    cardHeight;

                return NotificationListener(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification) {
                      final offset = notification.metrics.pixels;
                      if (offset < 0 &&
                          offset > -1 * topVisiblePartOfEachCard) {
                        _dragValue.value = offset.abs();
                      }
                    }
                    return false;
                  },
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            currentList.isNotEmpty
                                ? SizedBox(
                                  height:
                                      scrollHeight +
                                      (currentList.length - 1) * value +
                                      24, // Extra space at bottom
                                )
                                : SizedBox(height: cardHeight + 24),
                            ...currentList.asMap().entries.map((entry) {
                              final index = entry.key;
                              final coupon = entry.value;
                              return AnimatedPositioned(
                                curve: Curves.decelerate,
                                duration: const Duration(milliseconds: 150),
                                top: index * (topVisiblePartOfEachCard + value),
                                left: 16,
                                right: 16,
                                child: GestureDetector(
                                  onTap: () {
                                    // Show coupon details
                                    if (isFaolSelected) {
                                      showCupertinoModalBottomSheet(
                                        context: context,
                                        builder:
                                            (context) => CouponDetailsSheet(
                                              coupon: coupon,
                                            ),
                                      );
                                    }
                                  },
                                  onLongPress: () {
                                    if (isFaolSelected) {
                                      showCupertinoModalBottomSheet(
                                        context: context,
                                        builder:
                                            (context) => CouponDetailsSheet(
                                              coupon: coupon,
                                            ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: cardHeight,
                                    decoration: BoxDecoration(
                                      color: coupon['color'],
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child:
                                          isFaolSelected
                                              ? _buildActiveCouponContent(
                                                coupon,
                                              )
                                              : _buildArchivedCouponContent(
                                                coupon,
                                              ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCouponContent(Map<String, dynamic> coupon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  coupon['logo'],
                  fit: BoxFit.contain,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Icon(Icons.card_giftcard),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '7/10',
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
            ),
            Text(
              '${coupon['amount'].toInt()} UZS',
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: 0.7,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildArchivedCouponContent(Map<String, dynamic> coupon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      coupon['logo'],
                      fit: BoxFit.contain,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.card_giftcard),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
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
            Text(
              '${coupon['amount'].toInt()} UZS',
              style: GoogleFonts.poppins(
                color: Colors.white,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 3,
                decorationColor: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          'Tugash muddati: ${coupon['expiry']}',
          style: GoogleFonts.poppins(
            color: Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
