import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/product_model.dart';
import '../../functions/stock_functions.dart';
import '../../../product/function/product_validation_helper.dart';
import 'mobile/mobile_stock_management_screen.dart';
import 'web/web_stock_management_screen.dart';

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
  final ProductValidationHelper _productValidationHelper =
      ProductValidationHelper();

  List<ProductModel> outOfStockProducts = [];
  List<ProductModel> lowStockProducts = [];
  List<ProductModel> filteredOutOfStockProducts = [];
  List<ProductModel> filteredLowStockProducts = [];

  int _filterCount = 0;

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

  void _applyFilters(Map<String, dynamic> result) {
    final brands = List<String>.from(result["brands"] ?? []);
    final categories = List<String>.from(result["categories"] ?? []);
    final sort = result["sort"];
    final startDate = result["startDate"];
    final endDate = result["endDate"];

    int count = 0;
    if (brands.isNotEmpty) count++;
    if (categories.isNotEmpty) count++;
    if (sort != null) count++;
    if (startDate != null || endDate != null) count++;

    setState(() {
      _filterCount = count;
      filteredOutOfStockProducts = _productValidationHelper.filterProducts(
        products: outOfStockProducts,
        search: _searchController.text,
        selectedBrands: brands,
        selectedCategories: categories,
        sort: sort,
        startDate: startDate,
        endDate: endDate,
      );

      filteredLowStockProducts = _productValidationHelper.filterProducts(
        products: lowStockProducts,
        search: _searchController.text,
        selectedBrands: brands,
        selectedCategories: categories,
        sort: sort,
        startDate: startDate,
        endDate: endDate,
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = widget.stockType == StockType.outOfStock;
    final filteredProducts = isOutOfStock
        ? filteredOutOfStockProducts
        : filteredLowStockProducts;

    if (kIsWeb) {
      return WebStockManagementScreen(
        stockType: widget.stockType,
        searchController: _searchController,
        filterCount: _filterCount,
        filteredProducts: filteredProducts,
        loadProducts: loadProducts,
        searchProducts: searchProducts,
        applyFilters: _applyFilters,
      );
    }

    return MobileStockManagementScreen(
      stockType: widget.stockType,
      searchController: _searchController,
      filterCount: _filterCount,
      filteredProducts: filteredProducts,
      loadProducts: loadProducts,
      searchProducts: searchProducts,
      applyFilters: _applyFilters,
    );
  }
}
