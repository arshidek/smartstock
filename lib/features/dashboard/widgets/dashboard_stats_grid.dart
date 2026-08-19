import 'package:flutter/material.dart';
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
          iconColor: const Color(0xFF2563EB),
          iconBackgroundColor: const Color(0xFF2563EB).withValues(alpha: 0.1),
        ),
        SummaryMetric(
          icon: Icons.warning_amber_rounded,
          title: "Low Stock",
          value: lowStock.toString(),
          percentage: 0.0,
          isPositive: false,
          iconColor: const Color(0xFFFF9800),
          iconBackgroundColor: const Color(0xFFFF9800).withValues(alpha: 0.1),
        ),
        SummaryMetric(
          icon: Icons.block,
          title: "Out of Stock",
          value: outOfStock.toString(),
          percentage: 0.0,
          isPositive: false,
          iconColor: Colors.red,
          iconBackgroundColor: Colors.red.withValues(alpha: 0.1),
        ),
        SummaryMetric(
          icon: Icons.local_offer_outlined,
          title: "Categories",
          value: categoriesCount.toString(),
          percentage: 0.0,
          isPositive: true,
          iconColor: const Color(0xFF8B5CF6),
          iconBackgroundColor: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
        ),
      ],
    );
  }
}
