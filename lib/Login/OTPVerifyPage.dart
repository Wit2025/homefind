import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homefind/%E0%B9%87Home/Homes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPVerifyPage extends StatefulWidget {
  final String generatedOtp;
  final String phoneNumber;
  final bool rememberMe;

  const OTPVerifyPage({
    super.key,
    required this.generatedOtp,
    required this.phoneNumber,
    required this.rememberMe,
  });

  @override
  State<OTPVerifyPage> createState() => _OTPVerifyPageState();
}

class _OTPVerifyPageState extends State<OTPVerifyPage> {
  final _otpController = TextEditingController();
  String? _errorText;
  bool _isLoading = false;
  int _resendCountdown = 60;
  late Timer _timer;
  String? _currentOtp; // Store the current OTP

  @override
  void initState() {
    super.initState();
    _currentOtp = widget.generatedOtp;
    _startCountdown();
    // For testing - shows OTP in console and as a snackbar
    _showTestOtp();
  }

  void _showTestOtp() {
    print('Test OTP: $_currentOtp');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Test OTP: $_currentOtp'),
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        _timer.cancel();
      }
    });
  }

  String _generateNewOtp() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  void _resendOtp() {
    final newOtp = _generateNewOtp();
    setState(() {
      _resendCountdown = 60;
      _errorText = null;
      _currentOtp = newOtp;
      _startCountdown();
    });

    // Show the new OTP for testing
    print('New OTP: $newOtp');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('📩 OTP ຖືກສົ່ງໄປຫາເບີຂອງທ່ານ ອີກຄັ້ງ'),
            Text(
              'Test OTP: $newOtp',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void _verifyOtp() async {
    final enteredOtp = _otpController.text;
    if (enteredOtp.isEmpty || enteredOtp.length != 6) {
      setState(() => _errorText = 'ກະລຸນາປ້ອນ OTP 6 ຕົວເລກ');
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () async {
      setState(() => _isLoading = false);

      if (enteredOtp == _currentOtp) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        if (widget.rememberMe) {
          await prefs.setString('savedPhone', widget.phoneNumber);
          await prefs.setBool('rememberMe', true);
        }
        // Show beautiful success dialog
        showGeneralDialog(
          context: context,
          barrierDismissible: false,
          barrierLabel: '',
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) {
            return ScaleTransition(
              scale: CurvedAnimation(parent: __, curve: Curves.easeOutBack),
              child: Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.all(20),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Background container
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'ສຳເລັດ!',
                            style: TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF008B8B),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'ທ່ານໄດ້ຢືນຢັນ OTP ສຳເລັດ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF008B8B),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: const Text(
                                'ໄປທີ່ໜ້າຫຼັກ',
                                style: TextStyle(
                                  fontFamily: 'NotoSansLao',
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

                    // Animated checkmark icon
                    Positioned(
                      top: -40,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00CEB0),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00CEB0).withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        // Show error with vibration feedback
        HapticFeedback.lightImpact();
        setState(() => _errorText = '❌ OTP ບໍ່ຖືກຕ້ອງ, ກະລຸນາລອງໃໝ່');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return Scaffold(
      body: Column(
        children: [
          // Header Section
          Container(
            height: isSmallScreen ? size.height * 0.25 : size.height * 0.3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00CEB0), Color(0xFF006B8B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.verified_user,
                        size: 50,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'ຢືນຢັນ OTP',
                        style: TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: isSmallScreen ? 28 : 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'ກະລຸນາປ້ອນລະຫັດຢືນຢັນ',
                        style: TextStyle(
                          fontFamily: 'NotoSansLao',
                          fontSize: isSmallScreen ? 16 : 18,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // OTP Form
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: isSmallScreen ? 20 : 30,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                children: [
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'ສົ່ງລະຫັດ OTP ໄປຫາ ',
                                  style: TextStyle(
                                    fontFamily: 'NotoSansLao',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.phoneNumber,
                                  style: const TextStyle(
                                    fontFamily: 'NotoSansLao',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF008B8B),
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),

                          TextField(
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'NotoSansLao',
                              fontSize: 24,
                              letterSpacing: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              hintText: '••••••',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                letterSpacing: 8,
                              ),
                              errorText: _errorText,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                              counterText: '',
                            ),
                          ),
                          const SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _verifyOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF008B8B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'ຢືນຢັນ',
                                      style: TextStyle(
                                        fontFamily: 'NotoSansLao',
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          TextButton(
                            onPressed: _resendCountdown > 0 ? null : _resendOtp,
                            child: Text(
                              _resendCountdown > 0
                                  ? 'ສົ່ງ OTP ອີກຄັ້ງ (${_resendCountdown} ວິນາທີ)'
                                  : 'ສົ່ງ OTP ອີກຄັ້ງ',
                              style: TextStyle(
                                fontFamily: 'NotoSansLao',
                                color: _resendCountdown > 0
                                    ? Colors.grey
                                    : const Color(0xFF008B8B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
