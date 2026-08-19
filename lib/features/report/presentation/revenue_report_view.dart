import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../function/report_functions.dart';
import '../widgets/summary_card_grid.dart';
import '../widgets/trend_bar_chart.dart';
import '../widgets/category_pie_chart.dart';
import '../widgets/top_list_widget.dart';
import '../../../app/app_navigation.dart';
import '../../sales/presentation/sale_history_screen.dart';
import '../../../core/widgets/filters/app_filter_bottom_sheet.dart';

class RevenueReportView extends StatelessWidget {
  final ReportFunctions functions;

  const RevenueReportView({super.key, required this.functions});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding20,
        vertical: AppSizes.padding10,
      ),
      children: [
        SummaryCardGrid(metrics: functions.getRevenueSummaryMetrics()),
        const SizedBox(height: AppSizes.padding20),
        TrendBarChart(
          title: "Revenue Trend",
          data: functions.getRevenueTrendData(),
          barColor: AppColors.grey.withValues(alpha: 0.3),
          highlightBarColor: const Color(0xFF4C2DB3), // Dark purple
        ),
        const SizedBox(height: AppSizes.padding20),
        CategoryPieChart(
          title: "Revenue by Category",
          data: functions.getRevenueByCategoryData(),
          centerTitle: "₹${functions.getTotalRevenue().toStringAsFixed(0)}",
          centerSubtitle: "Total",
        ),
        const SizedBox(height: AppSizes.padding20),
        TopListWidget(
          title: "Top Selling Products",
          headerRow: const Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "PRODUCT",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "ORDERS",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "REVENUE% OF TOTAL",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          items: functions.getTopSellingProducts(),
          onViewAll: () {
            AppNavigation.goToScreen(context, const SaleHistoryScreen());
          },
        ),
        const SizedBox(height: 100), // Padding for bottom nav
      ],
    );
  }
}
