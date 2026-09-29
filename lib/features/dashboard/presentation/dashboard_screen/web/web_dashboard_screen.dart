import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/services/brand_service.dart';
import '../../../../../data/models/category_model.dart';
import '../../../../../data/models/product_model.dart';
import '../../../../drawer/presentation/app_drawer/app_drawer.dart';
import '../../../function/dashboard_functions.dart';
import '../../../widgets/dashboard_inventory_value_card.dart';
import '../../../widgets/dashboard_recent_products.dart';
import '../../../widgets/dashboard_stats_grid.dart';

class WebDashboardScreen extends StatefulWidget {
  final DashboardData data;
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final BrandService brandService;

  const WebDashboardScreen({
    super.key,
    required this.data,
    required this.products,
    required this.categories,
    required this.brandService,
  });

  @override
  State<WebDashboardScreen> createState() => _WebDashboardScreenState();
}

class _WebDashboardScreenState extends State<WebDashboardScreen> {
  bool _isWebDrawerCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        elevation: 0,
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
      body: Row(
        children: [
          AppDrawer(
            isCollapsed: _isWebDrawerCollapsed,
            onToggleCollapse: () {
              setState(() {
                _isWebDrawerCollapsed = !_isWebDrawerCollapsed;
              });
            },
          ),
          Expanded(
            child: Container(
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
                      formattedInvValue: widget.data.formattedInvValue,
                      growthIcon: widget.data.growthIcon,
                      growthColor: widget.data.growthColor,
                      growthSign: widget.data.growthSign,
                      invGrowth: widget.data.invGrowth,
                    ),
                    const SizedBox(height: AppSizes.size24),
                    DashboardStatsGrid(
                      productsCount: widget.products.length,
                      lowStock: widget.data.lowStock,
                      outOfStock: widget.data.outOfStock,
                      categoriesCount: widget.categories.length,
                    ),
                    const SizedBox(height: AppSizes.size25),
                    DashboardRecentProducts(
                      topRecent: widget.data.topRecent,
                      categories: widget.categories,
                      brandService: widget.brandService,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
