import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/services/brand_service.dart';
import '../../../../../core/widgets/bottom_nav/app_bottom_navigation_bar.dart';
import '../../../../../data/models/category_model.dart';
import '../../../../../data/models/product_model.dart';
import '../../../../drawer/presentation/app_drawer/app_drawer.dart';
import '../../../function/dashboard_functions.dart';
import '../../../widgets/dashboard_inventory_value_card.dart';
import '../../../widgets/dashboard_recent_products.dart';
import '../../../widgets/dashboard_stats_grid.dart';

class MobileDashboardScreen extends StatelessWidget {
  final DashboardData data;
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final BrandService brandService;

  const MobileDashboardScreen({
    super.key,
    required this.data,
    required this.products,
    required this.categories,
    required this.brandService,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const AppDrawer(),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 0),
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
            bottom: 120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardInventoryValueCard(
                formattedInvValue: data.formattedInvValue,
                growthIcon: data.growthIcon,
                growthColor: data.growthColor,
                growthSign: data.growthSign,
                invGrowth: data.invGrowth,
              ),
              const SizedBox(height: AppSizes.size24),
              DashboardStatsGrid(
                productsCount: products.length,
                lowStock: data.lowStock,
                outOfStock: data.outOfStock,
                categoriesCount: categories.length,
              ),
              const SizedBox(height: AppSizes.size25),
              DashboardRecentProducts(
                topRecent: data.topRecent,
                categories: categories,
                brandService: brandService,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
