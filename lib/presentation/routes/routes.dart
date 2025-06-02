import 'package:flutter/material.dart';

import '../screens/s1_welcome_screen/get_start.dart';
import '../screens/s2_login/login_screen.dart';
import '../screens/s3_home/home_screen.dart';
import '../widgets/shared/page_not_found_screen.dart' show PageNotFoundScreen;

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/welcome':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => PageNotFoundScreen());
    }
  }
}
