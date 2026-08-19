import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppNavigation {
  AppNavigation._();

  // Push
  static Future<T?> goToScreen<T>(BuildContext context, Widget screen) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  // Push Replacement
  static Future<T?> goToReplacementScreen<T>(
    BuildContext context,
    Widget screen,
  ) {
    return Navigator.pushReplacement<T, T>(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  // Push and Remove All
  static Future<T?> goToScreenAndRemoveAll<T>(
    BuildContext context,
    Widget screen,
  ) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }

  // show to bottomSheet
  static Future<T?> showBottomSheet<T>(BuildContext context, Widget child) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => child,
    );
  }

  // Back
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static void goBackWithResult<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }
}
