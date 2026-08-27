import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/dropdowns/app_custom_dropdown.dart';
import '../../../../core/widgets/textfields/app_custom_text_field.dart';

class WebAddSalePayment extends StatelessWidget {
  final double subtotal;
  final int totalItems;
  final double discountAmount;
  final double grandTotal;
  final String? selectedPaymentMethod;
  final TextEditingController discountController;
  final TextEditingController noteController;
  final Function(String?) onPaymentMethodChanged;
  final VoidCallback onDiscountChanged;

  const WebAddSalePayment({
    super.key,
    required this.subtotal,
    required this.totalItems,
    required this.discountAmount,
    required this.grandTotal,
    required this.selectedPaymentMethod,
    required this.discountController,
    required this.noteController,
    required this.onPaymentMethodChanged,
    required this.onDiscountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSummaryRow(
          "Subtotal ($totalItems Items)",
          "₹${subtotal.toStringAsFixed(0)}",
        ),
        const SizedBox(height: AppSizes.size10),
        _buildSummaryRow(
          "Discount",
          "- ₹${discountAmount.toStringAsFixed(0)}",
          isDiscount: true,
        ),
        const Divider(height: AppSizes.size30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Grand Total",
                  style: TextStyle(
                    fontSize: AppSizes.font20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  "₹${grandTotal.toStringAsFixed(0)}",
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: AppSizes.font24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.size25),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppCustomDropdown.dropdown<String>(
                label: "Payment Method",
                icon: Icons.payments_outlined,
                value: selectedPaymentMethod,
                items: const ["Cash", "UPI", "Card"],
                itemLabel: (method) => method,
                onChanged: onPaymentMethodChanged,
              ),
            ),
            const SizedBox(width: AppSizes.size20),
            Expanded(
              child: AppCustomTextField.textField(
                controller: discountController,
                label: "Discount Amount (₹)",
                hint: "Enter discount amount",
                icon: Icons.currency_rupee_rounded,
                keyboardType: TextInputType.number,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 24.5,
                  horizontal: 16,
                ),
                borderColor: const Color(0xFFD6E4FF),
                borderRadius: AppSizes.borderRadius20,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) => null,
                onChanged: (_) => onDiscountChanged(),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.size20),
        AppCustomTextField.textField(
          controller: noteController,
          label: "Note",
          hint: "Add customer note",
          icon: Icons.edit_note_outlined,
          maxLines: 3,
          validator: (value) => null,
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(label, style: const TextStyle(color: AppColors.grey)),
            ),
          ),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDiscount ? AppColors.success : AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
