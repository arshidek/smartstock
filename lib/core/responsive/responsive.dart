import 'package:flutter/material.dart';

class Responsive {
  // Breakpoints
  static const double mobile = 600;
  static const double tablet = 1024;

  // Device Types
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobile;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobile && width < tablet;
  }

  static bool isWeb(BuildContext context) {
    return MediaQuery.of(context).size.width >= tablet;
  }

  // Screen Width
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Screen Height
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
