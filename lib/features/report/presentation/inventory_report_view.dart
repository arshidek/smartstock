import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../function/report_functions.dart';
import '../widgets/summary_card_grid.dart';
import '../widgets/trend_bar_chart.dart';
import '../widgets/category_pie_chart.dart';
import '../widgets/top_list_widget.dart';
import '../../../app/app_navigation.dart';
import '../../stock/presentation/stock_management_screen.dart';
import '../../../core/responsive/responsive.dart';

class InventoryReportView extends StatelessWidget {
  final ReportFunctions functions;
  final DateTime? selectedDate;
  final VoidCallback? onDateTap;

  const InventoryReportView({
    super.key,
    required this.functions,
    this.selectedDate,
    this.onDateTap,
  });

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
          data: functions.getInventoryTrendData(selectedDate: selectedDate),
          barColor: const Color(0xFFBDB2EB), // Light purple
          highlightBarColor: const Color(0xFF4C2DB3), // Dark purple
          selectedDate: selectedDate,
          onDateTap: onDateTap,
        ),
        const SizedBox(height: AppSizes.padding20),
        if (Responsive.isMobile(context)) ...[
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
              AppNavigation.goToScreen(
                context,
                const StockManagementScreen(stockType: StockType.lowStock),
              );
            },
          ),
        ] else ...[
          SizedBox(
            height: 380, // Fixed height to match both cards
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CategoryPieChart(
                    title: "Stock by Category",
                    data: functions.getStockByCategoryData(),
                    centerTitle: functions.getTotalStock().toString(),
                    centerSubtitle: "Total",
                  ),
                ),
                const SizedBox(width: AppSizes.padding20),
                Expanded(
                  child: TopListWidget(
                    title: "Top Low Stock Products",
                    items: functions.getTopLowStockProducts(),
                    onViewAll: () {
                      AppNavigation.goToScreen(
                        context,
                        const StockManagementScreen(stockType: StockType.lowStock),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: AppSizes.padding20), // Reduced padding
      ],
    );
  }
}
