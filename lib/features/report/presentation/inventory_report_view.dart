import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../function/inventory_report_logic.dart';
import '../widgets/summary_card_grid.dart';
import '../widgets/trend_bar_chart.dart';
import '../widgets/category_pie_chart.dart';
import '../widgets/top_list_widget.dart';
import '../../../app/app_navigation.dart';
import '../../stock/presentation/stock_management_screen.dart';
import '../../../core/responsive/responsive.dart';

class InventoryReportView extends StatelessWidget {
  final InventoryReportLogic functions;
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
      padding: const EdgeInsets.only(
        left: AppSizes.padding20,
        right: AppSizes.padding20,
        top: AppSizes.padding10,
        bottom: 100, // clears the bottom nav bar
      ),
      children: [
        SummaryCardGrid(metrics: functions.getInventorySummaryMetrics()),
        const SizedBox(height: AppSizes.padding20),
        TrendBarChart(
          title: "Inventory Trend",
          data: functions.getInventoryTrendData(selectedDate: selectedDate),
          barColor: AppColors.lightPurple,
          highlightBarColor: AppColors.grey,
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
            items: functions.getTopLowStockProducts(context),
            onViewAll: () {
              AppNavigation.goToScreen(
                context,
                const StockManagementScreen(stockType: StockType.lowStock),
              );
            },
          ),
        ] else ...[
          SizedBox(
            height: 380,
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
                    items: functions.getTopLowStockProducts(context),
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
        const SizedBox(height: AppSizes.padding20),
      ],
    );
  }
}
