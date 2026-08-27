import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../sales/presentation/sale_history_screen.dart';
import '../function/report_functions.dart';
import '../widgets/summary_card_grid.dart';
import '../widgets/trend_bar_chart.dart';
import '../widgets/category_pie_chart.dart';
import '../widgets/top_list_widget.dart';
import '../../../app/app_navigation.dart';
import '../../sales/presentation/sale_history_screen.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/filters/app_filter_bottom_sheet.dart';

class RevenueReportView extends StatelessWidget {
  final ReportFunctions functions;
  final DateTime? selectedDate;
  final VoidCallback? onDateTap;

  const RevenueReportView({
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
        SummaryCardGrid(
          metrics: functions.getRevenueSummaryMetrics(
            selectedDate: selectedDate,
          ),
        ),
        const SizedBox(height: AppSizes.padding20),
        TrendBarChart(
          title: "Revenue Trend",
          data: functions.getRevenueTrendData(selectedDate: selectedDate),
          barColor: AppColors.grey.withValues(alpha: 0.3),
          highlightBarColor: const Color(0xFF4C2DB3), // Dark purple
          selectedDate: selectedDate,
          onDateTap: onDateTap,
        ),
        const SizedBox(height: AppSizes.padding20),
        if (Responsive.isMobile(context)) ...[
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
                      fontSize: 12,
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
                      fontSize: 10,
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
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            items: functions.getTopSellingProducts(selectedDate: selectedDate),
            onViewAll: () {
              AppNavigation.goToScreen(context, const SaleHistoryScreen());
            },
          ),
        ] else ...[
          SizedBox(
            height: 420, // Fixed height to match both cards
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CategoryPieChart(
                    title: "Revenue by Category",
                    data: functions.getRevenueByCategoryData(selectedDate: selectedDate),
                    centerTitle:
                        "₹${functions.getTotalRevenue(selectedDate: selectedDate).toStringAsFixed(0)}",
                    centerSubtitle: "Total",
                  ),
                ),
                const SizedBox(width: AppSizes.padding20),
                Expanded(
                  child: TopListWidget(
                    title: "Top Selling Products",
                    headerRow: const Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "PRODUCT",
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 12,
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
                              fontSize: 10,
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
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    items: functions.getTopSellingProducts(selectedDate: selectedDate),
                    onViewAll: () {
                      AppNavigation.goToScreen(context, const SaleHistoryScreen());
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
