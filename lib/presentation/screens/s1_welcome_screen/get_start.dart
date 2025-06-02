import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../widgets/shared/onboarding_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page?.round() != _currentPage) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              OnboardingPage(
                image: 'assets/images/btc.png',
                title: 'Transformation of the Financial Structure',
                subtitle:
                    'Start exploring the crypto world now, with our app it\'s easy and secure',
                isVisible: _currentPage == 0,
              ),
              OnboardingPage(
                image: 'assets/images/solana.png',
                title: 'Live Price Updates',
                subtitle: 'With price autorefresh you\'re always up to date',
                isVisible: _currentPage == 1,
              ),
              OnboardingPage(
                image: 'assets/images/binance.png',
                title: 'Start Your Trading Journey',
                subtitle:
                    'Trade across multiple markets with the most stable and reliable pricing',
                isVisible: _currentPage == 2,
              ),
            ],
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 20 : 15,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index
                                ? AppColors.textDark
                                : AppColors.textPrimary,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: Size(266, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppStyles.borderRadius),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 18.77,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
