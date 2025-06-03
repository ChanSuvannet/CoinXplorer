import 'package:coinxplorer/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/custom_app_bar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPassword> {
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String _selectedCountryCode = '+855';

  static const _countryCodes = ['+855', '+1', '+44', '+91'];

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validatePhoneNumber(String phone) =>
      phone.length >= 8 && RegExp(r'^\d+$').hasMatch(phone);

  Future<void> _handleGetOTP() async {
    if (_isLoading) return;

    final phone = _phoneController.text.trim();

    if (!_validatePhoneNumber(phone)) {
      return _showSnackBar('Please enter a valid phone number');
    }

    setState(() => _isLoading = true);

    // Simulate static data response for OTP request
    await Future.delayed(
      const Duration(seconds: 2),
    ); // Simulate processing delay
    const bool isSuccess = true; // Static success flag
    const String mockMessage =
        'OTP sent successfully!'; // Static response message

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (isSuccess) {
      _showSnackBar(mockMessage);
      Navigator.pushNamed(
        context,
        '/verify-otp',
        arguments: {'phone': phone, 'countryCode': _selectedCountryCode},
      );
    } else {
      _showSnackBar('Failed to send OTP');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(
        title: 'Forgot Password',
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
                'assets/images/forgot.png',
                height: 280,
                width: 350,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: AppStyles.spacing),
            Center(
              child: Text(
                'Forgot Password?',
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
                'Don’t worry! it happens. Please enter phone number associated with your account',
                style: TextStyle(
                  fontSize: AppStyles.fontSizeLink,
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppStyles.spacing * 4),
            const Text(
              'Enter your mobile number',
              style: TextStyle(
                fontSize: AppStyles.fontSizeLabel,
                color: AppColors.textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                      bottom: BorderSide(color: Colors.grey.shade300),
                      left: BorderSide(color: Colors.grey.shade300),
                    ),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(AppStyles.borderRadius),
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedCountryCode,
                    underline: const SizedBox(),
                    items:
                        _countryCodes
                            .map(
                              (code) => DropdownMenuItem(
                                value: code,
                                child: Text(
                                  code,
                                  style: const TextStyle(
                                    fontSize: AppStyles.fontSizeLabel,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged:
                        (value) =>
                            setState(() => _selectedCountryCode = value!),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade300),
                        bottom: BorderSide(color: Colors.grey.shade300),
                        right: BorderSide(color: Colors.grey.shade300),
                      ),
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(AppStyles.borderRadius),
                      ),
                    ),
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                ),
              ],
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
              onPressed: _isLoading ? null : _handleGetOTP,
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
                        'Get OTP',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          fontSize: AppStyles.fontSizeButton,
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
