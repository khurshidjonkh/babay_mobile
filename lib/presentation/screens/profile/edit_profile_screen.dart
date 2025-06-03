import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/profile_provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../../screens/auth/phone_input_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialPhone;
  final String initialEmail;
  final DateTime initialBirthDate;
  final String initialGender;

  const EditProfileScreen({
    super.key,
    required this.initialName,
    required this.initialPhone,
    required this.initialEmail,
    required this.initialBirthDate,
    required this.initialGender,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController lastNameController;
  late DateTime birthDate;
  late String gender;
  File? _pickedImage;
  bool _hasChanged = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Split the full name into first name and last name
    final nameParts = widget.initialName.split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    print('Initial name: "${widget.initialName}"');
    print('Parsed first name: "$firstName", last name: "$lastName"');

    nameController = TextEditingController(text: firstName);
    lastNameController = TextEditingController(text: lastName);
    phoneController = TextEditingController(text: widget.initialPhone);
    emailController = TextEditingController(text: widget.initialEmail);
    birthDate = widget.initialBirthDate;
    gender = widget.initialGender.isEmpty ? 'M' : widget.initialGender;

    nameController.addListener(_onChanged);
    lastNameController.addListener(_onChanged);
    phoneController.addListener(_onChanged);
    emailController.addListener(_onChanged);
  }

  void _onChanged() {
    final fullName = '${nameController.text} ${lastNameController.text}'.trim();
    setState(() {
      _hasChanged =
          fullName != widget.initialName ||
          phoneController.text != widget.initialPhone ||
          emailController.text != widget.initialEmail ||
          birthDate != widget.initialBirthDate ||
          gender != widget.initialGender;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();

      // Show a dialog to choose between camera and gallery
      final source = await showDialog<ImageSource>(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Rasmni tanlang', style: GoogleFonts.poppins()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: Text('Kamera', style: GoogleFonts.poppins()),
                    onTap: () => Navigator.pop(context, ImageSource.camera),
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text('Galereya', style: GoogleFonts.poppins()),
                    onTap: () => Navigator.pop(context, ImageSource.gallery),
                  ),
                ],
              ),
            ),
      );

      if (source == null) return;

      final picked = await picker.pickImage(
        source: source,
        imageQuality: 80, // Reduce image quality to save memory
        maxWidth: 800, // Limit image dimensions
      );

      if (picked != null && mounted) {
        setState(() {
          _pickedImage = File(picked.path);
          _hasChanged = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Rasm tanlashda xatolik: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickBirthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
        _hasChanged = true;
      });
    }
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
          'Mening Profilim',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: (_hasChanged && !_isSubmitting) ? _handleSave : null,
            child:
                _isSubmitting
                    ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.purple,
                      ),
                    )
                    : Text(
                      'Saqlash',
                      style: GoogleFonts.poppins(
                        color: _hasChanged ? Colors.purple : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.purple.shade100,
                  backgroundImage:
                      _pickedImage != null ? FileImage(_pickedImage!) : null,
                  child:
                      _pickedImage == null
                          ? const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          )
                          : null,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField('Ism', nameController),
              const SizedBox(height: 16),
              _buildTextField('Familiya', lastNameController),
              const SizedBox(height: 16),
              _buildTextField(
                'Telefon',
                phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Email',
                emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildBirthDateField(),
              const SizedBox(height: 16),
              _buildGenderSelector(),
              const SizedBox(height: 32),
              _buildActionButton(
                text: 'Akkauntdan chiqish',
                color: Colors.purple,
                textColor: Colors.white,
                onPressed: () async {
                  // Show confirmation dialog
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text(
                            'Akkauntdan chiqish',
                            style: GoogleFonts.poppins(),
                          ),
                          content: Text(
                            'Akkauntdan chiqishni xohlaysizmi?',
                            style: GoogleFonts.poppins(),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(
                                'Bekor qilish',
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(
                                'Chiqish',
                                style: GoogleFonts.poppins(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                  );

                  if (confirm == true) {
                    // Clear auth token and navigate to auth screen
                    await Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    ).logout();

                    if (!mounted) return;

                    // Navigate to the initial auth page and remove all previous routes
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const PhoneInputScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
              ),
              const SizedBox(height: 12),
              _buildActionButton(
                text: 'Akkauntni o\'chirish',
                color: Colors.purple.shade100,
                textColor: Colors.purple,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.purple),
        filled: true,
        fillColor: Colors.grey.shade50,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.purple),
        ),
      ),
    );
  }

  Widget _buildBirthDateField() {
    return GestureDetector(
      onTap: _pickBirthDate,
      child: AbsorbPointer(
        child: TextField(
          controller: TextEditingController(
            text:
                '${birthDate.day.toString().padLeft(2, '0')}.${birthDate.month.toString().padLeft(2, '0')}.${birthDate.year}',
          ),
          style: GoogleFonts.poppins(color: Colors.black),
          decoration: InputDecoration(
            labelText: 'Tug\'ilgan kun',
            labelStyle: GoogleFonts.poppins(color: Colors.purple),
            filled: true,
            fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.purple),
            ),
            suffixIcon: const Icon(Icons.calendar_today, color: Colors.purple),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text('Jins', style: GoogleFonts.poppins(color: Colors.purple)),
        ),
        Row(
          children: [
            Expanded(child: _buildGenderOption('M', 'Erkak')),
            const SizedBox(width: 16),
            Expanded(child: _buildGenderOption('F', 'Ayol')),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption(String value, String label) {
    final isSelected = gender == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          gender = value;
          _hasChanged = true;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Colors.purple.withOpacity(0.2)
                  : Colors.purple.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.purple.shade100,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.purple, size: 20),
            if (isSelected) const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    // Validate inputs
    if (nameController.text.length < 3) {
      _showErrorSnackBar('Ism kamida 3 ta belgidan iborat bo\'lishi kerak');
      return;
    }

    if (lastNameController.text.isEmpty) {
      _showErrorSnackBar('Familiya kiritilishi shart');
      return;
    }

    if (phoneController.text.isEmpty || phoneController.text.length < 9) {
      _showErrorSnackBar('Telefon raqami noto\'g\'ri formatda');
      return;
    }

    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      _showErrorSnackBar('Email manzili noto\'g\'ri formatda');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );

      // Log the data being sent
      print('Sending profile update:');
      print('Name: ${nameController.text}');
      print('Last Name: ${lastNameController.text}');
      print('Email: ${emailController.text}');
      print('Phone: ${phoneController.text}');
      print('Birth Date: $birthDate');
      print('Gender: $gender');

      final success = await profileProvider.updateProfile(
        context: context,
        name: nameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        birthDate: birthDate,
        gender: gender,
      );

      if (success && mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      _showErrorSnackBar('Xatolik yuz berdi: $e');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
    );
  }
}
