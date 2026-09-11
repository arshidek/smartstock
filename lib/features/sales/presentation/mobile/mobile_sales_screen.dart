import 'package:flutter/material.dart';
import '../../../../app/app_navigation.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/services/sale_service.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/cards/app_card_widget.dart';
import '../../../../data/models/sale_model.dart';
import '../../../../core/widgets/dialogs/app_delete_dialog.dart';
import '../../widgets/AppSaleCard.dart';
import '../update_sale_screen.dart';
import '../sale_details_screen.dart';
import '../sale_history_screen.dart';
import '../../widgets/today_summary_card.dart';
import '../widgets/sales_stats_grid.dart';

class MobileSalesScreen extends StatelessWidget {
  final List<SaleModel> sales;
  final int totalSales;
  final double totalAmount;
  final int totalProductsSold;
  final String latestSaleProduct;
  final Map<String, dynamic> todaySummary;
  final VoidCallback onLoadSales;

  const MobileSalesScreen({
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
                  AppNavigation.goToScreen(
                    context,
                    const SaleHistoryScreen(),
                  );
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

  Widget _buildRecentSales(BuildContext context) {
    if (sales.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: AppSizes.padding48),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius18),
        ),
        child: const Column(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: AppSizes.size60,
              color: AppColors.grey,
            ),
            SizedBox(height: 12),
            Text(
              "No Sales Found",
              style: TextStyle(
                fontSize: AppSizes.font18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    final recentSales = sales.reversed.take(5).toList();

    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recentSales.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSizes.size8),
      itemBuilder: (context, index) {
        final sale = recentSales[index];
        final item = sale.items.first;

        return AppSaleCard(
          imagePath: item.imagePath,
          productName: item.productName,
          invoiceNo: sale.invoiceNo,
          brandName: item.brandName,
          categoryName: item.categoryName,
          date:
              "${sale.saleDate.day} ${['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][sale.saleDate.month - 1]} ${sale.saleDate.year}",
          paymentMethod: sale.paymentMethod,
          quantity: item.quantity,
          amount: "₹${item.totalPrice.toStringAsFixed(2)}",
          profit: "₹${item.profit.toStringAsFixed(2)}",
          showMenu: true,
          onUpdate: () async {
            final result = await AppNavigation.goToScreen(
              context,
              UpdateSaleScreen(sale: sale),
            );
            if (result == true) {
              onLoadSales();
            }
          },
          onDelete: () async {
            final confirm = await AppDeleteDialog.show(
              context: context,
              title: "Delete Sale",
              message: "Are you sure you want to delete this sale?",
            );

            if (confirm == true) {
              await SaleService().deleteSale(sale.id);
              onLoadSales();
              AppSnackBar.success(context, "Sale deleted successfully.");
            }
          },
          onTap: () {
            AppNavigation.goToScreen(
              context,
              SaleDetailsScreen(sale: sale),
            );
          },
        );
      },
    );
  }

  Widget _buildTodaySummary() {
    return AppCardWidget(
      margin: const EdgeInsets.only(top: 14, bottom: 80),
      backgroundColor: AppColors.lightBlue,
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.analytics_outlined,
                color: AppColors.purple,
                size: AppSizes.size25,
              ),
              const SizedBox(width: AppSizes.size10),
              const Expanded(
                child: Text(
                  "Today's Summary",
                  style: TextStyle(
                    fontSize: AppSizes.font20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "${DateTime.now().day} ${['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][DateTime.now().month - 1]} ${DateTime.now().year}",
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: AppSizes.font13,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.size20),
          const Divider(),
          const SizedBox(height: AppSizes.size20),
          Row(
            children: [
              Expanded(
                child: TodaySummaryCard(
                  title: "TXNS",
                  value: "${todaySummary["transactions"] ?? 0}",
                  valueColor: AppColors.black,
                ),
              ),
              Expanded(
                child: TodaySummaryCard(
                  title: "AMOUNT",
                  value:
                      "₹${(todaySummary["amount"] ?? 0).toStringAsFixed(0)}",
                  valueColor: AppColors.black,
                ),
              ),
              Expanded(
                child: TodaySummaryCard(
                  title: "QTY",
                  value: "${todaySummary["quantity"] ?? 0}",
                  valueColor: AppColors.black,
                ),
              ),
              Expanded(
                child: TodaySummaryCard(
                  title: "PROFIT",
                  value:
                      "₹${(todaySummary["profit"] ?? 0).toStringAsFixed(0)}",
                  valueColor: AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
