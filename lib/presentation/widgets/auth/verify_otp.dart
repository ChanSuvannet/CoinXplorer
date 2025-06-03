import 'package:coinxplorer/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/custom_app_bar.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  bool _isLoading = false;
  String? _phoneNumber;
  String? _countryCode;

  @override
  void initState() {
    super.initState();
    // Initialize variables or other non-context-dependent logic here
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve phone number and country code from route arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      _phoneNumber = args['phone'] as String? ?? '889566929';
      _countryCode = args['countryCode'] as String? ?? '+885';
    } else {
      _phoneNumber = '889566929';
      _countryCode = '+';
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool _validateOtp() {
    return _otpControllers.every(
      (controller) =>
          controller.text.isNotEmpty &&
          RegExp(r'^\d$').hasMatch(controller.text),
    );
  }

  Future<void> _handleVerifyOtp() async {
    if (_isLoading) return;

    if (!_validateOtp()) {
      return _showSnackBar('Please enter a valid 4-digit OTP');
    }

    final otp = _otpControllers.map((controller) => controller.text).join();
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));
    // Simulate static verification: succeed only if OTP is "1234"
    const bool isSuccess = true; // For testing, change to false or condition
    const String mockMessage = 'OTP verified successfully!';
    const String mockError = 'Invalid OTP';

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (isSuccess && otp == '1234') {
      _showSnackBar(mockMessage);
      Navigator.pushNamed(context, '/home');
    } else {
      _showSnackBar(mockError);
    }
  }

  Future<void> _handleResendOtp() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);

    if (!mounted) return;
    _showSnackBar('OTP resent successfully!');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 54,
      height: 54,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(AppStyles.borderRadius),
      ),
      child: TextField(
        controller: _otpControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '', // Hide character counter
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 3) {
            FocusScope.of(context).nextFocus(); // Move to next box
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus(); // Move to previous box
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(
        title: 'Verify OTP',
        showBackButton: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyles.padding,
          vertical: AppStyles.spacing,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppStyles.spacing),
            Center(
              child: Image.asset(
                'assets/images/verify.png',
                height: 280,
                width: 350,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: AppStyles.spacing),
            Center(
              child: Text(
                'Enter OTP',
                style: TextStyle(
                  fontSize: 28.32,
                  fontFamily: 'ExtraBold',
                  fontWeight: FontWeight.w900,
                  color: AppColors.textDark,
                ),
              ),
            ),
            const SizedBox(height: AppStyles.spacing),
            Center(
              child: Text(
                'A 4-digit OTP has been sent to ${_countryCode}${_phoneNumber}',
                style: TextStyle(
                  fontSize: AppStyles.fontSizeLink,
                  color: AppColors.textTertiary,
                ),
              ),
            ),
            const SizedBox(height: AppStyles.spacing * 5.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) => _buildOtpBox(index)),
            ),
            const SizedBox(height: AppStyles.spacing * 1.5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(
                  double.infinity,
                  AppStyles.buttonHeight,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyles.borderRadius),
                ),
              ),
              onPressed: _isLoading ? null : _handleVerifyOtp,
              child:
                  _isLoading
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                      : const Text(
                        'Verify',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          fontSize: AppStyles.fontSizeButton,
                        ),
                      ),
            ),
            const SizedBox(height: AppStyles.spacing),
            Center(
              child: TextButton(
                onPressed: _isLoading ? null : _handleResendOtp,
                child: Text(
                  'Resend OTP',
                  style: TextStyle(
                    fontSize: AppStyles.fontSizeLink,
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
