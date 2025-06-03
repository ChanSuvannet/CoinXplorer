// Screens
import 'package:coinxplorer/presentation/screens/s1_welcome_screen/get_start.dart';
import 'package:coinxplorer/presentation/screens/s2_login/login_screen.dart';
import 'package:coinxplorer/presentation/screens/s3_home/home_screen.dart';
// Widgets
import 'package:coinxplorer/presentation/widgets/auth/sign_up.dart';
import 'package:coinxplorer/presentation/widgets/shared/page_not_found_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/auth/forgot_password.dart';
import '../widgets/auth/verify_otp.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case RoutePaths.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RoutePaths.signup:
        return MaterialPageRoute(builder: (_) => const SignUp());

      case RoutePaths.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());

      case RoutePaths.verify:
        return MaterialPageRoute(builder: (_) => const VerifyOtp());

      default:
        return MaterialPageRoute(builder: (_) => const PageNotFoundScreen());
    }
  }
}

/// A centralized class to manage route names
class RoutePaths {
  // for s1
  static const String welcome = '/welcome';
  // for s2
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String verify = '/verify-otp';
  // for s3
  static const String home = '/home';
}
