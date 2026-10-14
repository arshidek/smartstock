import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:smartstock_inventory/features/product/presentation/product_list/product_list_state.dart';
import '../../../../app/app_navigation.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/filters/app_filter_bottom_sheet.dart';
import 'mobile/mobile_product_list_screen.dart';
import 'web/web_product_list_screen.dart';
import '../../widgets/product_list_app_bar.dart';
import '../../widgets/product_list_app_bar.dart';
import '../add_product/add_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductListState _state = ProductListState();

  int _filterCount = 0;
  Map<String, dynamic>? activeFilters;

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
    _state.loadProducts();

    if (mounted) {
      setState(() {});
    }
  }

  void _searchProducts(String value) {
    setState(() {
      _state.searchProducts(value);
    });
  }

  void _applyFilters(Map<String, dynamic> result) {
    final brands = List<String>.from(result["brands"] ?? []);

    final categories = List<String>.from(result["categories"] ?? []);

    final stockStatus = result["stockStatus"];
    final sort = result["sort"];
    final startDate = result["startDate"];
    final endDate = result["endDate"];

    int count = 0;

    if (brands.isNotEmpty) {
      count++;
    }

    if (categories.isNotEmpty) {
      count++;
    }

    if (stockStatus != null) {
      count++;
    }

    if (sort != null) {
      count++;
    }

    if (startDate != null || endDate != null) {
      count++;
    }

    setState(() {
      _filterCount = count;

      _state.filteredProducts = _state.productValidationHelper.filterProducts(
        products: _state.allProducts,
        search: _state.searchController.text,
        stockStatus: stockStatus,
        selectedBrands: brands,
        selectedCategories: categories,
        sort: sort,
        startDate: startDate,
        endDate: endDate,
      );
    });
  }

  Future<void> _openFilters() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AppFilterBottomSheet(initialFilters: activeFilters),
    );

    if (result != null) {
      activeFilters = result;
      _applyFilters(result);
    }
  }

  Future<void> _addProduct() async {
    final result = await AppNavigation.goToScreen(
      context,
      const AddProductScreen(),
    );

    if (result == true) {
      _loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      appBar: const ProductListAppBar(),

      body: kIsWeb
          ? WebProductListScreen(
              state: _state,
              filterCount: _filterCount,
              onSearch: _searchProducts,
              onFilterTap: _openFilters,
              onRefresh: _loadProducts,
            )
          : MobileProductListScreen(
              state: _state,
              filterCount: _filterCount,
              onSearch: _searchProducts,
              onFilterTap: _openFilters,
              onRefresh: _loadProducts,
            ),

      // Add Product
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        backgroundColor: AppColors.blue,

        child: Icon(Icons.add, size: AppSizes.size30, color: AppColors.white),
      ),
    );
  }
}
