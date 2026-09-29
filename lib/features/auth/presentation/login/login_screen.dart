import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import 'mobile/mobile_login_screen.dart';
import 'web/web_login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return const MobileLoginScreen();
    } else {
      return const WebLoginScreen();
    }
  }
}
