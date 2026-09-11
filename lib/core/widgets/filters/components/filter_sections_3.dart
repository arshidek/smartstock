import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../../data/models/brand_model.dart';
import '../../../../data/models/category_model.dart';
import 'filter_base_components.dart';

class FilterCheckboxList extends StatelessWidget {
  final List<String> items;
  final Set<String> selectedSet;
  final ValueChanged<String> onToggleItem;

  const FilterCheckboxList({
    Key? key,
    required this.items,
    required this.selectedSet,
    required this.onToggleItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(AppSizes.padding16),
        child: Text("No items found.", style: TextStyle(color: AppColors.grey)),
      );
    }
    return Container(
      constraints: const BoxConstraints(maxHeight: AppSizes.size250),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: items.length,
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppSizes.size8),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = selectedSet.contains(item);
          return GestureDetector(
            onTap: () => onToggleItem(item),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.padding16,
                vertical: AppSizes.padding12,
              ),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: AppSizes.size20,
                    height: AppSizes.size20,
                    child: Checkbox(
                      value: isSelected,
                      activeColor: AppColors.blue,
                      onChanged: (bool? value) => onToggleItem(item),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: BorderSide(color: AppColors.lightGrey, width: 1.5),
                    ),
                  ),
                  const SizedBox(width: AppSizes.size15),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        fontSize: AppSizes.font14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FilterCategorySection extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggleExpand;
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;
  final List<CategoryModel> filteredCategories;
  final Set<String> selectedCategories;
  final ValueChanged<String> onToggleCategory;

  const FilterCategorySection({
    Key? key,
    required this.isExpanded,
    required this.onToggleExpand,
    required this.searchController,
    required this.onSearch,
    required this.filteredCategories,
    required this.selectedCategories,
    required this.onToggleCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterSectionCard(
      icon: Icons.category_outlined,
      title: "Category",
      subtitle: "Filter by specific categories",
      child: Column(
        children: [
          GestureDetector(
            onTap: onToggleExpand,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.padding16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
              ),
              child: Row(
                children: [
                  Icon(Icons.folder_outlined, color: AppColors.grey),
                  const SizedBox(width: AppSizes.size12),
                  Expanded(
                    child: Text(
                      selectedCategories.isEmpty
                          ? "Select Categories..."
                          : "${selectedCategories.length} Selected",
                      style: TextStyle(
                        color: selectedCategories.isEmpty
                            ? AppColors.grey
                            : AppColors.black,
                        fontWeight: selectedCategories.isEmpty
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.grey,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const SizedBox(height: AppSizes.size15),
            TextField(
              controller: searchController,
              onChanged: onSearch,
              decoration: InputDecoration(
                hintText: "Search Category...",
                prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                filled: true,
                fillColor: AppColors.lightBlue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: AppSizes.size15),
            FilterCheckboxList(
              items: filteredCategories.map((e) => e.name).toList(),
              selectedSet: selectedCategories,
              onToggleItem: onToggleCategory,
            ),
          ],
        ],
      ),
    );
  }
}

class FilterBrandSection extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggleExpand;
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;
  final List<BrandModel> filteredBrands;
  final Set<String> selectedBrands;
  final ValueChanged<String> onToggleBrand;

  const FilterBrandSection({
    Key? key,
    required this.isExpanded,
    required this.onToggleExpand,
    required this.searchController,
    required this.onSearch,
    required this.filteredBrands,
    required this.selectedBrands,
    required this.onToggleBrand,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterSectionCard(
      icon: Icons.branding_watermark_outlined,
      title: "Brand",
      subtitle: "Filter by product brands",
      child: Column(
        children: [
          GestureDetector(
            onTap: onToggleExpand,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.padding16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
              ),
              child: Row(
                children: [
                  Icon(Icons.local_offer_outlined, color: AppColors.grey),
                  const SizedBox(width: AppSizes.size12),
                  Expanded(
                    child: Text(
                      selectedBrands.isEmpty
                          ? "Select Brands..."
                          : "${selectedBrands.length} Selected",
                      style: TextStyle(
                        color: selectedBrands.isEmpty
                            ? AppColors.grey
                            : AppColors.black,
                        fontWeight: selectedBrands.isEmpty
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.grey,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const SizedBox(height: AppSizes.size15),
            TextField(
              controller: searchController,
              onChanged: onSearch,
              decoration: InputDecoration(
                hintText: "Search Brands...",
                prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                filled: true,
                fillColor: AppColors.lightBlue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: AppSizes.size15),
            FilterCheckboxList(
              items: filteredBrands.map((e) => e.name).toList(),
              selectedSet: selectedBrands,
              onToggleItem: onToggleBrand,
            ),
          ],
        ],
      ),
    );
  }
}
