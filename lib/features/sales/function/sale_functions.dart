import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../app/app_navigation.dart';
import '../../../core/services/product_service.dart';
import '../../../core/services/sale_service.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/sale_item_model.dart';
import '../../../data/models/sale_model.dart';
import '../../../core/utils/app_snack_bar.dart';

class SaleFunctions {
  final SaleService _saleService = SaleService();

  /// Subtotal
  double getSubtotal(List<SaleItemModel> cartItems) {
    return cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  /// Grand Total
  double getGrandTotal(
    List<SaleItemModel> cartItems,
    double discountAmount,
  ) {
    double total = getSubtotal(cartItems) - discountAmount;
    return total < 0 ? 0 : total;
  }

  /// Update Quantity
  void updateQuantity(List<SaleItemModel> cartItems, int index, int change) {
    int newQuantity = (cartItems[index].quantity + change).clamp(1, 10);

    cartItems[index].quantity = newQuantity;

    cartItems[index].totalPrice = cartItems[index].sellingPrice * newQuantity;

    cartItems[index].profit =
        (cartItems[index].sellingPrice - cartItems[index].purchasePrice) *
        newQuantity;
  }

  /// Remove Product
  void removeItem(List<SaleItemModel> cartItems, int index) {
    cartItems.removeAt(index);
  }

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
      debugPrint("Selected date before save: $saleDate");

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

      debugPrint("Date stored in SaleModel: ${sale.saleDate}");

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
        ProductModel? product =
            productService.getProductByProductId(oldItem.productId);
        if (product != null) {
          product.stock += oldItem.quantity;
          await productService.updateProduct(product);
        }
      }

      // Apply new stock
      for (var newItem in newCartItems) {
        ProductModel? product =
            productService.getProductByProductId(newItem.productId);
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

  void clearCart({
    required BuildContext context,
    required List<SaleItemModel> cartItems,
    required TextEditingController noteController,
    required VoidCallback refresh,
  }) {
    if (cartItems.isEmpty) {
      AppSnackBar.warning(context, "Cart is already empty.");
      return;
    }

    cartItems.clear();
    noteController.clear();

    refresh();

    AppSnackBar.success(context, "Cart cleared successfully.");
  }

  List<SaleModel> loadSales() {
    final sales = _saleService.getAllSales();
    sales.sort((a, b) => b.saleDate.compareTo(a.saleDate));
    return sales;
  }

  double getTotalAmount(List<SaleModel> sales) {
    return sales.fold(0, (sum, sale) => sum + sale.grandTotal);
  }

  int getTotalProductsSold(List<SaleModel> sales) {
    return sales.fold(0, (sum, sale) => sum + sale.totalQuantity);
  }

  Map<String, dynamic> getTodaySummary(List<SaleModel> sales) {
    int transactions = 0;
    double amount = 0;
    int quantity = 0;
    double profit = 0;

    final today = DateTime.now();

    for (final sale in sales) {
      if (sale.saleDate.year == today.year &&
          sale.saleDate.month == today.month &&
          sale.saleDate.day == today.day) {
        transactions++;
        amount += sale.grandTotal;
        quantity += sale.totalQuantity;
        profit += sale.totalProfit;
      }
    }

    return {
      "transactions": transactions,
      "amount": amount,
      "quantity": quantity,
      "profit": profit,
    };
  }
}
