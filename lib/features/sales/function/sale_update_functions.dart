import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/services/product_service.dart';
import '../../../core/services/sale_service.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/sale_item_model.dart';
import '../../../data/models/sale_model.dart';
import '../../../core/utils/app_snack_bar.dart';

class SaleUpdateFunctions {
  final SaleService _saleService = SaleService();

  Future<void> updateSale({
    required BuildContext context,
    required SaleModel existingSale,
    required List<SaleItemModel> newCartItems,
    required TextEditingController customerNameController,
    required TextEditingController customerPhoneController,
    required TextEditingController customerEmailController,
    required TextEditingController customerAddressController,
    required TextEditingController noteController,
    required String paymentMethod,
    required DateTime saleDate,
    required double discountAmount,
    required VoidCallback refresh,
  }) async {
    try {
      if (newCartItems.isEmpty) {
        AppSnackBar.warning(context, "Please add at least one product.");
        return;
      }

      double subTotal = 0;
      int totalQuantity = 0;
      double totalProfit = 0;

      for (var item in newCartItems) {
        subTotal += item.totalPrice;
        totalQuantity += item.quantity;
        totalProfit += item.profit;
      }

      final updatedSale = SaleModel(
        id: existingSale.id,
        invoiceNo: existingSale.invoiceNo,
        saleDate: saleDate,
        items: List<SaleItemModel>.from(newCartItems),
        subTotal: subTotal,
        discount: discountAmount,
        grandTotal: subTotal - discountAmount,
        paymentMethod: paymentMethod,
        customerName: customerNameController.text.trim(),
        customerPhone: customerPhoneController.text.trim(),
        customerEmail: customerEmailController.text.trim(),
        customerAddress: customerAddressController.text.trim(),
        note: noteController.text.trim(),
        totalQuantity: totalQuantity,
        totalProfit: totalProfit,
      );

      final productService = ProductService();

      // Revert old stock
      for (var oldItem in existingSale.items) {
        ProductModel? product = productService.getProductByProductId(
          oldItem.productId,
        );
        if (product != null) {
          product.stock += oldItem.quantity;
          await productService.updateProduct(product);
        }
      }

      // Apply new stock
      for (var newItem in newCartItems) {
        ProductModel? product = productService.getProductByProductId(
          newItem.productId,
        );
        if (product != null) {
          product.stock -= newItem.quantity;
          if (product.stock < 0) {
            product.stock = 0;
          }
          await productService.updateProduct(product);
        }
      }

      await _saleService.updateSale(updatedSale);
      refresh();
      AppSnackBar.success(context, "Sale updated successfully.");
      AppNavigation.goBackWithResult(context, true);
    } catch (e) {
      debugPrint("Update Sale Error : $e");
      AppSnackBar.error(context, e.toString());
    }
  }
}
