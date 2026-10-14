import 'package:flutter/material.dart';
import '../../../core/services/sale_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/summary_card_grid.dart';
import '../widgets/trend_bar_chart.dart';
import '../widgets/category_pie_chart.dart';

class RevenueReportFunctions {
  final SaleService _saleService = SaleService();
  CategoryService get _categoryService => CategoryService();

  List<SummaryMetric> getRevenueSummaryMetrics({DateTime? selectedDate}) {
    final sales = _saleService.getAllSales();
    final now = selectedDate ?? DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final sixtyDaysAgo = now.subtract(const Duration(days: 60));

    double curRev = 0, curProf = 0, prevRev = 0, prevProf = 0;
    int curOrd = 0, prevOrd = 0;

    for (var s in sales) {
      bool isCur =
          (s.saleDate.isAfter(thirtyDaysAgo) ||
              s.saleDate.isAtSameMomentAs(thirtyDaysAgo)) &&
          (s.saleDate.isBefore(now) || s.saleDate.isAtSameMomentAs(now));
      bool isPrev =
          (s.saleDate.isAfter(sixtyDaysAgo) ||
              s.saleDate.isAtSameMomentAs(sixtyDaysAgo)) &&
          s.saleDate.isBefore(thirtyDaysAgo);
      if (isCur) {
        curRev += s.grandTotal;
        curProf += s.totalProfit;
        curOrd++;
      } else if (isPrev) {
        prevRev += s.grandTotal;
        prevProf += s.totalProfit;
        prevOrd++;
      }
    }

    double curAvg = curOrd == 0 ? 0 : curRev / curOrd;
    double prevAvg = prevOrd == 0 ? 0 : prevRev / prevOrd;
    double revGrow = prevRev == 0 ? 0.0 : ((curRev - prevRev) / prevRev) * 100;
    double ordGrow = prevOrd == 0 ? 0.0 : ((curOrd - prevOrd) / prevOrd) * 100;
    double avgGrow = prevAvg == 0 ? 0.0 : ((curAvg - prevAvg) / prevAvg) * 100;
    double profGrow = prevProf == 0
        ? 0.0
        : ((curProf - prevProf) / prevProf) * 100;

    return [
      SummaryMetric(
        icon: Icons.currency_rupee,
        title: "Revenue (30d)",
        value: "₹${curRev.toStringAsFixed(0)}",
        percentage: double.parse(revGrow.abs().toStringAsFixed(1)),
        isPositive: revGrow >= 0,
        iconColor: AppColors.purple,
        iconBackgroundColor: AppColors.lightPurple,
        subtitle: "Total Revenue",
      ),
      SummaryMetric(
        icon: Icons.shopping_bag_outlined,
        title: "Orders (30d)",
        value: curOrd.toString(),
        percentage: double.parse(ordGrow.abs().toStringAsFixed(1)),
        isPositive: ordGrow >= 0,
        iconColor: AppColors.darkGreen,
        iconBackgroundColor: AppColors.lightDarkGreen,
        subtitle: "Completed Orders",
      ),
      SummaryMetric(
        icon: Icons.receipt_long_outlined,
        title: "Avg Order Value",
        value: "₹${curAvg.toStringAsFixed(0)}",
        percentage: double.parse(avgGrow.abs().toStringAsFixed(1)),
        isPositive: avgGrow >= 0,
        iconColor: AppColors.warning,
        iconBackgroundColor: AppColors.lightWarning,
        subtitle: "Per Order",
      ),
      SummaryMetric(
        icon: Icons.account_balance_wallet_outlined,
        title: "Net Profit (30d)",
        value: "₹${curProf.toStringAsFixed(0)}",
        percentage: double.parse(profGrow.abs().toStringAsFixed(1)),
        isPositive: profGrow >= 0,
        iconColor: AppColors.success,
        iconBackgroundColor: AppColors.success.withValues(alpha: 0.2),
        subtitle: "Overall Profit",
      ),
    ];
  }

  List<ChartDataPoint> getRevenueTrendData({DateTime? selectedDate}) {
    final sales = _saleService.getAllSales();
    DateTime now = selectedDate ?? DateTime.now();
    List<ChartDataPoint> trendData = [];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    for (int i = 6; i >= 0; i--) {
      DateTime target = now.subtract(Duration(days: i));
      double dailyTotal = 0;
      for (var s in sales) {
        if (s.saleDate.year == target.year &&
            s.saleDate.month == target.month &&
            s.saleDate.day == target.day) {
          dailyTotal += s.grandTotal;
        }
      }
      trendData.add(
        ChartDataPoint(label: days[target.weekday - 1], value: dailyTotal),
      );
    }
    return trendData;
  }

  List<PieChartDataPoint> getRevenueByCategoryData({DateTime? selectedDate}) {
    final categories = _categoryService.getAllCategories();
    final sales = _saleService.getAllSales();
    final now = selectedDate ?? DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    Map<String, double> catRev = {for (var cat in categories) cat.name: 0.0};
    double totalRev = 0;

    for (var s in sales) {
      if ((s.saleDate.isAfter(thirtyDaysAgo) ||
              s.saleDate.isAtSameMomentAs(thirtyDaysAgo)) &&
          (s.saleDate.isBefore(now) || s.saleDate.isAtSameMomentAs(now))) {
        for (var item in s.items) {
          catRev[item.categoryName] =
              (catRev[item.categoryName] ?? 0.0) + item.totalPrice;
          totalRev += item.totalPrice;
        }
      }
    }

    final colors = [
      AppColors.blue,
      AppColors.success,
      AppColors.purple,
      AppColors.warning,
      AppColors.error,
      AppColors.darkGreen,
    ];
    List<PieChartDataPoint> result = [];
    int colorIdx = 0;

    for (var entry in catRev.entries) {
      double pct = totalRev == 0 ? 0 : (entry.value / totalRev) * 100;
      result.add(
        PieChartDataPoint(
          label: '${entry.key} (${pct.toStringAsFixed(1)}%)',
          value: entry.value,
          color: colors[colorIdx++ % colors.length],
          suffix: '₹${entry.value.toStringAsFixed(0)}',
        ),
      );
    }
    result.sort((a, b) => b.value.compareTo(a.value));
    return result;
  }

  double getTotalRevenue({DateTime? selectedDate}) {
    final sales = _saleService.getAllSales();
    final now = selectedDate ?? DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    double total = 0;
    for (var s in sales) {
      if ((s.saleDate.isAfter(thirtyDaysAgo) ||
              s.saleDate.isAtSameMomentAs(thirtyDaysAgo)) &&
          (s.saleDate.isBefore(now) || s.saleDate.isAtSameMomentAs(now))) {
        total += s.grandTotal;
      }
    }
    return total;
  }
}
