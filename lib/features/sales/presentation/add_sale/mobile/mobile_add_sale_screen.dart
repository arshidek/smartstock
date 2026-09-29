import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/widgets/buttons/app_button.dart';
import '../../../../../core/widgets/cards/app_card_widget.dart';
import '../../../../../data/models/sale_item_model.dart';
import '../../../function/sale_calculation_functions.dart';
import '../../../function/sale_save_functions.dart';
import '../../../function/sale_update_functions.dart';
import '../../../widgets/sale_date_picker_widget.dart';
import 'mobile_add_sale_cart.dart';
import 'mobile_add_sale_customer.dart';
import 'mobile_add_sale_payment.dart';

part 'mobile_add_sale_screen_ui.dart';

class MobileAddSaleScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final SaleCalculationFunctions saleCalculationFunctions;
  final SaleSaveFunctions saleSaveFunctions;
  final SaleUpdateFunctions saleUpdateFunctions;
  final TextEditingController noteController;
  final TextEditingController customerNameController;
  final TextEditingController customerPhoneController;
  final TextEditingController customerEmailController;
  final TextEditingController customerAddressController;
  final TextEditingController discountController;
  final List<SaleItemModel> cartItems;
  final String? selectedPaymentMethod;
  final DateTime selectedSaleDate;
  final double subtotal;
  final double discountAmount;
  final double grandTotal;
  final VoidCallback onAddProduct;
  final Function(DateTime) onDateChanged;
  final Function(String?) onPaymentMethodChanged;
  final VoidCallback onDiscountChanged;
  final Function(List<SaleItemModel>) onCartUpdated;
  final VoidCallback onClearCart;
  final VoidCallback onSaveSale;

  const MobileAddSaleScreen({
    super.key,
    required this.formKey,
    required this.saleCalculationFunctions,
    required this.saleSaveFunctions,
    required this.saleUpdateFunctions,
    required this.noteController,
    required this.customerNameController,
    required this.customerPhoneController,
    required this.customerEmailController,
    required this.customerAddressController,
    required this.discountController,
    required this.cartItems,
    required this.selectedPaymentMethod,
    required this.selectedSaleDate,
    required this.subtotal,
    required this.discountAmount,
    required this.grandTotal,
    required this.onAddProduct,
    required this.onDateChanged,
    required this.onPaymentMethodChanged,
    required this.onDiscountChanged,
    required this.onCartUpdated,
    required this.onClearCart,
    required this.onSaveSale,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.size20),
            _buildCartHeader(),
            const SizedBox(height: AppSizes.size20),
            MobileAddSaleCart(
              cartItems: cartItems,
              saleCalculationFunctions: saleCalculationFunctions,
              saleSaveFunctions: saleSaveFunctions,
              saleUpdateFunctions: saleUpdateFunctions,
              onCartUpdated: onCartUpdated,
            ),
            const SizedBox(height: AppSizes.size20),
            _buildAddProductButton(),
            const SizedBox(height: AppSizes.size20),
            _buildOrderSummary(context),
            const SizedBox(height: AppSizes.size30),
            _buildActionButtons(),
            const SizedBox(height: AppSizes.size25),
          ],
        ),
      ),
    );
  }
}
