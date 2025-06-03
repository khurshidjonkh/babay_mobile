import 'package:babay_mobile/presentation/widgets/coupon_details_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:babay_mobile/presentation/screens/home/menu_item_details_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// App theme colors - matching the app's theme
const Color primaryColor = Color(0xFF6A1B9A);
const Color secondaryColor = Color(0xFF9C27B0);
const Color accentColor = Color(0xFFE1BEE7);
const Color backgroundColor = Color(0xFFF5F5F5);

class PartnerDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> partner;

  const PartnerDetailsScreen({super.key, required this.partner});

  @override
  State<PartnerDetailsScreen> createState() => _PartnerDetailsScreenState();
}

class _PartnerDetailsScreenState extends State<PartnerDetailsScreen> {
  // Selected menu items
  final Set<int> _selectedItems = {};

  // State for map visibility
  bool _showMap = false;

  // Sample menu items for the partner
  final List<Map<String, dynamic>> _menuItems = [
    {
      'name': 'Cashback',
      'description': '1% cashback',
      'price': '',
      'image': 'assets/images/kebab.png',
    },
    {
      'name': 'Baklava set',
      'description': '',
      'price': '80,000 UZS',
      'image': 'assets/images/manti.png',
    },
    {
      'name': 'Iskander Kebab',
      'description': '',
      'price': '70,000 UZS',
      'image': 'assets/images/kebab.png',
    },
    {
      'name': 'Bida',
      'description': '',
      'price': '90,000 UZS',
      'image': 'assets/images/plow.png',
    },
  ];

  void _toggleItem(int index) {
    setState(() {
      if (_selectedItems.contains(index)) {
        _selectedItems.remove(index);
      } else {
        _selectedItems.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circular company logo
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  widget.partner['logo'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Center(
                        child: Text(
                          widget.partner['name'].substring(0, 1),
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
            // Company name
            Text(
              widget.partner['name'],
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight:
            120, // Increased height to accommodate the logo and title
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Menu items
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemCount: _menuItems.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _toggleItem(index),
                          onLongPress: () {
                            // Open menu item details screen on long press
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => MenuItemDetailsScreen(
                                      menuItem: _menuItems[index],
                                    ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              // Menu item card
                              Container(
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // Menu item image
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                              top: Radius.circular(12),
                                            ),
                                        child: Image.asset(
                                          _menuItems[index]['image'],
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Center(
                                                    child: Icon(
                                                      Icons.image_not_supported,
                                                      size: 40,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                        ),
                                      ),
                                    ),
                                    // Menu item details
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _menuItems[index]['name'],
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          if (_menuItems[index]['description']
                                              .isNotEmpty)
                                            Text(
                                              _menuItems[index]['description'],
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          if (_menuItems[index]['price']
                                              .isNotEmpty)
                                            Text(
                                              _menuItems[index]['price'],
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Selection indicator
                              if (_selectedItems.contains(index))
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Map section with toggle button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Column(
                      children: [
                        // Map toggle button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _showMap = !_showMap;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _showMap ? Icons.list : Icons.map,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _showMap ? 'Ro\'yxat' : 'Xaritada ko\'rish',
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Map view (conditionally visible)
                        if (_showMap)
                          Container(
                            height: 250,
                            margin: const EdgeInsets.only(top: 16),
                            decoration: BoxDecoration(
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
                              child: SizedBox(),
                              // GoogleMap(
                              //   initialCameraPosition: CameraPosition(
                              //     target: LatLng(
                              //       41.299496,
                              //       69.240073,
                              //     ), // Tashkent center
                              //     zoom: 14,
                              //   ),
                              //   myLocationEnabled: true,
                              //   myLocationButtonEnabled: true,
                              //   zoomControlsEnabled: true,
                              //   mapToolbarEnabled: false,
                              // ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // QR code generation button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder:
                        (context) => CouponDetailsSheet(
                          coupon: {
                            'name': 'Lotus Spa',
                            'logo': 'assets/images/safia.jpg',
                            'description': 'Spa & Wellness',
                          },
                        ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  '150,000 UZS QR kod yaratish',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
