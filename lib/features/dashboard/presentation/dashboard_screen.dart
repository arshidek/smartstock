import 'package:flutter/material.dart';

import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/product_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/services/brand_service.dart';
import '../../../data/models/product_model.dart';
import '../../../core/widgets/bottom_nav/app_bottom_navigation_bar.dart';
import '../../drawer/presentation/app_drawer.dart';
import '../../product/widgets/product_card_list.dart';
import '../../product/presentation/product_list_screen.dart';
import '../../product/presentation/product_detail_screen.dart';
import '../widgets/dashboard_inventory_value_card.dart';
import '../widgets/dashboard_recent_products.dart';
import '../widgets/dashboard_stats_grid.dart';

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
    final products = _productService.getAllProducts();
    final categories = _categoryService.getAllCategories();
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    double currentInvValue = 0;
    double previousInvValue = 0;
    int totalStock = 0;
    int lowStock = 0;
    int outOfStock = 0;

    for (var p in products) {
      double value = p.purchasePrice * p.stock;
      currentInvValue += value;
      totalStock += p.stock;

      if (p.stock == 0) {
        outOfStock++;
      } else if (p.stock <= 5) {
        lowStock++;
      }

      if (p.createdAt.isBefore(thirtyDaysAgo)) {
        previousInvValue += value;
      }
    }

    double invGrowth = previousInvValue == 0
        ? 0.0
        : ((currentInvValue - previousInvValue) / previousInvValue) * 100;
    String growthSign = invGrowth >= 0 ? "+" : "-";
    IconData growthIcon = invGrowth >= 0
        ? Icons.arrow_upward
        : Icons.arrow_downward;
    Color growthColor = invGrowth >= 0 ? Colors.greenAccent : Colors.redAccent;

    String formattedInvValue =
        "₹${(currentInvValue / 100000).toStringAsFixed(1)}L";
    if (currentInvValue < 100000) {
      formattedInvValue = "₹${currentInvValue.toStringAsFixed(0)}";
    }

    // Recent Products
    final recentProducts = List<ProductModel>.from(products)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final topRecent = recentProducts.take(3).toList();

    return Scaffold(
      extendBody: true,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: AppColors.white,
                size: AppSizes.size32,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dashboard",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: AppSizes.size25,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.background),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: AppSizes.borderRadius12,
            right: AppSizes.borderRadius12,
            top: AppSizes.borderRadius12,
            bottom: 120, // Extra space for the floating bottom navigation bar
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Inventory Value Card
              DashboardInventoryValueCard(
                formattedInvValue: formattedInvValue,
                growthIcon: growthIcon,
                growthColor: growthColor,
                growthSign: growthSign,
                invGrowth: invGrowth,
              ),

              const SizedBox(height: AppSizes.size24),

              // Four Stat Cards
              DashboardStatsGrid(
                productsCount: products.length,
                lowStock: lowStock,
                outOfStock: outOfStock,
                categoriesCount: categories.length,
              ),

              const SizedBox(height: AppSizes.size25),

              // Today's Added Products
              DashboardRecentProducts(
                topRecent: topRecent,
                categories: categories,
                brandService: _brandService,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 0),
    );
  }
}
