import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../core/services/product_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/summary_card_grid.dart';
import '../widgets/trend_bar_chart.dart';
import '../widgets/category_pie_chart.dart';
import '../widgets/top_list_widget.dart';
import '../../../app/app_navigation.dart';
import '../../product/presentation/product_detail_screen.dart';
import 'report_ui_helpers.dart';

class InventoryReportLogic {
  final ProductService _productService = ProductService();
  CategoryService get _categoryService => CategoryService();

  int getTotalStock() {
    return _productService.getAllProducts().fold(0, (sum, p) => sum + p.stock);
  }

  List<SummaryMetric> getInventorySummaryMetrics() {
    final products = _productService.getAllProducts();
    final categories = _categoryService.getAllCategories();

    int currentLowStock = 0;
    int outOfStock = 0;

    for (var p in products) {
      if (p.stock <= 5 && p.stock > 0) {
        currentLowStock++;
      } else if (p.stock == 0) {
        outOfStock++;
      }
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
        value: currentLowStock.toString(),
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

    for (int i = 6; i >= 0; i--) {
      DateTime targetDate = now.subtract(Duration(days: i));
      int dailyAdded = 0;

      for (var p in products) {
        if (p.createdAt.year == targetDate.year &&
            p.createdAt.month == targetDate.month &&
            p.createdAt.day == targetDate.day) {
          dailyAdded += p.stock;
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
      trendData.add(ChartDataPoint(label: label, value: dailyAdded.toDouble()));
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

    Map<String, int> categoryStock = {};
    for (var p in products) {
      categoryStock[p.categoryId] =
          (categoryStock[p.categoryId] ?? 0) + p.stock;
    }

    final colors = [
      AppColors.blue,
      AppColors.success,
      AppColors.purple,
      AppColors.warning,
      AppColors.error,
    ];

    int colorIndex = 0;
    int totalStock = categoryStock.values.fold(0, (sum, val) => sum + val);

    return categoryStock.entries.map((entry) {
      final category = categories.firstWhere(
        (c) => c.id == entry.key,
        orElse: () => categories.first,
      );
      final percentage = totalStock == 0
          ? 0.0
          : (entry.value / totalStock) * 100;
      final color = colors[colorIndex % colors.length];
      colorIndex++;

      return PieChartDataPoint(
        label: category.name,
        value: entry.value.toDouble(),
        color: color,
        suffix: '(${percentage.toStringAsFixed(0)}%)',
      );
    }).toList();
  }

  List<TopListItemModel> getTopLowStockProducts(BuildContext context) {
    final products = _productService.getAllProducts();
    final lowStockProducts = products
        .where((p) => p.stock > 0 && p.stock <= 5)
        .toList();
    lowStockProducts.sort((a, b) => a.stock.compareTo(b.stock));

    return lowStockProducts.take(5).map((p) {
      return TopListItemModel(
        leading: ReportUiHelpers.buildProductImage(p.imagePath),
        title: p.name,
        subtitle: "",
        onTap: () {
          AppNavigation.goToScreen(context, ProductDetailScreen(product: p));
        },
        trailing: Text(
          "${p.stock} units left",
          style: const TextStyle(
            color: AppColors.error,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.font14,
          ),
        ),
      );
    }).toList();
  }
}
