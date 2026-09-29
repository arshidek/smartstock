import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/services/brand_service.dart';
import '../../../../core/services/category_service.dart';
import '../../../../core/services/product_service.dart';
import '../../../../data/models/product_model.dart';
import '../../function/dashboard_functions.dart';
import 'mobile/mobile_dashboard_screen.dart';
import 'web/web_dashboard_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ProductService get _productService => ProductService();
  CategoryService get _categoryService => CategoryService();
  BrandService get _brandService => BrandService();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<ProductModel>>(
      valueListenable: _productService.listenable,
      builder: (context, box, _) {
        final products = box.values.toList();
        final categories = _categoryService.getAllCategories();

        final dashboardData = DashboardFunctions.calculateDashboardData(
          products,
        );

        if (kIsWeb) {
          return WebDashboardScreen(
            data: dashboardData,
            products: products,
            categories: categories,
            brandService: _brandService,
          );
        } else {
          return MobileDashboardScreen(
            data: dashboardData,
            products: products,
            categories: categories,
            brandService: _brandService,
          );
        }
      },
    );
  }
}
