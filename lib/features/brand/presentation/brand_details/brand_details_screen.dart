import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/responsive/responsive.dart';
import 'package:smartstock_inventory/data/models/brand_model.dart';
import 'mobile/mobile_brand_details_screen.dart';
import 'web/web_brand_details_screen.dart';

class BrandDetailsScreen extends StatelessWidget {
  final BrandModel brand;
  const BrandDetailsScreen({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return MobileBrandDetailsScreen(brand: brand);
    } else {
      return WebBrandDetailsScreen(brand: brand);
    }
  }
}
