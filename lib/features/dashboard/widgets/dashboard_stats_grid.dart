import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/features/product/presentation/product_list/product_list_screen.dart';
import 'package:smartstock_inventory/features/category/presentation/category_list/category_screen.dart';
import 'package:smartstock_inventory/features/stock/presentation/stock_management_screen/stock_management_screen.dart';
import '../../report/widgets/summary_card_grid.dart';

class DashboardStatsGrid extends StatelessWidget {
  final int productsCount;
  final int lowStock;
  final int outOfStock;
  final int categoriesCount;

  const DashboardStatsGrid({
    super.key,
    required this.productsCount,
    required this.lowStock,
    required this.outOfStock,
    required this.categoriesCount,
  });

  @override
  Widget build(BuildContext context) {
    return SummaryCardGrid(
      metrics: [
        SummaryMetric(
          icon: Icons.widgets_outlined,
          title: "Total Products",
          value: productsCount.toString(),
          percentage: 0.0,
          isPositive: true,
          iconColor: AppColors.blue,
          iconBackgroundColor: AppColors.blue.withValues(alpha: 0.1),
          subtitle: "Items in Inventory",
          onTap: () =>
              AppNavigation.goToScreen(context, const ProductListScreen()),
        ),
        SummaryMetric(
          icon: Icons.warning_amber_rounded,
          title: "Low Stock",
          value: lowStock.toString(),
          percentage: 0.0,
          isPositive: false,
          iconColor: AppColors.warning,
          iconBackgroundColor: AppColors.warning.withValues(alpha: 0.1),
          subtitle: "Items Running Low",
          onTap: () => AppNavigation.goToScreen(
            context,
            const StockManagementScreen(stockType: StockType.lowStock),
          ),
        ),
        SummaryMetric(
          icon: Icons.block,
          title: "Out of Stock",
          value: outOfStock.toString(),
          percentage: 0.0,
          isPositive: false,
          iconColor: AppColors.error,
          iconBackgroundColor: AppColors.error.withValues(alpha: 0.1),
          subtitle: "Needs Restocking",
          onTap: () => AppNavigation.goToScreen(
            context,
            const StockManagementScreen(stockType: StockType.outOfStock),
          ),
        ),
        SummaryMetric(
          icon: Icons.local_offer_outlined,
          title: "Categories",
          value: categoriesCount.toString(),
          percentage: 0.0,
          isPositive: true,
          iconColor: AppColors.purple,
          iconBackgroundColor: AppColors.purple.withValues(alpha: 0.1),
          subtitle: "Product Types",
          onTap: () =>
              AppNavigation.goToScreen(context, const CategoryScreen()),
        ),
      ],
    );
  }
}
