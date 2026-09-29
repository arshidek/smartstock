part of 'mobile_add_sale_screen.dart';

extension MobileAddSaleScreenUI on MobileAddSaleScreen {
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
          MobileAddSalePayment(
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
            child: MobileAddSaleCustomer(
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
        const SizedBox(width: AppSizes.size8),
        SaleDatePickerWidget(
          selectedDate: selectedSaleDate,
          onDateChanged: onDateChanged,
        ),
      ],
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
