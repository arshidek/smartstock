import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/widgets/cards/app_stats_card.dart';

class SalesStatsGrid extends StatelessWidget {
  final int totalSales;
  final double totalAmount;
  final int totalProductsSold;
  final String latestSaleProduct;

  const SalesStatsGrid({
    super.key,
    required this.totalSales,
    required this.totalAmount,
    required this.totalProductsSold,
    required this.latestSaleProduct,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: Responsive.isMobile(context)
          ? 0.9
          : Responsive.isTablet(context)
          ? 1.5
          : 1.6,
      children: [
        AppStatsCard(
          title: "TOTAL SALES",
          value: "$totalSales",
          subtitle: "Transactions",
          icon: Icons.shopping_cart_outlined,
          iconColor: AppColors.purple,
          iconBackgroundColor: AppColors.lightPurple,
        ),
        AppStatsCard(
          title: "TOTAL AMOUNT",
          value: "₹${totalAmount.toStringAsFixed(0)}",
          subtitle: "Sales Value",
          icon: Icons.account_balance_wallet_outlined,
          iconColor: AppColors.success,
          iconBackgroundColor: AppColors.lightGreen,
        ),
        AppStatsCard(
          title: "PRODUCTS SOLD",
          value: "$totalProductsSold",
          subtitle: "Items Sold",
          icon: Icons.widgets_outlined,
          iconColor: AppColors.warning,
          iconBackgroundColor: AppColors.lightWarning,
        ),
        AppStatsCard(
          title: "LATEST SALE",
          value: latestSaleProduct,
          valueFontSize: 18,
          subtitle: "Latest Item",
          icon: Icons.access_time,
          iconColor: AppColors.error,
          iconBackgroundColor: AppColors.lightRed,
        ),
      ],
    );
  }
}
