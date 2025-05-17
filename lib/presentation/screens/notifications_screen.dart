import 'package:babay_mobile/presentation/widgets/coupon_details_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
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
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        centerTitle: true,
        title: Text(
          'Xabarlar',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return InkWell(
            onTap: () {
              showCupertinoModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => CouponDetailsSheet(coupon: notification),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(notification['logo']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification['name']!,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${notification['amount']} UZS kupon aktiv.. This is a longer notification text that can span multiple lines to show more content',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
