import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import 'package:smartstock_inventory/core/widgets/buttons/app_outline_button.dart';
import 'package:smartstock_inventory/features/stock/presentation/update_stock_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/brand_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/widgets/filters/app_filter_bottom_sheet.dart';
import '../../../core/widgets/search/app_search_bar.dart';
import '../../../data/models/product_model.dart';

import '../functions/ stock_functions.dart';
import '../widgets/stock_management_card.dart';

enum StockType { outOfStock, lowStock }

class StockManagementScreen extends StatefulWidget {
  final StockType stockType;
  const StockManagementScreen({super.key, required this.stockType});

  @override
  State<StockManagementScreen> createState() => _StockManagementScreenState();
}

class _StockManagementScreenState extends State<StockManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  final StockFunction _stockFunction = StockFunction();

  List<ProductModel> outOfStockProducts = [];
  List<ProductModel> lowStockProducts = [];
  List<ProductModel> filteredOutOfStockProducts = [];
  List<ProductModel> filteredLowStockProducts = [];

  @override
  void initState() {
    super.initState();
    _stockFunction.getLowStockProducts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadProducts();
  }

  void loadProducts() {
    outOfStockProducts = _stockFunction.getOutOfStockProducts();
    lowStockProducts = _stockFunction.getLowStockProducts();
    filteredOutOfStockProducts = List.from(outOfStockProducts);
    filteredLowStockProducts = List.from(lowStockProducts);

    setState(() {});
  }

  void searchProducts(String value) {
    setState(() {
      filteredOutOfStockProducts = _stockFunction.searchProducts(
        outOfStockProducts,
        value,
      );
      filteredLowStockProducts = _stockFunction.searchProducts(
        lowStockProducts,
        value,
      );
    });
  }

  String getProductStatus(ProductModel product) {
    if (product.stock == 0) {
      return "Out of Stock";
    } else if (product.stock <= 5) {
      return "Low Stock";
    }
    return "In Stock";
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = widget.stockType == StockType.outOfStock;
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
        child: Column(
          children: [
            // Search & Filter
            Padding(
              padding: const EdgeInsets.all(AppSizes.padding16),

              child: AppSearchBar(
                controller: _searchController,
                hintText: "Search Product...",
                showFilter: true,
                onChanged: searchProducts,
                onFilterTap: () async {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) =>
                        const AppFilterBottomSheet(isSalesFilter: false),
                  );

                  loadProducts();
                },
              ),
            ),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: AppOutlineButton(
                      text: "Low Stock",
                      icon: Icons.warning_amber_rounded,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,

                          MaterialPageRoute(
                            builder: (_) => const StockManagementScreen(
                              stockType: StockType.lowStock,
                            ),
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

                          MaterialPageRoute(
                            builder: (_) => const StockManagementScreen(
                              stockType: StockType.outOfStock,
                            ),
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
              child:
                  (isOutOfStock
                          ? filteredOutOfStockProducts
                          : filteredLowStockProducts)
                      .isEmpty
                  ? const Center(
                      child: Text(
                        "No Products Found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: isOutOfStock
                          ? filteredOutOfStockProducts.length
                          : filteredLowStockProducts.length,
                      itemBuilder: (context, index) {
                        final product = isOutOfStock
                            ? filteredOutOfStockProducts[index]
                            : filteredLowStockProducts[index];
                        final brand = BrandService().getBrandById(
                          product.brandId,
                        );
                        final category = CategoryService().getCategoryById(
                          product.categoryId,
                        );

                        return StockManagementCard(
                          product: product,
                          brandName: brand?.name ?? "",
                          categoryName: category?.name ?? "",
                          onRestock: () async {
                            final result = await AppNavigation.goToScreen(
                              context,
                              UpdateStockScreen(product: product),
                            );

                            if (result == true) {
                              loadProducts();
                            }
                          },
                        );
                      },
                    ),
            ),

            // Summary Cards
          ],
        ),
      ),
    );
  }
}
