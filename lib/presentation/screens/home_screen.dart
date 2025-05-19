import 'package:babay_mobile/presentation/screens/qr_scanner_screen.dart';
import 'package:babay_mobile/presentation/widgets/coupon_details_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// App theme colors - matching the app's theme
const Color primaryColor = Color(0xFF6A1B9A);
const Color secondaryColor = Color(0xFF9C27B0);
const Color accentColor = Color(0xFFE1BEE7);
const Color backgroundColor = Color(0xFFF5F5F5);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // PageController for coupon cards with snap scrolling
  final PageController _couponPageController = PageController(
    viewportFraction: 0.85,
  );
  int _currentCouponPage = 0;

  // Loyalty cards data (Sodiqlik Kartalari)
  final List<Map<String, dynamic>> _loyaltyCards = [
    {
      'name': 'Sofia',
      'logo': 'assets/images/safia.jpg',
      'description': 'café & bakery',
    },
    {
      'name': 'BON!',
      'logo': 'assets/images/manti.png',
      'description': 'Restaurant',
    },
    {
      'name': 'Lotus Spa',
      'logo': 'assets/images/plow.png',
      'description': 'Spa & Wellness',
    },
    {
      'name': 'Sofia',
      'logo': 'assets/images/safia.jpg',
      'description': 'café & bakery',
    },
    {
      'name': 'BON!',
      'logo': 'assets/images/manti.png',
      'description': 'Restaurant',
    },
    {
      'name': 'Lotus Spa',
      'logo': 'assets/images/plow.png',
      'description': 'Spa & Wellness',
    },
  ];

  // Partners data (Hamkorlar)
  final List<Map<String, dynamic>> _partners = [
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

  // Hot deals data
  final List<Map<String, dynamic>> _hotDeals = [
    {
      'name': 'Basri Babadan Baklava set',
      'image': 'assets/images/manti.png',
      'originalPrice': '100,000 UZS',
      'discountedPrice': '50,000 UZS',
    },
    {
      'name': 'Iskander Kebab',
      'image': 'assets/images/kebab.png',
      'originalPrice': '120,000 UZS',
      'discountedPrice': '70,000 UZS',
    },
    {
      'name': 'Lotus Spa Massage',
      'image': 'assets/images/plow.png',
      'originalPrice': '200,000 UZS',
      'discountedPrice': '150,000 UZS',
    },
  ];

  @override
  void dispose() {
    _couponPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Coupon Cards with Snap Scrolling
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _couponPageController,
                  itemCount: _loyaltyCards.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentCouponPage = index;
                    });
                  },
                  physics: const PageScrollPhysics(),
                  padEnds: true,
                  itemBuilder: (context, index) {
                    return AnimatedScale(
                      scale: _currentCouponPage == index ? 1.0 : 0.9,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            children: [
                              // Card background
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [primaryColor, secondaryColor],
                                  ),
                                ),
                              ),
                              // Card content
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    // Logo circle
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: Image.asset(
                                          _loyaltyCards[index]['logo'],
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Text(
                                                    _loyaltyCards[index]['name']
                                                        .substring(0, 1),
                                                    style: const TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primaryColor,
                                                    ),
                                                  ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Card details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _loyaltyCards[index]['name'],
                                            style: GoogleFonts.poppins(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            _loyaltyCards[index]['description'],
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.white.withOpacity(
                                                0.8,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Page indicators
                              Positioned(
                                bottom: 16,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    _loyaltyCards.length,
                                    (i) => Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            _currentCouponPage == i
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Sodiqlik Kartalari section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Sodiqlik Kartalari',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
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
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          // childAspectRatio: 0.8,
                          // crossAxisSpacing: 8,
                          // mainAxisSpacing: 8,
                        ),
                    itemCount: _loyaltyCards.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder:
                                (context) => CouponDetailsSheet(
                                  coupon: _loyaltyCards[index],
                                ),
                          );
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.2),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  _loyaltyCards[index]['logo'],
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) => Center(
                                        child: Text(
                                          _loyaltyCards[index]['name']
                                              .substring(0, 1),
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _loyaltyCards[index]['name'],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Hamkorlar section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'Hamkorlar',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Handle partner tap
                      // Will be implemented later
                    },
                    borderRadius: BorderRadius.circular(12),
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
                          _partners[index]['logo'],
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _partners[index]['name'],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate to all partners page
                    },
                    child: Text(
                      'Barchasi',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              // Hot Deals section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'Hot Deals',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: _hotDeals.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hot deal image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            _hotDeals[index]['image'],
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  height: 150,
                                  color: Colors.grey.shade300,
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                          ),
                        ),
                        // Hot deal details
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _hotDeals[index]['name'],
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    _hotDeals[index]['originalPrice'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.red.shade400,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _hotDeals[index]['discountedPrice'],
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Bottom padding
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QRScannerScreen()),
          );
        },
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
    );
  }
}
