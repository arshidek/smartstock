import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/responsive/responsive.dart';
import 'package:smartstock_inventory/data/models/category_model.dart';
import 'mobile/mobile_category_details_screen.dart';
import 'web/web_category_details_screen.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final CategoryModel category;
  const CategoryDetailsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return MobileCategoryDetailsScreen(category: category);
    } else {
      return WebCategoryDetailsScreen(category: category);
    }
  }
}
