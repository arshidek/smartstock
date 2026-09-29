import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/responsive/responsive.dart';
import 'mobile/mobile_category_screen.dart';
import 'web/web_category_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return const MobileCategoryScreen();
    } else {
      return const WebCategoryScreen();
    }
  }
}
