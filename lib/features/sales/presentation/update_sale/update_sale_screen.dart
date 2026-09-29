import 'package:flutter/material.dart';
import 'package:smartstock_inventory/features/sales/presentation/update_sale/update_sale_screen_state_mixin.dart';
import '../../../../app/app_navigation.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../data/models/sale_model.dart';
import 'mobile/mobile_update_sale_screen.dart';
import 'web/web_update_sale_screen.dart';

class UpdateSaleScreen extends StatefulWidget {
  final SaleModel sale;
  const UpdateSaleScreen({super.key, required this.sale});

  @override
  State<UpdateSaleScreen> createState() => _UpdateSaleScreenState();
}

class _UpdateSaleScreenState extends State<UpdateSaleScreen>
    with UpdateSaleScreenStateMixin {
  @override
  Widget build(BuildContext context) {
    final subtotal = saleCalculationFunctions.getSubtotal(cartItems);
    final discountAmount = double.tryParse(discountController.text) ?? 0.0;
    final grandTotal = saleCalculationFunctions.getGrandTotal(
      cartItems,
      discountAmount,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
            size: AppSizes.size30,
          ),
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
                formKey: formKey,
                saleCalculationFunctions: saleCalculationFunctions,
                saleSaveFunctions: saleSaveFunctions,
                saleUpdateFunctions: saleUpdateFunctions,
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
                onAddProduct: onAddProduct,
                onDateChanged: (date) =>
                    setState(() => selectedSaleDate = date),
                onPaymentMethodChanged: (method) =>
                    setState(() => selectedPaymentMethod = method),
                onDiscountChanged: () => setState(() {}),
                onCartUpdated: (items) => setState(() => cartItems = items),
                onClearCart: onClearCart,
                onUpdateSale: onUpdateSale,
              )
            : WebUpdateSaleScreen(
                formKey: formKey,
                saleCalculationFunctions: saleCalculationFunctions,
                saleSaveFunctions: saleSaveFunctions,
                saleUpdateFunctions: saleUpdateFunctions,
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
                onAddProduct: onAddProduct,
                onDateChanged: (date) =>
                    setState(() => selectedSaleDate = date),
                onPaymentMethodChanged: (method) =>
                    setState(() => selectedPaymentMethod = method),
                onDiscountChanged: () => setState(() {}),
                onCartUpdated: (items) => setState(() => cartItems = items),
                onClearCart: onClearCart,
                onUpdateSale: onUpdateSale,
              ),
      ),
    );
  }
}
