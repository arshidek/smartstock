import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/buttons/app_button.dart';
import '../../../../core/widgets/cards/app_card_widget.dart';
import '../../../../data/models/sale_item_model.dart';
import '../../function/sale_functions.dart';
import 'web_add_sale_cart.dart';
import 'web_add_sale_customer.dart';
import 'web_add_sale_payment.dart';

class WebAddSaleScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final SaleFunctions saleFunctions;
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

  const WebAddSaleScreen({
    super.key,
    required this.formKey,
    required this.saleFunctions,
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
            WebAddSaleCart(
              cartItems: cartItems,
              saleFunctions: saleFunctions,
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

  Widget _buildCartHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              "Products Added (${cartItems.length})",
              style: const TextStyle(
                fontSize: AppSizes.font18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddProductButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding16),
      child: AppButton(
        text: "Add Product",
        icon: Icons.add,
        backgroundColor: AppColors.blue,
        textColor: AppColors.white,
        iconColor: AppColors.white,
        onPressed: onAddProduct,
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context) {
    return AppCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryHeader(context),
          const SizedBox(height: AppSizes.size25),
          WebAddSalePayment(
            subtotal: subtotal,
            totalItems: cartItems.length,
            discountAmount: discountAmount,
            grandTotal: grandTotal,
            selectedPaymentMethod: selectedPaymentMethod,
            discountController: discountController,
            noteController: noteController,
            onPaymentMethodChanged: onPaymentMethodChanged,
            onDiscountChanged: onDiscountChanged,
          ),
          const SizedBox(height: AppSizes.size25),
          const Divider(),
          const SizedBox(height: AppSizes.size25),
          Form(
            key: formKey,
            child: WebAddSaleCustomer(
              customerNameController: customerNameController,
              customerPhoneController: customerPhoneController,
              customerEmailController: customerEmailController,
              customerAddressController: customerAddressController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.receipt_long_outlined,
                color: AppColors.blue,
                size: AppSizes.size25,
              ),
              const SizedBox(width: AppSizes.size10),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Order Summary",
                    style: TextStyle(
                      fontSize: AppSizes.font20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        _buildDatePicker(context),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Flexible(
      child: Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedSaleDate,
                firstDate: DateTime(2024),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) onDateChanged(pickedDate);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.blue.withOpacity(.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.blue.withOpacity(.25)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: AppSizes.size15,
                            color: AppColors.blue,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "${selectedSaleDate.day} ${["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][selectedSaleDate.month - 1]} ${selectedSaleDate.year}",
                            style: const TextStyle(
                              color: AppColors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding16),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              text: "Clear Cart",
              icon: Icons.delete_outline,
              backgroundColor: AppColors.lightRed,
              textColor: AppColors.error,
              iconColor: AppColors.error,
              onPressed: onClearCart,
            ),
          ),
          const SizedBox(width: AppSizes.size10),
          Expanded(
            child: AppButton(
              text: "Save Sale",
              icon: Icons.shopping_cart_checkout,
              backgroundColor: AppColors.blue,
              textColor: AppColors.white,
              iconColor: AppColors.white,
              onPressed: onSaveSale,
            ),
          ),
        ],
      ),
    );
  }
}
