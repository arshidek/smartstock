import 'package:flutter/material.dart';
import '../../../../../app/app_navigation.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/services/sale_service.dart';
import '../../../../../core/utils/app_snack_bar.dart';
import '../../../../../core/widgets/cards/app_card_widget.dart';
import '../../../../../data/models/sale_model.dart';
import '../../../../../core/widgets/dialogs/app_delete_dialog.dart';
import '../../../widgets/app_sale_card.dart';
import '../../update_sale/update_sale_screen.dart';
import '../../sale_details/sale_details_screen.dart';
import '../../sale_history/sale_history_screen.dart';
import '../../../widgets/today_summary_card.dart';
import '../../../widgets/sales_stats_grid.dart';

part 'web_sales_screen_ui.dart';

class WebSalesScreen extends StatelessWidget {
  final List<SaleModel> sales;
  final int totalSales;
  final double totalAmount;
  final int totalProductsSold;
  final String latestSaleProduct;
  final Map<String, dynamic> todaySummary;
  final VoidCallback onLoadSales;

  const WebSalesScreen({
    super.key,
    required this.sales,
    required this.totalSales,
    required this.totalAmount,
    required this.totalProductsSold,
    required this.latestSaleProduct,
    required this.todaySummary,
    required this.onLoadSales,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSizes.size20),
          SalesStatsGrid(
            totalSales: totalSales,
            totalAmount: totalAmount,
            totalProductsSold: totalProductsSold,
            latestSaleProduct: latestSaleProduct,
          ),
          const SizedBox(height: AppSizes.size25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Sales",
                style: TextStyle(
                  fontSize: AppSizes.font18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  AppNavigation.goToScreen(context, const SaleHistoryScreen());
                },
                child: const Text(
                  "View All",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.size15),
          _buildRecentSales(context),
          _buildTodaySummary(),
        ],
      ),
    );
  }
}
