import 'package:flutter/material.dart';

import '../../../app/app_navigation.dart';
import '../../../core/services/product_service.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../data/models/product_model.dart';

class StockFunction {
  final ProductService _productService = ProductService();

  void updatePreview({
    required bool isAddStock,
    required int currentStock,
    required int quantity,
    required ValueChanged<int> onChanged,
  }) {
    if (isAddStock) {
      onChanged(currentStock + quantity);
    } else {
      onChanged((currentStock - quantity).clamp(0, 99999));
    }
  }

  Future<void> updateStock({
    required BuildContext context,
    required ProductModel product,
    required bool isAddStock,
    required int quantity,
  }) async {
    if (isAddStock) {
      product.stock += quantity;
    } else {
      product.stock = (product.stock - quantity).clamp(0, 99999);
    }

    await product.save();

    AppSnackBar.success(context, "Stock Updated Successfully!");

    AppNavigation.goBackWithResult(context, true);
  }

  List<ProductModel> getAllProducts() {
    return _productService.getAllProducts();
  }

  List<ProductModel> getLowStockProducts() {
    return _productService
        .getAllProducts()
        .where((p) => p.stock > 0 && p.stock <= 5)
        .toList();
  }

  List<ProductModel> getOutOfStockProducts() {
    return _productService.getAllProducts().where((p) => p.stock == 0).toList();
  }

  List<ProductModel> searchProducts(List<ProductModel> products, String value) {
    final query = value.toLowerCase().trim();

    return products.where((product) {
      return product.name.toLowerCase().contains(query) ||
          product.productId.toLowerCase().contains(query);
    }).toList();
  }
}
