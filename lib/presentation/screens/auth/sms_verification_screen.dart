import 'package:babay_mobile/core/providers/auth_provider.dart';
import 'package:babay_mobile/presentation/screens/home_screen.dart';
import 'package:babay_mobile/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class SmsVerificationScreen extends StatefulWidget {
  const SmsVerificationScreen({super.key});

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {
  final _pinController = TextEditingController();
  final _pinFocusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleVerification() async {
    if (_pinController.text.length != 4) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.verifyCode(_pinController.text);

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (authProvider.error != null) {
      _showErrorSnackBar(authProvider.error!);
    }
  }

  Future<void> _resendCode() async {
    _pinController.clear();
    _pinFocusNode.requestFocus();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.phoneNumber == null) {
      _showErrorSnackBar('Telefon raqami topilmadi');
      return;
    }

    await authProvider.sendPhoneNumber(authProvider.phoneNumber!);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder:
              (context, auth, _) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/logo.png', height: 100),
                            const SizedBox(height: 40),
                            Text(
                              'Tasdiqlash uchun SMS kodni kiriting',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),
                            _buildPinput(auth.isLoading),
                            const SizedBox(height: 32),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'SMS kodni olmadingizmi?',
                                  style: GoogleFonts.poppins(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.7),
                                    fontSize: 14,
                                  ),
                                ),
                                TextButton(
                                  onPressed:
                                      auth.isLoading ? null : _resendCode,
                                  child: Text(
                                    'Qaytadan yuborish',
                                    style: GoogleFonts.poppins(
                                      color:
                                          auth.isLoading
                                              ? Colors.grey
                                              : Colors.purple,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
                      child: PrimaryButton(
                        text: 'Tasdiqlash',
                        isLoading: auth.isLoading,
                        backgroundColor: Colors.purple,
                        onPressed:
                            _pinController.text.length == 4
                                ? _handleVerification
                                : null,
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }

  Widget _buildPinput(bool isLoading) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.purple, width: 2),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.5)),
      ),
    );

    return Pinput(
      controller: _pinController,
      focusNode: _pinFocusNode,
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      pinContentAlignment: Alignment.center,
      keyboardType: TextInputType.number,
      enabled: !isLoading,
      onCompleted: (pin) => _handleVerification(),
      onChanged: (_) => setState(() {}),
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
