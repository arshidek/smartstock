import 'package:flutter/material.dart';
import '../../../../data/models/sale_item_model.dart';
import '../../function/sale_calculation_functions.dart';
import '../../function/sale_save_functions.dart';
import '../../function/sale_update_functions.dart';
import '../add_product_to_sale/add_product_to_sale_screen.dart';
import 'update_sale_screen.dart';

mixin UpdateSaleScreenStateMixin on State<UpdateSaleScreen> {
  final formKey = GlobalKey<FormState>();
  final SaleCalculationFunctions saleCalculationFunctions =
      SaleCalculationFunctions();
  final SaleSaveFunctions saleSaveFunctions = SaleSaveFunctions();
  final SaleUpdateFunctions saleUpdateFunctions = SaleUpdateFunctions();
  late final TextEditingController noteController;
  late final TextEditingController customerNameController;
  late final TextEditingController customerPhoneController;
  late final TextEditingController customerEmailController;
  late final TextEditingController customerAddressController;
  late final TextEditingController discountController;

  List<SaleItemModel> cartItems = [];
  String? selectedPaymentMethod = "Cash";
  late DateTime selectedSaleDate;

  @override
  void initState() {
    super.initState();
    noteController = TextEditingController(text: widget.sale.note);
    customerNameController = TextEditingController(
      text: widget.sale.customerName,
    );
    customerPhoneController = TextEditingController(
      text: widget.sale.customerPhone,
    );
    customerEmailController = TextEditingController(
      text: widget.sale.customerEmail,
    );
    customerAddressController = TextEditingController(
      text: widget.sale.customerAddress,
    );
    discountController = TextEditingController(
      text: widget.sale.discount == 0
          ? ''
          : widget.sale.discount.toStringAsFixed(0),
    );
    selectedPaymentMethod = widget.sale.paymentMethod;
    selectedSaleDate = widget.sale.saleDate;
    cartItems = widget.sale.items
        .map(
          (e) => SaleItemModel(
            productId: e.productId,
            productName: e.productName,
            brandName: e.brandName,
            categoryName: e.categoryName,
            imagePath: e.imagePath,
            purchasePrice: e.purchasePrice,
            sellingPrice: e.sellingPrice,
            quantity: e.quantity,
            totalPrice: e.totalPrice,
            profit: e.profit,
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    customerNameController.dispose();
    customerPhoneController.dispose();
    customerEmailController.dispose();
    customerAddressController.dispose();
    noteController.dispose();
    discountController.dispose();
    super.dispose();
  }

  void onAddProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddProductToSaleScreen(saleItems: cartItems),
      ),
    );
    if (result != null && result is List<SaleItemModel>) {
      setState(() {
        cartItems = result;
      });
    }
  }

  void onClearCart() {
    saleCalculationFunctions.clearCart(
      context: context,
      cartItems: cartItems,
      noteController: noteController,
      refresh: () => setState(() {}),
    );
  }

  void onUpdateSale() async {
    if (formKey.currentState!.validate()) {
      await saleUpdateFunctions.updateSale(
        context: context,
        existingSale: widget.sale,
        newCartItems: cartItems,
        customerNameController: customerNameController,
        customerPhoneController: customerPhoneController,
        customerEmailController: customerEmailController,
        customerAddressController: customerAddressController,
        noteController: noteController,
        paymentMethod: selectedPaymentMethod!,
        saleDate: selectedSaleDate,
        discountAmount: double.tryParse(discountController.text) ?? 0.0,
        refresh: () => setState(() {}),
      );
    }
  }
}
