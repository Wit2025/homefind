import 'package:flutter/material.dart';
import 'package:homefind/Login/OTPVerifyPage.dart';
import 'dart:math';

import 'package:homefind/Login/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;
  bool _obscurePassword = true;

  bool _acceptTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String _generateRandomOtp() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ກະລຸນາຍອມຮັບຂໍ້ກຳນົດແລະເງື່ອນໄຂກ່ອນ')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate registration process
    await Future.delayed(const Duration(seconds: 2));

    final testOtp = _generateRandomOtp();
    print('Test OTP: $testOtp');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('📩 OTP ຖືກສົ່ງໄປຫາເບີຂອງທ່ານ')),
    );

    if (mounted) {
      setState(
        () => _isLoading = false,
      ); // Reset loading state before navigation
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPVerifyPage(
            generatedOtp: testOtp,
            phoneNumber: _phoneController.text,
            rememberMe: _rememberMe,
          ),
        ),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    // Implement Google Sign-In functionality here
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with gradient
            Container(
              height: isSmallScreen ? size.height * 0.25 : size.height * 0.3,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00CEB0), Color(0xFF006B8B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Container
                      Container(
                        width: isSmallScreen ? 70 : 90,
                        height: isSmallScreen ? 70 : 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'images/logo.png', // Ensure this is in pubspec.yaml
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Title Text
                      Text(
                        'ສ້າງບັນຊີໃໝ່',
                        style: TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: isSmallScreen ? 24 : 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Subtitle Text
                      Text(
                        'ກະລຸນາປ້ອນຂໍ້ມູນຂອງທ່ານ',
                        style: TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: isSmallScreen ? 14 : 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Sign up form container
            Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16 : 24,
                ),
                padding: EdgeInsets.all(isSmallScreen ? 20 : 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Text(
                          'ລົງທະບຽນ',
                          style: TextStyle(
                            fontFamily:
                                'NotoSansLao', // Added Noto Sans Lao font
                            fontSize: isSmallScreen ? 20 : 24,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF008B8B),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Full name field
                      TextFormField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                          labelText: 'ຊື່ ແລະ ນາມສະກຸນ',
                          labelStyle: TextStyle(fontFamily: 'NotoSansLao'),
                          prefixIcon: const Icon(Icons.badge_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Square corners
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                        ),
                        style: TextStyle(fontFamily: 'NotoSansLao'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ກະລຸນາໃສ່ຊື່ ແລະ ນາມສະກຸນ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Email field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'ອີເມວ',
                          labelStyle: TextStyle(fontFamily: 'NotoSansLao'),
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Square corners
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                        ),
                        style: TextStyle(fontFamily: 'NotoSansLao'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ກະລຸນາໃສ່ອີເມວ';
                          }
                          if (!value.contains('@')) {
                            return 'ອີເມວບໍ່ຖືກຕ້ອງ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Phone field
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'ເບີໂທລະສັບ',
                          labelStyle: TextStyle(fontFamily: 'NotoSansLao'),
                          prefixIcon: const Icon(Icons.phone_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Square corners
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                        ),
                        style: TextStyle(fontFamily: 'NotoSansLao'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ກະລຸນາໃສ່ເບີໂທລະສັບ';
                          }
                          if (value.length < 8) {
                            return 'ເບີໂທລະສັບຕ້ອງຖືກຕ້ອງ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password field
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'ລະຫັດຜ່ານ',
                          labelStyle: TextStyle(fontFamily: 'NotoSansLao'),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(
                                () => _obscurePassword = !_obscurePassword,
                              );
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Square corners
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                        ),
                        style: TextStyle(fontFamily: 'NotoSansLao'),
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ກະລຸນາໃສ່ລະຫັດຜ່ານ';
                          }
                          if (value.length < 6) {
                            return 'ລະຫັດຜ່ານຕ້ອງຍາວຢ່າງໜ້ອຍ 6 ຕົວອັກສອນ';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 2),

                      // Terms and conditions checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _acceptTerms,
                            onChanged: (value) {
                              setState(() => _acceptTerms = value ?? false);
                            },
                            activeColor: const Color(0xFF008B8B),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'ຍອມຮັບຂໍ້ກຳນົດ ແລະ ເງື່ອນໄຂການໃຊ້ງານ',
                                style: TextStyle(
                                  fontFamily: 'NotoSansLao',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),

                      // Register button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF008B8B),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                8,
                              ), // Square corners
                            ),
                            elevation: 0,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'ລົງທະບຽນ',
                                  style: TextStyle(
                                    fontFamily: 'NotoSansLao',
                                    fontSize: isSmallScreen ? 16 : 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Divider with "OR"
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(thickness: 1, color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'ຫຼື',
                              style: TextStyle(
                                fontFamily: 'NotoSansLao',
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(thickness: 1, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Google Sign-In Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _isLoading ? null : _signInWithGoogle,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                8,
                              ), // Square corners
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/google.png', // Add your Google logo asset
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'ລົງທະບຽນດ້ວຍ Google',
                                style: TextStyle(
                                  fontFamily: 'NotoSansLao',
                                  fontSize: isSmallScreen ? 14 : 16,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Already have an account? Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ມີບັນຊີແລ້ວ?',
                            style: TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontSize: isSmallScreen ? 14 : 16,
                            ),
                          ),
                          const SizedBox(width: 4),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'ເຂົ້າສູ່ລະບົບ',
                              style: TextStyle(
                                fontFamily: 'NotoSansLao',
                                fontSize: isSmallScreen ? 14 : 16,
                                color: const Color(0xFF008B8B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
