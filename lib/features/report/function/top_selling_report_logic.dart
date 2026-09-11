import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../core/services/product_service.dart';
import '../../../core/services/sale_service.dart';
import '../../../core/constants/app_colors.dart';
import '../widgets/top_list_widget.dart';
import '../../../app/app_navigation.dart';
import '../../product/presentation/product_detail_screen.dart';
import 'report_ui_helpers.dart';

class _ProductAgg {
  String name;
  String category;
  String imagePath;
  String productId;
  int quantity;
  double revenue;

  _ProductAgg(
    this.name,
    this.category,
    this.imagePath,
    this.productId,
    this.quantity,
    this.revenue,
  );
}

class TopSellingReportLogic {
  final ProductService _productService = ProductService();
  final SaleService _saleService = SaleService();

  List<TopListItemModel> getTopSellingProducts(BuildContext context, {DateTime? selectedDate}) {
    final sales = _saleService.getAllSales();
    final now = selectedDate ?? DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    double totalRevenue = 0;
    Map<String, _ProductAgg> productSales = {};

    for (var sale in sales) {
      if ((sale.saleDate.isAfter(thirtyDaysAgo) || sale.saleDate.isAtSameMomentAs(thirtyDaysAgo)) &&
          (sale.saleDate.isBefore(now) || sale.saleDate.isAtSameMomentAs(now))) {
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
              item.productId,
              item.quantity,
              item.totalPrice,
            );
          }
        }
      }
    }

    List<_ProductAgg> sortedProducts = productSales.values.toList();
    sortedProducts.sort((a, b) => b.revenue.compareTo(a.revenue));
    sortedProducts = sortedProducts.take(5).toList();

    return sortedProducts.map((p) {
      double percentage = totalRevenue == 0 ? 0 : (p.revenue / totalRevenue) * 100;
      final productModel = _productService.getProductByProductId(p.productId);

      return TopListItemModel(
        leading: ReportUiHelpers.buildProductImage(p.imagePath),
        title: p.name,
        subtitle: p.category,
        onTap: productModel != null
            ? () {
                AppNavigation.goToScreen(
                  context,
                  ProductDetailScreen(product: productModel),
                );
              }
            : null,
        middleText: Text(
          "${p.quantity}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: AppSizes.font15,
            color: AppColors.black,
          ),
        ),
        trailing: ReportUiHelpers.buildRevenueTrailing(
          "₹${p.revenue.toStringAsFixed(0)}",
          double.parse(percentage.toStringAsFixed(1)),
        ),
      );
    }).toList();
  }
}
