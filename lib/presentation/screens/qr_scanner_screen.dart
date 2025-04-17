import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  MobileScannerController? controller;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
    _initializeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.status;
    if (status.isDenied) {
      final result = await Permission.camera.request();
      if (result.isDenied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Camera permission is required')),
          );
        }
        return;
      }
    }

    if (mounted) {
      await controller?.stop();
      await Future.delayed(const Duration(milliseconds: 200));
      await controller?.start();
    }
  }

  Widget _buildCornerBorder({
    required Alignment alignment,
    required bool isLeft,
    required bool isTop,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            left:
                isLeft
                    ? const BorderSide(color: Colors.white, width: 3)
                    : BorderSide.none,
            right:
                !isLeft
                    ? const BorderSide(color: Colors.white, width: 3)
                    : BorderSide.none,
            top:
                isTop
                    ? const BorderSide(color: Colors.white, width: 3)
                    : BorderSide.none,
            bottom:
                !isTop
                    ? const BorderSide(color: Colors.white, width: 3)
                    : BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Safia Sampi',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            fit: BoxFit.cover,
            onDetect: (capture) {
              // Will implement QR code detection later
            },
          ),
          // QR frame corners
          Center(
            child: Container(
              width: 225,
              height: 225,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
              ),
              child: Stack(
                children: [
                  _buildCornerBorder(
                    alignment: Alignment.topLeft,
                    isLeft: true,
                    isTop: true,
                  ),
                  _buildCornerBorder(
                    alignment: Alignment.topRight,
                    isLeft: false,
                    isTop: true,
                  ),
                  _buildCornerBorder(
                    alignment: Alignment.bottomLeft,
                    isLeft: true,
                    isTop: false,
                  ),
                  _buildCornerBorder(
                    alignment: Alignment.bottomRight,
                    isLeft: false,
                    isTop: false,
                  ),
                ],
              ),
            ),
          ),
          // Flashlight button
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () async {
                    await controller?.toggleTorch();
                    setState(() => isFlashOn = !isFlashOn);
                  },
                  icon: Icon(
                    isFlashOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
