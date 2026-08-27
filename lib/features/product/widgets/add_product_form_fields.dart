import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/validator.dart';
import '../../../core/widgets/dropdowns/app_custom_dropdown.dart';
import '../../../core/widgets/textfields/app_custom_text_field.dart';
import '../../../data/models/brand_model.dart';
import '../../../data/models/category_model.dart';

class AddProductFormFields {
  static Widget buildPurchasePriceField({
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text.rich(
          TextSpan(
            text: "Purchase Price (₹) ",
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
          label: "Purchase Price",
          hint: "Enter Purchase Price",
          icon: Icons.currency_rupee,
          keyboardType: TextInputType.number,
          validator: (value) =>
              Validator.validatePrice(value, fieldName: "Purchase Price"),
        ),
      ],
    );
  }

  static Widget buildSellingPriceField({
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text.rich(
          TextSpan(
            text: "Selling Price (₹) ",
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
          label: "Selling Price",
          hint: "Enter Selling Price",
          icon: Icons.sell,
          keyboardType: TextInputType.number,
          validator: (value) =>
              Validator.validatePrice(value, fieldName: "Selling Price"),
        ),
      ],
    );
  }

  static Widget buildBrandDropdown({
    required List<BrandModel> brands,
    required String? selectedBrandId,
    required ValueChanged<String?> onChanged,
  }) {
    return AppCustomDropdown.dropdown<String>(
      label: "Brand",
      icon: Icons.workspace_premium_outlined,
      value: selectedBrandId,
      validator: (value) => Validator.validateDropdown(value, "Brand"),
      items: brands.map((b) => b.id).toList(),
      itemLabel: (id) => brands.firstWhere((b) => b.id == id).name,
      onChanged: onChanged,
    );
  }

  static Widget buildCategoryDropdown({
    required List<CategoryModel> categories,
    required String? selectedCategoryId,
    required ValueChanged<String?> onChanged,
  }) {
    return AppCustomDropdown.dropdown<String>(
      label: "Category",
      icon: Icons.local_offer_outlined,
      value: selectedCategoryId,
      validator: (value) => Validator.validateDropdown(value, "Category"),
      items: categories.map((c) => c.id).toList(),
      itemLabel: (id) => categories.firstWhere((c) => c.id == id).name,
      onChanged: onChanged,
    );
  }
}
