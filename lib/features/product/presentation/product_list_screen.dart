import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/filters/app_filter_bottom_sheet.dart';
import '../../../core/widgets/search/app_search_bar.dart';
import 'add_product_screen.dart';
import '../widgets/product_empty_state.dart';
import '../widgets/product_grid_list.dart';
import '../widgets/product_list_app_bar.dart';
import 'product_list_state.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductListState _state = ProductListState();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  void _loadProducts() {
    setState(() {
      _state.loadProducts();
    });
  }

  void searchProducts(String value) {
    setState(() {
      _state.searchProducts(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: const ProductListAppBar(),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.background),

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.padding12),
              child: AppSearchBar(
                controller: _state.searchController,
                hintText: "Search by name, brand, product ID...",
                onChanged: searchProducts,
                showFilter: true,
                onFilterTap: () async {
                  final result = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const AppFilterBottomSheet(),
                  );

                  if (result != null) {
                    setState(() {
                      _state.filteredProducts = _state.productValidationHelper
                          .filterProducts(
                            products: _state.allProducts,
                            search: _state.searchController.text,
                            stockStatus: result["stockStatus"],
                            selectedBrands: List<String>.from(result["brands"]),
                            selectedCategories: List<String>.from(
                              result["categories"],
                            ),
                            sort: result["sort"],
                            startDate: result["startDate"],
                            endDate: result["endDate"],
                          );
                    });
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
                    '${_state.filteredProducts.length} Products Found',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.font16,
                    ),
                  ),
                ],
              ),
            ),

            // Products List
            Expanded(
              child: _state.filteredProducts.isEmpty
                  ? const ProductEmptyState()
                  : ProductGridList(
                      products: _state.filteredProducts,
                      brandService: _state.brandService,
                      categoryService: _state.categoryService,
                      onRefresh: _loadProducts,
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await AppNavigation.goToScreen(
            context,
            const AddProductScreen(),
          );

          if (result == true) {
            _loadProducts();
          }
        },
        backgroundColor: AppColors.blue,
        child:  Icon(Icons.add, size: AppSizes.size30,color: AppColors.white,),
      ),
    );
  }
}
