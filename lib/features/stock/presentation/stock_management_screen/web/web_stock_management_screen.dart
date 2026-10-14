import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import 'package:smartstock_inventory/core/widgets/buttons/app_outline_button.dart';
import 'package:smartstock_inventory/core/widgets/search/app_search_bar.dart';
import 'package:smartstock_inventory/data/models/product_model.dart';
import '../../../../../core/widgets/filters/app_filter_bottom_sheet.dart';
import '../../../widgets/stock_product_list.dart';
import '../stock_management_screen.dart';

class WebStockManagementScreen extends StatelessWidget {
  final StockType stockType;
  final TextEditingController searchController;
  final int filterCount;
  final List<ProductModel> filteredProducts;
  final VoidCallback loadProducts;
  final ValueChanged<String> searchProducts;
  final ValueChanged<Map<String, dynamic>> applyFilters;
  final Map<String, dynamic>? activeFilters;

  const WebStockManagementScreen({
    super.key,
    required this.stockType,
    required this.searchController,
    required this.filterCount,
    required this.filteredProducts,
    required this.loadProducts,
    required this.searchProducts,
    required this.applyFilters,
    this.activeFilters,
  });

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = stockType == StockType.outOfStock;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
            size: AppSizes.size30,
            fontWeight: FontWeight.bold,
          ),
          onPressed: () => AppNavigation.goBack(context),
        ),
        title: Text(
          isOutOfStock ? 'Out of Stock' : 'Low Stock',
          style: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.font24,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.background),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                // Search & Filter
                Padding(
                  padding: const EdgeInsets.all(AppSizes.padding16),
                  child: AppSearchBar(
                    controller: searchController,
                    hintText: "Search Product...",
                    showFilter: true,
                    filterCount: filterCount,
                    onChanged: searchProducts,
                    onFilterTap: () async {
                      final result = await showDialog<Map<String, dynamic>>(
                        context: context,
                        builder: (_) => Dialog(
                          child: SizedBox(
                            width: 400,
                            child: AppFilterBottomSheet(
                              isSalesFilter: false,
                              initialFilters: activeFilters,
                            ),
                          ),
                        ),
                      );

                      if (result != null) {
                        applyFilters(result);
                      } else {
                        loadProducts();
                      }
                    },
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
                        '${filteredProducts.length} Products Found',
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

                // Tabs
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.padding16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppOutlineButton(
                          text: "Low Stock",
                          icon: Icons.warning_amber_rounded,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const StockManagementScreen(
                                          stockType: StockType.lowStock,
                                        ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          borderColor: AppColors.warning,
                          textColor: AppColors.warning,
                          iconColor: AppColors.warning,
                          backgroundColor: AppColors.warning,
                          isSelected: !isOutOfStock,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppOutlineButton(
                          text: "Out of Stock",
                          icon: Icons.cancel_outlined,
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const StockManagementScreen(
                                          stockType: StockType.outOfStock,
                                        ),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          borderColor: AppColors.error,
                          textColor: AppColors.error,
                          iconColor: AppColors.error,
                          backgroundColor: AppColors.error,
                          isSelected: isOutOfStock,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSizes.size15),

                // Products List
                Expanded(
                  child: StockProductList(
                    products: filteredProducts,
                    loadProducts: loadProducts,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
