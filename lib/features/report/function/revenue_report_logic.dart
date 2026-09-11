import 'package:flutter/material.dart';
import '../../../core/services/sale_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/summary_card_grid.dart';
import '../widgets/trend_bar_chart.dart';
import '../widgets/category_pie_chart.dart';

class RevenueReportLogic {
  final SaleService _saleService = SaleService();
  CategoryService get _categoryService => CategoryService();

  List<SummaryMetric> getRevenueSummaryMetrics({DateTime? selectedDate}) {
    final sales = _saleService.getAllSales();
    final now = selectedDate ?? DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final sixtyDaysAgo = now.subtract(const Duration(days: 60));

    double currentRevenue = 0;
    double currentNetProfit = 0;
    int currentOrders = 0;

    double previousRevenue = 0;
    double previousNetProfit = 0;
    int previousOrders = 0;

    for (var s in sales) {
      if ((s.saleDate.isAfter(thirtyDaysAgo) ||
              s.saleDate.isAtSameMomentAs(thirtyDaysAgo)) &&
          (s.saleDate.isBefore(now) || s.saleDate.isAtSameMomentAs(now))) {
        currentRevenue += s.grandTotal;
        currentNetProfit += s.totalProfit;
        currentOrders++;
      } else if ((s.saleDate.isAfter(sixtyDaysAgo) ||
              s.saleDate.isAtSameMomentAs(sixtyDaysAgo)) &&
          s.saleDate.isBefore(thirtyDaysAgo)) {
        previousRevenue += s.grandTotal;
        previousNetProfit += s.totalProfit;
        previousOrders++;
      }
    }

    double currentAvgOrderValue = currentOrders == 0
        ? 0
        : currentRevenue / currentOrders;
    double previousAvgOrderValue = previousOrders == 0
        ? 0
        : previousRevenue / previousOrders;

    double revGrowth = previousRevenue == 0
        ? 0.0
        : ((currentRevenue - previousRevenue) / previousRevenue) * 100;
    double ordersGrowth = previousOrders == 0
        ? 0.0
        : ((currentOrders - previousOrders) / previousOrders) * 100;
    double avgOrderGrowth = previousAvgOrderValue == 0
        ? 0.0
        : ((currentAvgOrderValue - previousAvgOrderValue) /
                  previousAvgOrderValue) *
              100;
    double profitGrowth = previousNetProfit == 0
        ? 0.0
        : ((currentNetProfit - previousNetProfit) / previousNetProfit) * 100;

    return [
      SummaryMetric(
        icon: Icons.currency_rupee,
        title: "Revenue (30d)",
        value: "₹${currentRevenue.toStringAsFixed(0)}",
        percentage: double.parse(revGrowth.abs().toStringAsFixed(1)),
        isPositive: revGrowth >= 0,
        iconColor: AppColors.purple,
        iconBackgroundColor: AppColors.lightPurple,
      ),
      SummaryMetric(
        icon: Icons.shopping_bag_outlined,
        title: "Orders (30d)",
        value: currentOrders.toString(),
        percentage: double.parse(ordersGrowth.abs().toStringAsFixed(1)),
        isPositive: ordersGrowth >= 0,
        iconColor: AppColors.darkGreen,
        iconBackgroundColor: AppColors.lightDarkGreen,
      ),
      SummaryMetric(
        icon: Icons.receipt_long_outlined,
        title: "Avg Order Value",
        value: "₹${currentAvgOrderValue.toStringAsFixed(0)}",
        percentage: double.parse(avgOrderGrowth.abs().toStringAsFixed(1)),
        isPositive: avgOrderGrowth >= 0,
        iconColor: AppColors.warning,
        iconBackgroundColor: AppColors.lightWarning,
      ),
      SummaryMetric(
        icon: Icons.account_balance_wallet_outlined,
        title: "Net Profit (30d)",
        value: "₹${currentNetProfit.toStringAsFixed(0)}",
        percentage: double.parse(profitGrowth.abs().toStringAsFixed(1)),
        isPositive: profitGrowth >= 0,
        iconColor: AppColors.success,
        iconBackgroundColor: AppColors.success.withValues(alpha: 0.2),
      ),
    ];
  }

  List<ChartDataPoint> getRevenueTrendData({DateTime? selectedDate}) {
    final sales = _saleService.getAllSales();
    DateTime now = selectedDate ?? DateTime.now();
    List<ChartDataPoint> trendData = [];

    for (int i = 6; i >= 0; i--) {
      DateTime targetDate = now.subtract(Duration(days: i));
      double dailyTotal = 0;

      for (var s in sales) {
        if (s.saleDate.year == targetDate.year &&
            s.saleDate.month == targetDate.month &&
            s.saleDate.day == targetDate.day) {
          dailyTotal += s.grandTotal;
        }
      }

      String label = [
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat',
        'Sun',
      ][targetDate.weekday - 1];
      trendData.add(ChartDataPoint(label: label, value: dailyTotal));
    }

    return trendData;
  }

  List<PieChartDataPoint> getRevenueByCategoryData({DateTime? selectedDate}) {
    final categories = _categoryService.getAllCategories();
    final sales = _saleService.getAllSales();
    final now = selectedDate ?? DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    Map<String, double> categoryRevenue = {};
    for (var cat in categories) {
      categoryRevenue[cat.name] = 0.0;
    }

    double totalRevenue = 0;

    for (var sale in sales) {
      if ((sale.saleDate.isAfter(thirtyDaysAgo) ||
              sale.saleDate.isAtSameMomentAs(thirtyDaysAgo)) &&
          (sale.saleDate.isBefore(now) ||
              sale.saleDate.isAtSameMomentAs(now))) {
        for (var item in sale.items) {
          String catName = item.categoryName;
          categoryRevenue[catName] =
              (categoryRevenue[catName] ?? 0.0) + item.totalPrice;
          totalRevenue += item.totalPrice;
        }
      }
    }

    List<Color> pieColors = [
      AppColors.blue,
      AppColors.success,
      AppColors.purple,
      AppColors.warning,
      AppColors.error,
      AppColors.darkGreen,
      AppColors.warning,
    ];

    List<PieChartDataPoint> result = [];
    int colorIndex = 0;

    for (var entry in categoryRevenue.entries) {
      double value = entry.value;
      double percentage = totalRevenue == 0 ? 0 : (value / totalRevenue) * 100;

      result.add(
        PieChartDataPoint(
          label: '${entry.key} (${percentage.toStringAsFixed(1)}%)',
          value: value,
          color: pieColors[colorIndex % pieColors.length],
          suffix: '₹${value.toStringAsFixed(0)}',
        ),
      );
      colorIndex++;
    }

    result.sort((a, b) => b.value.compareTo(a.value));
    return result;
  }

  double getTotalRevenue({DateTime? selectedDate}) {
    final sales = _saleService.getAllSales();
    final now = selectedDate ?? DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    double totalRevenue = 0;
    for (var s in sales) {
      if ((s.saleDate.isAfter(thirtyDaysAgo) ||
              s.saleDate.isAtSameMomentAs(thirtyDaysAgo)) &&
          (s.saleDate.isBefore(now) || s.saleDate.isAtSameMomentAs(now))) {
        totalRevenue += s.grandTotal;
      }
    }
    return totalRevenue;
  }
}
