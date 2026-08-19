import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/validator.dart';
import '../../../core/widgets/textfields/app_custom_text_field.dart';

class AddProductBarcodeStockFields {
  static Widget buildStockField({required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text.rich(
          TextSpan(
            text: "Stock Quantity ",
            children: [
              TextSpan(
                text: "*",
                style: TextStyle(color: AppColors.error),
              ),
            ],
          ),
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSizes.size7),
        AppCustomTextField.textField(
          controller: controller,
          label: "Stock Quantity",
          hint: "Enter Stock Quantity",
          icon: Icons.widgets_outlined,
          keyboardType: TextInputType.number,
          validator: Validator.validateStock,
        ),
      ],
    );
  }

  static Widget buildBarcodeField({
    required TextEditingController controller,
    required String? barcodeError,
    required VoidCallback onScanBarcode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Barcode", style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: AppSizes.size7),
        AppCustomTextField.textField(
          controller: controller,
          label: "Barcode",
          hint: "Enter Barcode",
          icon: Icons.qr_code,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          suffixIcon: IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: AppColors.grey),
            onPressed: onScanBarcode,
          ),
          validator: Validator.validateBarcode,
        ),
        if (barcodeError != null)
          Padding(
            padding: const EdgeInsets.only(
              left: AppSizes.padding10,
              top: AppSizes.size5,
            ),
            child: Text(
              barcodeError,
              style: const TextStyle(
                color: AppColors.error,
                fontSize: AppSizes.font14,
              ),
            ),
          ),
      ],
    );
  }
}
