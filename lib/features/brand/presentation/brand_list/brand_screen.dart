import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/responsive/responsive.dart';
import 'mobile/mobile_brand_screen.dart';
import 'web/web_brand_screen.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return const MobileBrandScreen();
    } else {
      return const WebBrandScreen();
    }
  }
}
