import 'package:flutter/material.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../data/models/sale_item_model.dart';

class SaleCalculationFunctions {
  /// Subtotal
  double getSubtotal(List<SaleItemModel> cartItems) {
    return cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  /// Grand Total
  double getGrandTotal(List<SaleItemModel> cartItems, double discountAmount) {
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

  /// Clear Cart
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
}
