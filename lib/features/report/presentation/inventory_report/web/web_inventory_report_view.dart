import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../stock/presentation/stock_management_screen/stock_management_screen.dart';
import '../../../../../app/app_navigation.dart';
import '../../../widgets/report_ui_helpers.dart';
import '../../../function/inventory_report_functions.dart';
import '../../../widgets/summary_card_grid.dart';
import '../../../widgets/trend_bar_chart.dart';
import '../../../widgets/category_pie_chart.dart';
import '../../../widgets/top_list_widget.dart';

class WebInventoryReportView extends StatelessWidget {
  final InventoryReportFunctions functions;
  final DateTime? selectedDate;
  final VoidCallback? onDateTap;

  const WebInventoryReportView({
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
        bottom: 100,
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
                  items: functions
                      .getTopLowStockProducts()
                      .take(5)
                      .map((p) => ReportUiHelpers.mapLowStock(p, context))
                      .toList(),
                  onViewAll: () {
                    AppNavigation.goToScreen(
                      context,
                      const StockManagementScreen(
                        stockType: StockType.lowStock,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.padding20),
      ],
    );
  }
}
