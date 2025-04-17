import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatalogDetailScreen extends StatelessWidget {
  const CatalogDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Catalog',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      body: const Center(
        child: Text('hello', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
