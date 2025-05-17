import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../widgets/coupon_details_sheet.dart';
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

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen>
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
      'expiry': '24.03.2025',
      'logo': 'assets/images/safia.jpg',
      'amount': 50000.0,
      'color': const Color(0xFFE8E5FF),
    },
    {
      'name': 'Korzinka',
      'expiry': '24.03.2025',
      'logo': 'assets/images/korzinka.png',
      'amount': 50000.0,
      'color': const Color.fromARGB(255, 230, 136, 194),
    },
    {
      'name': 'Qanotchi',
      'expiry': '24.03.2025',
      'logo': 'assets/images/qanotchi.jpg',
      'amount': 50000.0,
      'color': const Color.fromARGB(255, 55, 221, 69),
    },
    {
      'name': 'Korzinka',
      'expiry': '24.03.2025',
      'logo': 'assets/images/korzinka.png',
      'amount': 50000.0,
      'color': const Color.fromARGB(255, 231, 162, 201),
    },
    {
      'name': 'Qanotchi',
      'expiry': '24.03.2025',
      'logo': 'assets/images/qanotchi.jpg',
      'amount': 50000.0,
      'color': const Color.fromARGB(255, 168, 157, 163),
    },
    {
      'name': 'Korzinka',
      'expiry': '24.03.2025',
      'logo': 'assets/images/korzinka.png',
      'amount': 50000.0,
      'color': const Color.fromARGB(255, 183, 189, 131),
    },
    {
      'name': 'Qanotchi',
      'expiry': '24.03.2025',
      'logo': 'assets/images/qanotchi.jpg',
      'amount': 50000.0,
      'color': const Color.fromARGB(255, 55, 153, 138),
    },
    {
      'name': 'Korzinka',
      'expiry': '24.03.2025',
      'logo': 'assets/images/korzinka.png',
      'amount': 50000.0,
      'color': const Color.fromARGB(255, 181, 134, 141),
    },
    {
      'name': 'Qanotchi',
      'expiry': '24.03.2025',
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
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text('Mening zakazlarim', style: TextStyle(fontSize: 24)),
            Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                top: 16,
                bottom: 32,
              ),
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
            Expanded(
              child: ValueListenableBuilder<double>(
                valueListenable: _dragValue,
                builder: (context, value, _) {
                  final currentList =
                      isFaolSelected ? coupons : archivedCoupons;
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
                                  top:
                                      index *
                                      (topVisiblePartOfEachCard + value),
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
                                              backgroundColor:
                                                  Colors.transparent,
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
                                              backgroundColor:
                                                  Colors.transparent,
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
            Text(
              '${coupon['amount'].toInt()} UZS',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tugash muddati: ${coupon['expiry']}',
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArchivedCouponContent(Map<String, dynamic> coupon) {
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
            Text(
              '${coupon['amount'].toInt()} UZS',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                decorationColor: Colors.white,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 2,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tugash muddati: ${coupon['expiry']}',
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
