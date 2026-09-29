import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../app/app_navigation.dart';
import '../../../../sales/presentation/sale_history/sale_history_screen.dart';
import '../../../widgets/report_ui_helpers.dart';
import '../../../function/revenue_report_functions.dart';
import '../../../function/top_selling_report_functions.dart';
import '../../../widgets/summary_card_grid.dart';
import '../../../widgets/trend_bar_chart.dart';
import '../../../widgets/category_pie_chart.dart';
import '../../../widgets/top_list_widget.dart';

class MobileRevenueReportView extends StatelessWidget {
  final RevenueReportFunctions functions;
  final TopSellingReportFunctions topSellingFunctions;
  final DateTime? selectedDate;
  final VoidCallback? onDateTap;

  const MobileRevenueReportView({
    super.key,
    required this.functions,
    required this.topSellingFunctions,
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
        SummaryCardGrid(
          metrics: functions.getRevenueSummaryMetrics(
            selectedDate: selectedDate,
          ),
        ),
        const SizedBox(height: AppSizes.padding20),
        TrendBarChart(
          title: "Revenue Trend",
          data: functions.getRevenueTrendData(selectedDate: selectedDate),
          barColor: AppColors.lightBlue,
          highlightBarColor: AppColors.grey,
          selectedDate: selectedDate,
          onDateTap: onDateTap,
        ),
        const SizedBox(height: AppSizes.padding20),
        CategoryPieChart(
          title: "Revenue by Category",
          data: functions.getRevenueByCategoryData(selectedDate: selectedDate),
          centerTitle:
              "₹${functions.getTotalRevenue(selectedDate: selectedDate).toStringAsFixed(0)}",
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
                    fontSize: AppSizes.font12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "ORDERS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: AppSizes.font10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "REVENUE %",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: AppSizes.font10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          items: topSellingFunctions
              .getTopSellingProducts(selectedDate: selectedDate)
              .map(
                (data) => ReportUiHelpers.mapTopSelling(
                  data.agg,
                  data.productModel,
                  data.percentage,
                  context,
                ),
              )
              .toList(),
          onViewAll: () {
            AppNavigation.goToScreen(context, const SaleHistoryScreen());
          },
        ),
        const SizedBox(height: AppSizes.padding20),
      ],
    );
  }
}
