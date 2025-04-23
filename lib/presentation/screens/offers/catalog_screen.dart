import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'catalog_detail_screen.dart';

class CatalogScreen extends StatelessWidget {
  CatalogScreen({super.key});

  final List<Map<String, dynamic>> items = List.generate(
    10,
    (index) => {
      'label': index % 2 == 0 ? 'Deluxe Spa' : 'Nigina Spa',
      'icon': Icons.spa,
      // Replace with your real image asset or network path later
    },
  );

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Qidirish...',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.purple.shade300),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => CatalogDetailScreen(
                              label: item['label'],
                              icon: item['icon'],
                            ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item['icon'], size: 56, color: Colors.purple),
                        const SizedBox(height: 12),
                        Text(
                          item['label'],
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
