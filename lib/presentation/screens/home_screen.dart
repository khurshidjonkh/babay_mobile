import 'package:babay_mobile/presentation/screens/qr_scanner_screen.dart';
import 'package:babay_mobile/presentation/screens/offers/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../widgets/coupon_details_sheet.dart';
import 'notifications_screen.dart';
import 'profile/profile_screen.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

// Constants for card dimensions and visibility
const cardHeight = 180.0;
const topVisiblePartOfEachCard =
    cardHeight * 0.55; // How much of each card is visible initially

// App theme colors
const Color primaryColor = Color(0xFF6A1B9A);
const Color secondaryColor = Color(0xFF9C27B0);
const Color accentColor = Color(0xFFE1BEE7);
const Color backgroundColor = Color(0xFFF5F5F5);
const Color textPrimaryColor = Color(0xFF212121);
const Color textSecondaryColor = Color(0xFF757575);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isFaolSelected = true;
  final _dragValue = ValueNotifier<double>(0);
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        isFaolSelected = _tabController.index == 0;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      'color': const Color.fromARGB(255, 230, 136, 194),
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
    // Set system overlay style for status bar
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                              ? Colors.purple.shade500
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
                              ? Colors.purple.shade500
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
          const SizedBox(height: 16),
          if (isFaolSelected)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QRScannerScreen(),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.qr_code_scanner,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'BaBay',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Business Scanner',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                                curve: Curves.easeOutBack,
                                duration: const Duration(milliseconds: 300),
                                top: index * (topVisiblePartOfEachCard + value),
                                left: 16,
                                right: 16,
                                child: Hero(
                                  tag: 'coupon_${coupon['name']}_$index',
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        // Show coupon details with improved animation
                                        if (isFaolSelected) {
                                          HapticFeedback.lightImpact();
                                          showCupertinoModalBottomSheet(
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            builder:
                                                (context) => BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                    sigmaX: 5,
                                                    sigmaY: 5,
                                                  ),
                                                  child: CouponDetailsSheet(
                                                    coupon: coupon,
                                                  ),
                                                ),
                                          );
                                        }
                                      },
                                      onLongPress: () {
                                        if (isFaolSelected) {
                                          HapticFeedback.mediumImpact();
                                          showCupertinoModalBottomSheet(
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            builder:
                                                (context) => BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                    sigmaX: 5,
                                                    sigmaY: 5,
                                                  ),
                                                  child: CouponDetailsSheet(
                                                    coupon: coupon,
                                                  ),
                                                ),
                                          );
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(16),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              coupon['color'],
                                              Color.lerp(
                                                    coupon['color'],
                                                    Colors.white,
                                                    0.2,
                                                  ) ??
                                                  coupon['color'],
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: coupon['color']
                                                  .withOpacity(0.3),
                                              blurRadius: 12,
                                              offset: const Offset(0, 6),
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          height: cardHeight,
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
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        coupon['logo'],
                        fit: BoxFit.contain,
                        errorBuilder:
                            (context, error, stackTrace) => const Icon(
                              Icons.card_giftcard,
                              color: primaryColor,
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  coupon['name'],
                  style: GoogleFonts.poppins(
                    color: textPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Premium',
                    style: GoogleFonts.poppins(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '7/10 stamps',
                style: GoogleFonts.poppins(
                  color: Colors.blue.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${coupon['amount'].toInt()} UZS',
                style: GoogleFonts.poppins(
                  color: Colors.green.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Stack(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width * 0.7 * 0.7,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ],
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
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        coupon['logo'],
                        fit: BoxFit.contain,
                        errorBuilder:
                            (context, error, stackTrace) => const Icon(
                              Icons.card_giftcard,
                              color: primaryColor,
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  coupon['name'],
                  style: GoogleFonts.poppins(
                    color: textPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${coupon['amount'].toInt()} UZS',
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.access_time, color: Colors.red, size: 16),
              const SizedBox(width: 6),
              Text(
                'Expired: ${coupon['expiry']}',
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildLanguageOption(String flag, String language, String code) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context, code);
            // Set language here
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Text(flag, style: const TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 16),
                Text(
                  language,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textPrimaryColor,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
