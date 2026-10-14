import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/utils/validator.dart';
import '../../../core/widgets/textfields/app_custom_text_field.dart';

class StockQuantitySelector extends StatefulWidget {
  final TextEditingController controller;

  const StockQuantitySelector({super.key, required this.controller});

  @override
  State<StockQuantitySelector> createState() => _StockQuantitySelectorState();
}

class _StockQuantitySelectorState extends State<StockQuantitySelector> {
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    _updateQuantityFromController();
    widget.controller.addListener(_updateQuantityFromController);
  }

  void _updateQuantityFromController() {
    final newQuantity = int.tryParse(widget.controller.text) ?? 0;
    if (newQuantity != quantity) {
      if (mounted) {
        setState(() {
          quantity = newQuantity;
        });
      }
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateQuantityFromController);
    super.dispose();
  }

  void _increment() {
    setState(() {
      quantity++;
      widget.controller.text = quantity.toString();
    });
  }

  void _decrement() {
    if (quantity > 0) {
      setState(() {
        quantity--;
        widget.controller.text = quantity.toString();
      });
    } else {
      AppSnackBar.warning(
        context,
        "⚠️ Stock quantity cannot be less than zero.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        Container(
          height: 60, // Matches standard text field height
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _decrement,
                icon: const Icon(
                  Icons.remove_circle,
                  color: AppColors.blue,
                  size: 28,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: const TextStyle(
                    fontSize: AppSizes.font18,
                    fontWeight: FontWeight.bold,
                  ),
                  validator: Validator.validateStock,
                  onChanged: (value) {
                    final intValue = int.tryParse(value) ?? 0;
                    if (intValue < 0) {
                      widget.controller.text = "0";
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: _increment,
                icon: const Icon(
                  Icons.add_circle,
                  color: AppColors.blue,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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
          hint: "Enter Stock",
          icon: Icons.inventory_2_outlined,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
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
