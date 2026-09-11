import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/textfields/app_custom_text_field.dart';
import '../../../data/models/brand_model.dart';
import '../../../data/models/category_model.dart';
import 'add_product_barcode_stock_fields.dart';
import 'add_product_form_fields.dart';

class AddProductPricingInventory extends StatelessWidget {
  final TextEditingController purchasePriceController;
  final TextEditingController sellingPriceController;
  final TextEditingController stockController;
  final TextEditingController barcodeController;
  final TextEditingController descriptionController;
  final String? barcodeError;
  final List<BrandModel> brands;
  final List<CategoryModel> categories;
  final String? selectedBrandId;
  final String? selectedCategoryId;
  final ValueChanged<String?> onBrandChanged;
  final ValueChanged<String?> onCategoryChanged;
  final VoidCallback onScanBarcode;

  const AddProductPricingInventory({
    super.key,
    required this.purchasePriceController,
    required this.sellingPriceController,
    required this.stockController,
    required this.barcodeController,
    required this.descriptionController,
    required this.barcodeError,
    required this.brands,
    required this.categories,
    required this.selectedBrandId,
    required this.selectedCategoryId,
    required this.onBrandChanged,
    required this.onCategoryChanged,
    required this.onScanBarcode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pricing & Inventory",
          style: TextStyle(
            fontSize: AppSizes.font16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: AppSizes.size20),
        _buildFormRow(
          context,
          child1: AddProductFormFields.buildPurchasePriceField(
            controller: purchasePriceController,
          ),
          child2: AddProductFormFields.buildSellingPriceField(
            controller: sellingPriceController,
          ),
        ),
        const SizedBox(height: AppSizes.size15),
        _buildFormRow(
          context,
          child1: AddProductFormFields.buildBrandDropdown(
            brands: brands,
            selectedBrandId: selectedBrandId,
            onChanged: onBrandChanged,
          ),
          child2: AddProductFormFields.buildCategoryDropdown(
            categories: categories,
            selectedCategoryId: selectedCategoryId,
            onChanged: onCategoryChanged,
          ),
        ),
        const SizedBox(height: AppSizes.size15),
        _buildFormRow(
          context,
          child1: AddProductBarcodeStockFields.buildStockField(
            controller: stockController,
          ),
          child2: AddProductBarcodeStockFields.buildBarcodeField(
            controller: barcodeController,
            barcodeError: barcodeError,
            onScanBarcode: onScanBarcode,
          ),
        ),
        const SizedBox(height: AppSizes.size20),
        const Text(
          "Product Description",
          style: TextStyle(
            fontSize: AppSizes.font16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: AppSizes.size7),
        AppCustomTextField.multilineField(
          controller: descriptionController,
          hint: "Enter Product Description",
          icon: Icons.description_outlined,
          minLines: 4,
          textInputAction: TextInputAction.done,
          validator: (value) => null,
        ),
        const SizedBox(height: AppSizes.size25),
      ],
    );
  }

  Widget _buildFormRow(
    BuildContext context, {
    required Widget child1,
    required Widget child2,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: child1),
        const SizedBox(width: AppSizes.size10),
        Expanded(child: child2),
      ],
    );
  }
}
