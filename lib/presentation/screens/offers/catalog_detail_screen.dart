import 'package:babay_mobile/presentation/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatalogDetailScreen extends StatelessWidget {
  final String label;
  final IconData icon;
  const CatalogDetailScreen({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Example values for demonstration
    final int oldPrice = 100000;
    final int newPrice = 50000;
    final int couponPrice = 40000;
    final String discount = '50% chegirma';
    final String expiry = '24.04.2025';
    final String description =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image section
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(icon, size: 80, color: Colors.purple),
              ),
              const SizedBox(height: 24),
              // Price row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      '${oldPrice.toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]},")} UZS',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      '${newPrice.toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]},")} UZS',
                      style: GoogleFonts.poppins(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      discount,
                      style: GoogleFonts.poppins(
                        color: Colors.purple,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Tugash muddati: $expiry',
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 12),
              Text(
                'BaBay kuponi bilan ${couponPrice.toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]},")} UZS',
                style: GoogleFonts.poppins(
                  color: Colors.purple,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tavsif:',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: GoogleFonts.poppins(color: Colors.black87, fontSize: 14),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentScreen()),
                    );
                  },
                  child: Text(
                    '${couponPrice.toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (Match m) => "${m[1]},")} UZS Xarid qilish',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
