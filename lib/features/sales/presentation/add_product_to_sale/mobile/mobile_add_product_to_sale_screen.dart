import 'package:flutter/material.dart';
import '../../../../../app/app_navigation.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/widgets/search/app_search_bar.dart';
import '../../../../../data/models/brand_model.dart';
import '../../../../../data/models/category_model.dart';
import '../../../../../data/models/product_model.dart';
import '../../../../../core/widgets/filters/app_filter_bottom_sheet.dart';
import '../../../widgets/product_filter_dropdowns.dart';
import '../../../widgets/product_list_grid.dart';
import '../../../widgets/product_quantity_selector.dart';
import '../widgets/add_product_to_sale_bottom_bar.dart';

class MobileAddProductToSaleScreen extends StatelessWidget {
  final BrandModel? selectedBrand;
  final CategoryModel? selectedCategory;
  final List<BrandModel> brands;
  final List<CategoryModel> categories;
  final Function(BrandModel?) onBrandChanged;
  final Function(CategoryModel?) onCategoryChanged;
  final List<ProductModel> filteredProducts;
  final int quantity;
  final ProductModel? selectedProduct;
  final double totalPrice;
  final double ratePerUnit;
  final Widget Function(int) buildProductCard;
  final Function(int) onQuantityChanged;
  final VoidCallback onAddToListPressed;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final int filterCount;
  final Map<String, dynamic>? activeFilters;
  final ValueChanged<Map<String, dynamic>> applyFilters;

  const MobileAddProductToSaleScreen({
    super.key,
    required this.selectedBrand,
    required this.selectedCategory,
    required this.brands,
    required this.categories,
    required this.onBrandChanged,
    required this.onCategoryChanged,
    required this.filteredProducts,
    required this.quantity,
    required this.selectedProduct,
    required this.totalPrice,
    required this.ratePerUnit,
    required this.buildProductCard,
    required this.onQuantityChanged,
    required this.onAddToListPressed,
    required this.searchController,
    required this.onSearchChanged,
    required this.filterCount,
    required this.activeFilters,
    required this.applyFilters,
  });

  Future<void> _openFilterBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AppFilterBottomSheet(initialFilters: activeFilters),
    );

    if (result != null) {
      applyFilters(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: const Text(
          'Add Product ',
          style: TextStyle(
            fontSize: AppSizes.font24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
            size: AppSizes.size30,
          ),
          onPressed: () => AppNavigation.goBack(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.background),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.size10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding16,
                ),
                child: AppSearchBar(
                  controller: searchController,
                  hintText: "Search product name or ...",
                  showFilter: true,
                  filterCount: filterCount,
                  onChanged: onSearchChanged,
                  onFilterTap: () => _openFilterBottomSheet(context),
                ),
              ),
              ProductFilterDropdowns(
                selectedBrand: selectedBrand,
                selectedCategory: selectedCategory,
                brands: brands,
                categories: categories,
                onBrandChanged: onBrandChanged,
                onCategoryChanged: onCategoryChanged,
              ),
              const SizedBox(height: AppSizes.size20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.padding16),
                child: Text(
                  "Products",
                  style: TextStyle(
                    fontSize: AppSizes.font18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.size10),
              ProductListGrid(
                filteredProducts: filteredProducts,
                buildProductCard: buildProductCard,
              ),
              ProductQuantitySelector(
                quantity: quantity,
                selectedProduct: selectedProduct,
                onQuantityChanged: onQuantityChanged,
              ),
              const Divider(),
              AddProductToSaleBottomBar(
                totalPrice: totalPrice,
                quantity: quantity,
                ratePerUnit: ratePerUnit,
                onAddToListPressed: onAddToListPressed,
              ),
              const SizedBox(height: AppSizes.size25),
            ],
          ),
        ),
      ),
    );
  }
}
