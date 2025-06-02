import 'package:coinxplorer/core/constants/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String _selectedCountryCode = '+855';

  // List of country codes (simplified for example)
  final List<String> _countryCodes = const ['+855', '+1', '+44', '+91'];

  @override
  void initState() {
    super.initState();
    _phoneController.text = '8895669292'; // Default phone number
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Basic phone number validation
  bool _validatePhoneNumber(String phone) {
    return phone.length >= 8 && RegExp(r'^\d+$').hasMatch(phone);
  }

  // Handle login button press
  Future<void> _handleLogin() async {
    if (_isLoading) return;

    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    if (!_validatePhoneNumber(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate a login request (replace with actual API call)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyles.padding,
          vertical: AppStyles.spacing,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 120),
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
                // Country code dropdown
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(AppStyles.borderRadius),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedCountryCode,
                    underline: const SizedBox(),
                    items:
                        _countryCodes.map((String code) {
                          return DropdownMenuItem<String>(
                            value: code,
                            child: Text(
                              code,
                              style: const TextStyle(
                                fontSize: AppStyles.fontSizeLabel,
                              ),
                            ),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCountryCode = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                // Phone number input
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppStyles.borderRadius,
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppStyles.borderRadius,
                        ),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppStyles.borderRadius,
                        ),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppStyles.spacing * 1.5),
            const Text(
              'Enter your password',
              style: TextStyle(
                fontSize: AppStyles.fontSizeLabel,
                color: AppColors.textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppStyles.borderRadius),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppStyles.borderRadius),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppStyles.borderRadius),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                    size: AppStyles.iconSize,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // Navigate to forgot password screen
                  Navigator.pushNamed(context, '/forgot-password');
                },
                child: const Text(
                  'forgot password?',
                  style: TextStyle(
                    fontSize: AppStyles.fontSizeLink,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
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
              onPressed: _isLoading ? null : _handleLogin,
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
                        'Login',
                        style: TextStyle(
                          fontSize: AppStyles.fontSizeLabel,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
            ),
            const SizedBox(height: AppStyles.spacing),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(
                    fontSize: AppStyles.fontSizeLink,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppStyles.spacing * 1.5),
            OutlinedButton.icon(
              onPressed: () {
                // Implement Google login
              },
              icon: const Image(
                image: AssetImage('assets/images/google_icon.png'),
                height: AppStyles.iconSize,
                width: AppStyles.iconSize,
              ),
              label: const Text(
                'Continue with Google',
                style: TextStyle(
                  fontSize: AppStyles.fontSizeLabel,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(
                  double.infinity,
                  AppStyles.buttonHeight,
                ),
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyles.borderRadius),
                ),
              ),
            ),
            const SizedBox(height: AppStyles.spacing),
            OutlinedButton.icon(
              onPressed: () {
                // Implement Binance login
              },
              icon: const Image(
                image: AssetImage('assets/images/binance_icon.png'),
                height: AppStyles.iconSize,
                width: AppStyles.iconSize,
              ),
              label: const Text(
                'Continue with Binance',
                style: TextStyle(
                  fontSize: AppStyles.fontSizeLabel,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(
                  double.infinity,
                  AppStyles.buttonHeight,
                ),
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyles.borderRadius),
                ),
              ),
            ),
            const SizedBox(height: AppStyles.spacing),
            Center(
              child: Text(
                'or',
                style: TextStyle(
                  fontSize: AppStyles.fontSizeLink,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            const SizedBox(height: AppStyles.spacing),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: const Text(
                  'Continue as Guest',
                  style: TextStyle(
                    fontSize: AppStyles.fontSizeLink,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
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
