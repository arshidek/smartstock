import 'package:flutter/material.dart';
import '../../../core/services/product_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/product_model.dart';
import '../widgets/summary_card_grid.dart';
import '../widgets/trend_bar_chart.dart';
import '../widgets/category_pie_chart.dart';

class InventoryReportFunctions {
  final ProductService _productService = ProductService();
  CategoryService get _categoryService => CategoryService();

  int getTotalStock() {
    return _productService.getAllProducts().fold(0, (sum, p) => sum + p.stock);
  }

  List<SummaryMetric> getInventorySummaryMetrics() {
    final products = _productService.getAllProducts();
    final categories = _categoryService.getAllCategories();
    int lowStock = 0, outOfStock = 0;

    for (var p in products) {
      if (p.stock <= 5 && p.stock > 0)
        lowStock++;
      else if (p.stock == 0)
        outOfStock++;
    }

    return [
      SummaryMetric(
        icon: Icons.grid_view_outlined,
        title: "Total Products",
        value: products.length.toString(),
        percentage: 0.0,
        isPositive: true,
        iconColor: AppColors.blue,
        iconBackgroundColor: AppColors.lightBlue,
      ),
      SummaryMetric(
        icon: Icons.warning_amber_rounded,
        title: "Low Stock",
        value: lowStock.toString(),
        percentage: 0.0,
        isPositive: false,
        iconColor: AppColors.warning,
        iconBackgroundColor: AppColors.warning.withValues(alpha: 0.15),
      ),
      SummaryMetric(
        icon: Icons.block_outlined,
        title: "Out of Stock",
        value: outOfStock.toString(),
        percentage: 0.0,
        isPositive: false,
        iconColor: AppColors.error,
        iconBackgroundColor: AppColors.lightRed,
      ),
      SummaryMetric(
        icon: Icons.local_offer_outlined,
        title: "Categories",
        value: categories.length.toString(),
        percentage: 0.0,
        isPositive: true,
        iconColor: AppColors.purple,
        iconBackgroundColor: AppColors.lightPurple,
      ),
    ];
  }

  List<ChartDataPoint> getInventoryTrendData({DateTime? selectedDate}) {
    final products = _productService.getAllProducts();
    DateTime now = selectedDate ?? DateTime.now();
    List<ChartDataPoint> trendData = [];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    for (int i = 6; i >= 0; i--) {
      DateTime target = now.subtract(Duration(days: i));
      int dailyAdded = 0;
      for (var p in products) {
        if (p.createdAt.year == target.year &&
            p.createdAt.month == target.month &&
            p.createdAt.day == target.day) {
          dailyAdded += p.stock;
        }
      }
      trendData.add(
        ChartDataPoint(
          label: days[target.weekday - 1],
          value: dailyAdded.toDouble(),
        ),
      );
    }
    return trendData;
  }

  List<PieChartDataPoint> getStockByCategoryData() {
    final products = _productService.getAllProducts();
    final categories = _categoryService.getAllCategories();
    if (products.isEmpty) {
      return [
        PieChartDataPoint(label: 'Empty', value: 1, color: AppColors.grey),
      ];
    }

    Map<String, int> catStock = {};
    for (var p in products) {
      catStock[p.categoryId] = (catStock[p.categoryId] ?? 0) + p.stock;
    }

    final colors = [
      AppColors.blue,
      AppColors.success,
      AppColors.purple,
      AppColors.warning,
      AppColors.error,
    ];
    int colorIndex = 0;
    int total = catStock.values.fold(0, (s, v) => s + v);

    return catStock.entries.map((entry) {
      final category = categories.firstWhere(
        (c) => c.id == entry.key,
        orElse: () => categories.first,
      );
      final percentage = total == 0 ? 0.0 : (entry.value / total) * 100;
      return PieChartDataPoint(
        label: category.name,
        value: entry.value.toDouble(),
        color: colors[colorIndex++ % colors.length],
        suffix: '(${percentage.toStringAsFixed(0)}%)',
      );
    }).toList();
  }

  List<ProductModel> getTopLowStockProducts() {
    final products = _productService.getAllProducts();
    final lowStockProducts = products
        .where((p) => p.stock > 0 && p.stock <= 5)
        .toList();
    lowStockProducts.sort((a, b) => a.stock.compareTo(b.stock));
    return lowStockProducts.take(5).toList();
  }
}
