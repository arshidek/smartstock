import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
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
        ),
      ],
    );
  }
}
