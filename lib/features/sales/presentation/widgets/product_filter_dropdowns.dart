import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/dropdowns/app_custom_dropdown.dart';
import '../../../../data/models/brand_model.dart';
import '../../../../data/models/category_model.dart';

class ProductFilterDropdowns extends StatelessWidget {
  final BrandModel? selectedBrand;
  final CategoryModel? selectedCategory;
  final List<BrandModel> brands;
  final List<CategoryModel> categories;
  final ValueChanged<BrandModel?> onBrandChanged;
  final ValueChanged<CategoryModel?> onCategoryChanged;

  const ProductFilterDropdowns({
    super.key,
    required this.selectedBrand,
    required this.selectedCategory,
    required this.brands,
    required this.categories,
    required this.onBrandChanged,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding16,
        vertical: AppSizes.size10,
      ),
      child: Row(
        children: [
          Expanded(
            child: AppCustomDropdown.dropdown<BrandModel>(
              label: "Brand",
              value: selectedBrand,
              items: brands,
              itemLabel: (b) => b.name,
              icon: Icons.workspace_premium_outlined,
              onChanged: onBrandChanged,
            ),
          ),
          const SizedBox(width: AppSizes.size12),
          Expanded(
            child: AppCustomDropdown.dropdown<CategoryModel>(
              label: "Category",
              value: selectedCategory,
              items: categories,
              itemLabel: (c) => c.name,
              icon: Icons.local_offer_outlined,
              onChanged: onCategoryChanged,
            ),
          ),
        ],
      ),
    );
  }
}
