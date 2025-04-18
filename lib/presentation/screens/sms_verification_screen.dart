import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/providers/auth_provider.dart';
import '../widgets/screen_background.dart';
import 'home_screen.dart';

class SmsVerificationScreen extends StatefulWidget {
  const SmsVerificationScreen({super.key});

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );
  String get _code => _controllers.map((c) => c.text).join();

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleVerification(BuildContext context) async {
    if (_code.length != 4) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.verifyCode(_code);

    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Consumer<AuthProvider>(
            builder: (context, auth, _) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Make sure this asset exists
                    height: 120,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Tasdiqlash uchun SMS ni kiriting',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (auth.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        auth.error!,
                        style: GoogleFonts.poppins(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (index) => SizedBox(
                        width: 45,
                        height: 55,
                        child: TextFormField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          enabled: !auth.isLoading,
                          onChanged: (value) {
                            if (value.length == 1 && index < 3) {
                              _focusNodes[index + 1].requestFocus();
                            }
                            if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                            if (_code.length == 4) {
                              _handleVerification(context);
                            }
                          },
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: auth.isLoading
                        ? null
                        : () async {
                            // Clear error and code fields
                            for (var controller in _controllers) {
                              controller.clear();
                            }
                            _focusNodes[0].requestFocus();
                            // Resend verification code
                            final authProvider =
                                Provider.of<AuthProvider>(context, listen: false);
                            await authProvider.sendPhoneNumber(
                                authProvider.phoneNumber!);
                          },
                    child: Text(
                      'Qaytadan yuborish',
                      style: GoogleFonts.poppins(
                        color: auth.isLoading ? Colors.grey : Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (auth.isLoading)
                    const CircularProgressIndicator()
                  else
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _code.length == 4
                            ? () => _handleVerification(context)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9C27B0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Tasdiqlash',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
