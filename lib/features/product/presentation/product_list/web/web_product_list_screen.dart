import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/widgets/search/app_search_bar.dart';
import '../../../widgets/product_empty_state.dart';
import '../../../widgets/product_grid_list.dart';
import '../product_list_state.dart';

class WebProductListScreen extends StatelessWidget {
  final ProductListState state;
  final int filterCount;
  final ValueChanged<String> onSearch;
  final VoidCallback onFilterTap;
  final VoidCallback onRefresh;

  const WebProductListScreen({
    super.key,
    required this.state,
    required this.filterCount,
    required this.onSearch,
    required this.onFilterTap,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.background),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.padding12),
            child: AppSearchBar(
              controller: state.searchController,
              hintText: "Search by name, brand, product ID...",
              onChanged: onSearch,
              showFilter: true,
              filterCount: filterCount,
              onFilterTap: onFilterTap,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.padding16,
              vertical: AppSizes.padding8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${state.filteredProducts.length} Products Found',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.font16,
                  ),
                ),
                if (filterCount > 0)
                  Text(
                    '$filterCount Filters Applied',
                    style: const TextStyle(
                      color: AppColors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: AppSizes.font13,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: state.filteredProducts.isEmpty
                ? const ProductEmptyState()
                : ProductGridList(
                    products: state.filteredProducts,
                    brandService: state.brandService,
                    categoryService: state.categoryService,
                    onRefresh: onRefresh,
                  ),
          ),
        ],
      ),
    );
  }
}
