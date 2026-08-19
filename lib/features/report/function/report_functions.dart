import 'dart:io';
import 'package:flutter/material.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/sale_model.dart';
import '../../../core/services/product_service.dart';
import '../../../core/services/sale_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/summary_card_grid.dart';
import '../widgets/trend_bar_chart.dart';
import '../widgets/category_pie_chart.dart';
import '../widgets/top_list_widget.dart';

class ReportFunctions {
  final ProductService _productService = ProductService();
  final SaleService _saleService = SaleService();
  CategoryService get _categoryService => CategoryService();

  // --- INVENTORY METRICS ---

  int getTotalStock() {
    return _productService.getAllProducts().fold(0, (sum, p) => sum + p.stock);
  }

  List<SummaryMetric> getInventorySummaryMetrics() {
    final products = _productService.getAllProducts();
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    double currentInvValue = 0;
    int currentTotalStock = 0;
    int currentLowStock = 0;

    double previousInvValue = 0;
    int previousTotalStock = 0;
    int previousProductsCount = 0;

    for (var p in products) {
      double value = p.purchasePrice * p.stock;
      currentInvValue += value;
      currentTotalStock += p.stock;

      if (p.stock <= 5 && p.stock > 0) {
        currentLowStock++;
      }

      if (p.createdAt.isBefore(thirtyDaysAgo)) {
        previousInvValue += value; // Rough proxy since we lack stock history
        previousTotalStock += p.stock;
        previousProductsCount++;
      }
    }

    double invValueGrowth = previousInvValue == 0
        ? 0.0
        : ((currentInvValue - previousInvValue) / previousInvValue) * 100;
    double productsGrowth = previousProductsCount == 0
        ? 0.0
        : ((products.length - previousProductsCount) / previousProductsCount) *
              100;
    double stockGrowth = previousTotalStock == 0
        ? 0.0
        : ((currentTotalStock - previousTotalStock) / previousTotalStock) * 100;

    String formattedInvValue =
        "₹${(currentInvValue / 100000).toStringAsFixed(1)}L";
    if (currentInvValue < 100000) {
      formattedInvValue = "₹${currentInvValue.toStringAsFixed(0)}";
    }

    return [
      SummaryMetric(
        icon: Icons.account_balance_wallet_outlined,
        title: "Inv. Value",
        value: formattedInvValue,
        percentage: double.parse(invValueGrowth.abs().toStringAsFixed(1)),
        isPositive: invValueGrowth >= 0,
        iconColor: const Color(0xFF4C2DB3),
        iconBackgroundColor: const Color(0xFFF0EDFB),
      ),
      SummaryMetric(
        icon: Icons.widgets_outlined,
        title: "Products",
        value: products.length.toString(),
        percentage: double.parse(productsGrowth.abs().toStringAsFixed(1)),
        isPositive: productsGrowth >= 0,
        iconColor: const Color(0xFFB4783A),
        iconBackgroundColor: const Color(0xFFFAF4EE),
      ),
      SummaryMetric(
        icon: Icons.check_box_outlined,
        title: "Total Stock",
        value: currentTotalStock.toString(),
        percentage: double.parse(stockGrowth.abs().toStringAsFixed(1)),
        isPositive: stockGrowth >= 0,
        iconColor: const Color(0xFF4C2DB3),
        iconBackgroundColor: const Color(0xFFF0EDFB),
      ),
      SummaryMetric(
        icon: Icons.warning_amber_rounded,
        title: "Low Stock",
        value: currentLowStock.toString(),
        percentage:
            0.0, // Low stock growth is too volatile to proxy without history
        isPositive: false,
        iconColor: AppColors.error,
        iconBackgroundColor: AppColors.error.withValues(alpha: 0.1),
      ),
    ];
  }

  List<ChartDataPoint> getInventoryTrendData() {
    final products = _productService.getAllProducts();
    DateTime now = DateTime.now();
    List<ChartDataPoint> trendData = [];

    for (int i = 6; i >= 0; i--) {
      DateTime targetDate = now.subtract(Duration(days: i));
      int dailyAdded = 0;

      for (var p in products) {
        if (p.createdAt.year == targetDate.year &&
            p.createdAt.month == targetDate.month &&
            p.createdAt.day == targetDate.day) {
          dailyAdded += p.stock; // Approximating added inventory
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
      return [PieChartDataPoint(label: 'Empty', value: 1, color: Colors.grey)];
    }

    Map<String, int> categoryStock = {};
    for (var p in products) {
      categoryStock[p.categoryId] =
          (categoryStock[p.categoryId] ?? 0) + p.stock;
    }

    final colors = [
      const Color(0xFF4C2DB3),
      const Color(0xFF0F9D58),
      const Color(0xFF8B4513),
      const Color(0xFFF4B400),
      const Color(0xFFE91E63),
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

  List<TopListItemModel> getTopLowStockProducts() {
    final products = _productService.getAllProducts();
    final lowStockProducts = products
        .where((p) => p.stock > 0 && p.stock <= 5)
        .toList();
    lowStockProducts.sort(
      (a, b) => a.stock.compareTo(b.stock),
    ); // Sort by lowest stock first

    return lowStockProducts.take(4).map((p) {
      return TopListItemModel(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6FB),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.widgets_outlined,
            color: Color(0xFF4C2DB3),
            size: 20,
          ),
        ),
        title: p.name,
        subtitle: "SKU: ${p.barcode}",
        trailing: Text(
          "${p.stock} units left",
          style: const TextStyle(
            color: AppColors.error,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    }).toList();
  }

  // --- REVENUE METRICS ---

  List<SummaryMetric> getRevenueSummaryMetrics() {
    final sales = _saleService.getAllSales();
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final sixtyDaysAgo = now.subtract(const Duration(days: 60));

    double currentRevenue = 0;
    double currentNetProfit = 0;
    int currentOrders = 0;

    double previousRevenue = 0;
    double previousNetProfit = 0;
    int previousOrders = 0;

    for (var s in sales) {
      if (s.saleDate.isAfter(thirtyDaysAgo)) {
        currentRevenue += s.grandTotal;
        currentNetProfit += s.totalProfit;
        currentOrders++;
      } else if (s.saleDate.isAfter(sixtyDaysAgo) &&
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
        iconColor: const Color(0xFFAF52DE),
        iconBackgroundColor: const Color(0xFFF9F0FC),
      ),
      SummaryMetric(
        icon: Icons.shopping_bag_outlined,
        title: "Orders (30d)",
        value: currentOrders.toString(),
        percentage: double.parse(ordersGrowth.abs().toStringAsFixed(1)),
        isPositive: ordersGrowth >= 0,
        iconColor: const Color(0xFF2B88D8),
        iconBackgroundColor: const Color(0xFFEFF6FC),
      ),
      SummaryMetric(
        icon: Icons.receipt_long_outlined,
        title: "Avg Order Value",
        value: "₹${currentAvgOrderValue.toStringAsFixed(0)}",
        percentage: double.parse(avgOrderGrowth.abs().toStringAsFixed(1)),
        isPositive: avgOrderGrowth >= 0,
        iconColor: const Color(0xFFE88A31),
        iconBackgroundColor: const Color(0xFFFDF4EB),
      ),
      SummaryMetric(
        icon: Icons.account_balance_wallet_outlined,
        title: "Net Profit (30d)",
        value: "₹${currentNetProfit.toStringAsFixed(0)}",
        percentage: double.parse(profitGrowth.abs().toStringAsFixed(1)),
        isPositive: profitGrowth >= 0,
        iconColor: AppColors.success,
        iconBackgroundColor: AppColors.success.withValues(alpha: 0.1),
      ),
    ];
  }

  List<ChartDataPoint> getRevenueTrendData() {
    final sales = _saleService.getAllSales();

    // Default to last 7 days if not enough data
    DateTime now = DateTime.now();

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

  List<PieChartDataPoint> getRevenueByCategoryData() {
    final categories = _categoryService.getAllCategories();
    final sales = _saleService.getAllSales();

    Map<String, double> categoryRevenue = {};
    for (var cat in categories) {
      categoryRevenue[cat.name] = 0.0;
    }

    double totalRevenue = 0;

    for (var sale in sales) {
      for (var item in sale.items) {
        String catName = item.categoryName;
        if (categoryRevenue.containsKey(catName)) {
          categoryRevenue[catName] =
              categoryRevenue[catName]! + item.totalPrice;
        } else {
          categoryRevenue[catName] =
              (categoryRevenue[catName] ?? 0.0) + item.totalPrice;
        }
        totalRevenue += item.totalPrice;
      }
    }

    List<Color> pieColors = [
      const Color(0xFF4285F4),
      const Color(0xFF34A853),
      const Color(0xFFFBBC05),
      const Color(0xFF9C27B0),
      const Color(0xFFEA4335),
      const Color(0xFF00BCD4),
      const Color(0xFFFF9800),
    ];

    List<PieChartDataPoint> result = [];
    int colorIndex = 0;

    for (var entry in categoryRevenue.entries) {
      double value = entry.value;
      double percentage = totalRevenue == 0 ? 0 : (value / totalRevenue) * 100;

      String label = '${entry.key} (${percentage.toStringAsFixed(1)}%)';
      String suffix = '₹${value.toStringAsFixed(0)}';

      result.add(
        PieChartDataPoint(
          label: label,
          value: value,
          color: pieColors[colorIndex % pieColors.length],
          suffix: suffix,
        ),
      );
      colorIndex++;
    }

    // Sort by value descending
    result.sort((a, b) => b.value.compareTo(a.value));

    return result;
  }

  double getTotalRevenue() {
    final sales = _saleService.getAllSales();
    double totalRevenue = 0;
    for (var s in sales) {
      totalRevenue += s.grandTotal;
    }
    return totalRevenue;
  }

  List<TopListItemModel> getTopSellingProducts() {
    final sales = _saleService.getAllSales();

    double totalRevenue = 0;
    Map<String, _ProductAgg> productSales = {};

    for (var sale in sales) {
      for (var item in sale.items) {
        totalRevenue += item.totalPrice;

        if (productSales.containsKey(item.productId)) {
          productSales[item.productId]!.quantity += item.quantity;
          productSales[item.productId]!.revenue += item.totalPrice;
        } else {
          productSales[item.productId] = _ProductAgg(
            item.productName,
            item.categoryName,
            item.imagePath,
            item.quantity,
            item.totalPrice,
          );
        }
      }
    }

    List<_ProductAgg> sortedProducts = productSales.values.toList();
    sortedProducts.sort((a, b) => b.revenue.compareTo(a.revenue));

    // Take top 5
    sortedProducts = sortedProducts.take(5).toList();

    return sortedProducts.map((p) {
      double percentage = totalRevenue == 0
          ? 0
          : (p.revenue / totalRevenue) * 100;
      return TopListItemModel(
        leading: _buildProductImage(p.imagePath),
        title: p.name,
        subtitle: p.category,
        middleText: Text(
          "${p.quantity}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        trailing: _buildRevenueTrailing(
          "₹${p.revenue.toStringAsFixed(0)}",
          double.parse(percentage.toStringAsFixed(1)),
        ),
      );
    }).toList();
  }

  Widget _buildProductImage(String imagePath) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FB),
        borderRadius: BorderRadius.circular(8),
        image: imagePath.isNotEmpty
            ? DecorationImage(
                image: FileImage(File(imagePath)),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imagePath.isEmpty
          ? const Icon(Icons.image, color: Colors.grey, size: 20)
          : null,
    );
  }

  Widget _buildRevenueTrailing(String amount, double percent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              amount,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const SizedBox(width: 8),
            Text(
              "$percent%",
              style: const TextStyle(color: AppColors.grey, fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(2),
          ),
          alignment: Alignment.centerLeft,
          child: Container(
            width: 80 * (percent / 100),
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF4C2DB3), // Purple
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductAgg {
  String name;
  String category;
  String imagePath;
  int quantity;
  double revenue;

  _ProductAgg(
    this.name,
    this.category,
    this.imagePath,
    this.quantity,
    this.revenue,
  );
}
