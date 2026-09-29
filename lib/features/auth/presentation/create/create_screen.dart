import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import 'mobile/mobile_create_screen.dart';
import 'web/web_create_screen.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return const MobileCreateScreen();
    } else {
      return const WebCreateScreen();
    }
  }
}
