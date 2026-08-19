import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../function/report_functions.dart';
import '../widgets/summary_card_grid.dart';
import '../widgets/trend_bar_chart.dart';
import '../widgets/category_pie_chart.dart';
import '../widgets/top_list_widget.dart';
import '../../../app/app_navigation.dart';
import '../../sales/presentation/sale_history_screen.dart';

class InventoryReportView extends StatelessWidget {
  final ReportFunctions functions;

  const InventoryReportView({super.key, required this.functions});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding20,
        vertical: AppSizes.padding10,
      ),
      children: [
        SummaryCardGrid(metrics: functions.getInventorySummaryMetrics()),
        const SizedBox(height: AppSizes.padding20),
        TrendBarChart(
          title: "Inventory Trend",
          data: functions.getInventoryTrendData(),
          barColor: const Color(0xFFBDB2EB), // Light purple
          highlightBarColor: const Color(0xFF4C2DB3), // Dark purple
        ),
        const SizedBox(height: AppSizes.padding20),
        CategoryPieChart(
          title: "Stock by Category",
          data: functions.getStockByCategoryData(),
          centerTitle: functions.getTotalStock().toString(),
          centerSubtitle: "Total",
        ),
        const SizedBox(height: AppSizes.padding20),
        TopListWidget(
          title: "Top Low Stock Products",
          items: functions.getTopLowStockProducts(),
          onViewAll: () {
            AppNavigation.goToScreen(context, const SaleHistoryScreen());
          },
        ),
        const SizedBox(height: 100), // Padding for bottom nav
      ],
    );
  }
}
