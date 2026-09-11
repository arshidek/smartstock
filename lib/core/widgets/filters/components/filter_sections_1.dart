import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../constants/app_colors.dart';
import 'filter_base_components.dart';

class FilterSortSection extends StatelessWidget {
  final String? selectedSort;
  final ValueChanged<String?> onSortChanged;

  const FilterSortSection({
    Key? key,
    required this.selectedSort,
    required this.onSortChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterSectionCard(
      icon: Icons.swap_vert_rounded,
      title: "Sort By",
      subtitle: "Choose how to sort your products",
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FilterCustomChip(
                  label: "A - Z",
                  subLabel: "Name (A to Z)",
                  icon: Icons.sort_by_alpha,
                  iconColor: AppColors.blue,
                  iconBackgroundColor: AppColors.blue.withOpacity(0.1),
                  isSelected: selectedSort == "A - Z",
                  onTap: () =>
                      onSortChanged(selectedSort == "A - Z" ? null : "A - Z"),
                ),
              ),
              const SizedBox(width: AppSizes.size10),
              Expanded(
                child: FilterCustomChip(
                  label: "Z - A",
                  subLabel: "Name (Z to A)",
                  icon: Icons.sort_by_alpha,
                  iconColor: AppColors.blue,
                  iconBackgroundColor: AppColors.blue.withOpacity(0.1),
                  isSelected: selectedSort == "Z - A",
                  onTap: () =>
                      onSortChanged(selectedSort == "Z - A" ? null : "Z - A"),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.size10),
          Row(
            children: [
              Expanded(
                child: FilterCustomChip(
                  label: "Price",
                  subLabel: "Low to High",
                  icon: Icons.local_offer_outlined,
                  iconColor: AppColors.success,
                  iconBackgroundColor: Colors.green.withOpacity(0.1),
                  isSelected: selectedSort == "Price: Low to High",
                  onTap: () => onSortChanged(
                    selectedSort == "Price: Low to High"
                        ? null
                        : "Price: Low to High",
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.size10),
              Expanded(
                child: FilterCustomChip(
                  label: "Price",
                  subLabel: "High to Low",
                  icon: Icons.local_offer_outlined,
                  iconColor: AppColors.warning,
                  iconBackgroundColor: AppColors.warning.withOpacity(0.1),
                  isSelected: selectedSort == "Price: High to Low",
                  onTap: () => onSortChanged(
                    selectedSort == "Price: High to Low"
                        ? null
                        : "Price: High to Low",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.size10),
          Row(
            children: [
              Expanded(
                child: FilterCustomChip(
                  label: "Stock",
                  subLabel: "Low to High",
                  icon: Icons.inventory_2_outlined,
                  iconColor: AppColors.blue,
                  iconBackgroundColor: AppColors.blue.withOpacity(0.1),
                  isSelected: selectedSort == "Stock: Low to High",
                  onTap: () => onSortChanged(
                    selectedSort == "Stock: Low to High"
                        ? null
                        : "Stock: Low to High",
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.size10),
              Expanded(
                child: FilterCustomChip(
                  label: "Recently Added",
                  subLabel: "Newest First",
                  icon: Icons.access_time,
                  iconColor: AppColors.error,
                  iconBackgroundColor: AppColors.error.withOpacity(0.1),
                  isSelected: selectedSort == "Recently Added",
                  onTap: () => onSortChanged(
                    selectedSort == "Recently Added" ? null : "Recently Added",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FilterStockSection extends StatelessWidget {
  final String? stockStatus;
  final ValueChanged<String?> onStockChanged;

  const FilterStockSection({
    Key? key,
    required this.stockStatus,
    required this.onStockChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterSectionCard(
      icon: Icons.inventory_2_rounded,
      title: "Stock Status",
      subtitle: "Filter by product availability",
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: FilterCustomChip(
                  label: "All",
                  icon: Icons.apps_rounded,
                  iconColor: AppColors.blue,
                  iconBackgroundColor: AppColors.blue.withOpacity(0.1),
                  isSelected: stockStatus == "All",
                  onTap: () =>
                      onStockChanged(stockStatus == "All" ? null : "All"),
                ),
              ),
              const SizedBox(width: AppSizes.size10),
              Expanded(
                child: FilterCustomChip(
                  label: "In Stock",
                  icon: Icons.inventory_2_outlined,
                  iconColor: AppColors.success,
                  isSelected: stockStatus == "In Stock",
                  onTap: () => onStockChanged(
                    stockStatus == "In Stock" ? null : "In Stock",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.size10),
          Row(
            children: [
              Expanded(
                child: FilterCustomChip(
                  label: "Low Stock",
                  icon: Icons.warning_amber_rounded,
                  iconColor: AppColors.warning,
                  isSelected: stockStatus == "Low Stock",
                  onTap: () => onStockChanged(
                    stockStatus == "Low Stock" ? null : "Low Stock",
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.size10),
              Expanded(
                child: FilterCustomChip(
                  label: "Out of Stock",
                  icon: Icons.block,
                  iconColor: AppColors.error,
                  isSelected: stockStatus == "Out of Stock",
                  onTap: () => onStockChanged(
                    stockStatus == "Out of Stock" ? null : "Out of Stock",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
