import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../data/models/sale_item_model.dart';
import '../function/sale_functions.dart';
import 'add_product_to_sale_screen.dart';
import 'mobile/mobile_add_sale_screen.dart';
import 'web/web_add_sale_screen.dart';

class AddSaleScreen extends StatefulWidget {
  const AddSaleScreen({super.key});

  @override
  State<AddSaleScreen> createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends State<AddSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  final SaleFunctions saleFunctions = SaleFunctions();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerPhoneController = TextEditingController();
  final TextEditingController customerEmailController = TextEditingController();
  final TextEditingController customerAddressController =
      TextEditingController();
  final TextEditingController discountController = TextEditingController();

  List<SaleItemModel> cartItems = [];
  String? selectedPaymentMethod = "Cash";
  DateTime selectedSaleDate = DateTime.now();

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

  void _onSaveSale() async {
    if (_formKey.currentState!.validate()) {
      await saleFunctions.saveSale(
        context: context,
        cartItems: cartItems,
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
          icon: const Icon(Icons.arrow_back, color: AppColors.black, size: 30),
          onPressed: () => AppNavigation.goBack(context),
        ),
        title: const Text(
          'Add Sale',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.size25,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.background),
        child: Responsive.isMobile(context)
            ? MobileAddSaleScreen(
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
                onSaveSale: _onSaveSale,
              )
            : WebAddSaleScreen(
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
                onSaveSale: _onSaveSale,
              ),
      ),
    );
  }
}
