import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../data/models/sale_item_model.dart';
import '../../../data/models/sale_model.dart';
import '../function/sale_functions.dart';
import 'add_product_to_sale_screen.dart';
import 'mobile/mobile_update_sale_screen.dart';
import 'web/web_update_sale_screen.dart';

class UpdateSaleScreen extends StatefulWidget {
  final SaleModel sale;
  const UpdateSaleScreen({super.key, required this.sale});

  @override
  State<UpdateSaleScreen> createState() => _UpdateSaleScreenState();
}

class _UpdateSaleScreenState extends State<UpdateSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  final SaleFunctions saleFunctions = SaleFunctions();
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
    customerNameController =
        TextEditingController(text: widget.sale.customerName);
    customerPhoneController =
        TextEditingController(text: widget.sale.customerPhone);
    customerEmailController =
        TextEditingController(text: widget.sale.customerEmail);
    customerAddressController =
        TextEditingController(text: widget.sale.customerAddress);
    discountController = TextEditingController(
      text: widget.sale.discount == 0
          ? ''
          : widget.sale.discount.toStringAsFixed(0),
    );
    selectedPaymentMethod = widget.sale.paymentMethod;
    selectedSaleDate = widget.sale.saleDate;
    cartItems =
        widget.sale.items
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

  void _onAddProduct() async {
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

  void _onClearCart() {
    saleFunctions.clearCart(
      context: context,
      cartItems: cartItems,
      noteController: noteController,
      refresh: () => setState(() {}),
    );
  }

  void _onUpdateSale() async {
    if (_formKey.currentState!.validate()) {
      await saleFunctions.updateSale(
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

  @override
  Widget build(BuildContext context) {
    final subtotal = saleFunctions.getSubtotal(cartItems);
    final discountAmount = double.tryParse(discountController.text) ?? 0.0;
    final grandTotal = saleFunctions.getGrandTotal(cartItems, discountAmount);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black, size: AppSizes.size30),
          onPressed: () => AppNavigation.goBack(context),
        ),
        title: const Text(
          'Update Sale',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.font24,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.background),
        child: Responsive.isMobile(context)
            ? MobileUpdateSaleScreen(
                formKey: _formKey,
                saleFunctions: saleFunctions,
                noteController: noteController,
                customerNameController: customerNameController,
                customerPhoneController: customerPhoneController,
                customerEmailController: customerEmailController,
                customerAddressController: customerAddressController,
                discountController: discountController,
                cartItems: cartItems,
                selectedPaymentMethod: selectedPaymentMethod,
                selectedSaleDate: selectedSaleDate,
                subtotal: subtotal,
                discountAmount: discountAmount,
                grandTotal: grandTotal,
                onAddProduct: _onAddProduct,
                onDateChanged: (date) => setState(() => selectedSaleDate = date),
                onPaymentMethodChanged: (method) =>
                    setState(() => selectedPaymentMethod = method),
                onDiscountChanged: () => setState(() {}),
                onCartUpdated: (items) => setState(() => cartItems = items),
                onClearCart: _onClearCart,
                onUpdateSale: _onUpdateSale,
              )
            : WebUpdateSaleScreen(
                formKey: _formKey,
                saleFunctions: saleFunctions,
                noteController: noteController,
                customerNameController: customerNameController,
                customerPhoneController: customerPhoneController,
                customerEmailController: customerEmailController,
                customerAddressController: customerAddressController,
                discountController: discountController,
                cartItems: cartItems,
                selectedPaymentMethod: selectedPaymentMethod,
                selectedSaleDate: selectedSaleDate,
                subtotal: subtotal,
                discountAmount: discountAmount,
                grandTotal: grandTotal,
                onAddProduct: _onAddProduct,
                onDateChanged: (date) => setState(() => selectedSaleDate = date),
                onPaymentMethodChanged: (method) =>
                    setState(() => selectedPaymentMethod = method),
                onDiscountChanged: () => setState(() {}),
                onCartUpdated: (items) => setState(() => cartItems = items),
                onClearCart: _onClearCart,
                onUpdateSale: _onUpdateSale,
              ),
      ),
    );
  }
}
