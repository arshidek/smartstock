import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../app/app_navigation.dart';
import '../../../core/services/product_service.dart';
import '../../../core/services/sale_service.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/sale_item_model.dart';
import '../../../data/models/sale_model.dart';
import '../../../core/utils/app_snack_bar.dart';

class SaleSaveFunctions {
  final SaleService _saleService = SaleService();

  Future<void> saveSale({
    required BuildContext context,
    required List<SaleItemModel> cartItems,
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
      debugPrint("saveSale called");
      if (cartItems.isEmpty) {
        AppSnackBar.warning(context, "Please add at least one product.");
        return;
      }
      const uuid = Uuid();
      double subTotal = 0;
      int totalQuantity = 0;
      double totalProfit = 0;

      for (var item in cartItems) {
        subTotal += item.totalPrice;
        totalQuantity += item.quantity;
        totalProfit += item.profit;
      }

      final sale = SaleModel(
        id: uuid.v4(),
        invoiceNo: "INV-${DateTime.now().millisecondsSinceEpoch}",
        saleDate: saleDate,
        items: List<SaleItemModel>.from(cartItems),
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

      await _saleService.saveSale(sale);
      final productService = ProductService();
      for (var item in cartItems) {
        ProductModel? product = productService.getProductByProductId(
          item.productId,
        );
        if (product != null) {
          product.stock -= item.quantity;
          if (product.stock < 0) {
            product.stock = 0;
          }
          await productService.updateProduct(product);
        }
      }

      cartItems.clear();
      customerNameController.clear();
      customerPhoneController.clear();
      customerEmailController.clear();
      customerAddressController.clear();
      noteController.clear();

      refresh();
      AppSnackBar.success(context, "Sale completed successfully.");
      AppNavigation.goBackWithResult(context, true);
    } catch (e) {
      debugPrint("Save Sale Error : $e");
      AppSnackBar.error(context, e.toString());
    }
  }
}
