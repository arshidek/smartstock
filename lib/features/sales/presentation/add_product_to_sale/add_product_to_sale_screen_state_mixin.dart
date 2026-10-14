import 'package:flutter/material.dart';
import '../../../../app/app_navigation.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../data/models/brand_model.dart';
import '../../../../data/models/category_model.dart';
import '../../../../data/models/product_model.dart';
import '../../../../data/models/sale_item_model.dart';
import '../../function/add_product_to_sale_functions.dart';
import '../../../product/function/product_validation_helper.dart';
import 'add_product_to_sale_screen.dart';

mixin AddProductToSaleScreenStateMixin on State<AddProductToSaleScreen> {
  List<BrandModel> brands = [];
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  List<SaleItemModel> saleItems = [];

  final AddProductToSaleFunctions functions = AddProductToSaleFunctions();
  final ProductValidationHelper validationHelper = ProductValidationHelper();

  BrandModel? selectedBrand;
  CategoryModel? selectedCategory;
  ProductModel? selectedProduct;
  int quantity = 0;
  double ratePerUnit = 0;

  final TextEditingController searchController = TextEditingController();
  Map<String, dynamic>? activeFilters;
  int filterCount = 0;

  @override
  void initState() {
    super.initState();
    saleItems = List.from(widget.saleItems);

    brands = functions.loadBrands();
    categories = functions.loadCategories();
    products = functions.loadProducts();

    // Leave selectedBrand and selectedCategory as null to default to "All"

    filterProducts();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterProducts() {
    final query = searchController.text.trim().toLowerCase();

    final filterBrands = List<String>.from(activeFilters?["brands"] ?? []);
    if (selectedBrand != null && !filterBrands.contains(selectedBrand!.name)) {
      filterBrands.add(selectedBrand!.name);
    }

    final filterCategories = List<String>.from(
      activeFilters?["categories"] ?? [],
    );
    if (selectedCategory != null &&
        !filterCategories.contains(selectedCategory!.name)) {
      filterCategories.add(selectedCategory!.name);
    }

    final stockStatus = activeFilters?["stockStatus"];
    final sort = activeFilters?["sort"];
    final startDate = activeFilters?["startDate"];
    final endDate = activeFilters?["endDate"];

    filteredProducts = validationHelper.filterProducts(
      products: products,
      search: query,
      selectedBrands: filterBrands,
      selectedCategories: filterCategories,
      stockStatus: stockStatus,
      sort: sort,
      startDate: startDate,
      endDate: endDate,
    );
  }

  void applyFilters(Map<String, dynamic> result) {
    final selectedBrands = List<String>.from(result["brands"] ?? []);
    final selectedCategories = List<String>.from(result["categories"] ?? []);
    final stockStatus = result["stockStatus"];
    final sort = result["sort"];
    final startDate = result["startDate"];
    final endDate = result["endDate"];

    int count = 0;
    if (selectedBrands.isNotEmpty) count++;
    if (selectedCategories.isNotEmpty) count++;
    if (stockStatus != null) count++;
    if (sort != null) count++;
    if (startDate != null || endDate != null) count++;

    setState(() {
      activeFilters = result;
      filterCount = count;
      filterProducts();
    });
  }

  void onAddToListPressed() {
    if (selectedProduct == null) {
      AppSnackBar.warning(context, "Please select a product.");
      return;
    }
    if (quantity <= 0) {
      AppSnackBar.warning(context, "Please enter a valid quantity.");
      return;
    }
    if (selectedProduct!.stock <= 0) {
      AppSnackBar.warning(context, "${selectedProduct!.name} is Out of Stock.");
      return;
    }

    final index = saleItems.indexWhere(
      (item) => item.productId == selectedProduct!.productId,
    );

    if (index != -1) {
      if (saleItems[index].quantity + quantity > selectedProduct!.stock) {
        AppSnackBar.warning(
          context,
          "Only ${selectedProduct!.stock} items available.",
        );
        return;
      }
      saleItems[index].quantity += quantity;
    } else {
      final brandName = brands
          .firstWhere(
            (b) => b.id == selectedProduct!.brandId,
            orElse: () => BrandModel(id: '', name: 'Unknown'),
          )
          .name;
      final categoryName = categories
          .firstWhere(
            (c) => c.id == selectedProduct!.categoryId,
            orElse: () => CategoryModel(id: '', name: 'Unknown'),
          )
          .name;

      saleItems.add(
        SaleItemModel(
          productId: selectedProduct!.productId,
          productName: selectedProduct!.name,
          brandName: brandName,
          categoryName: categoryName,
          imagePath: selectedProduct!.imagePath,
          purchasePrice: selectedProduct!.purchasePrice,
          sellingPrice: selectedProduct!.sellingPrice,
          quantity: quantity,
          totalPrice: selectedProduct!.sellingPrice * quantity,
          profit:
              (selectedProduct!.sellingPrice - selectedProduct!.purchasePrice) *
              quantity,
        ),
      );
    }

    AppSnackBar.success(context, "${selectedProduct!.name} added to sale.");
    AppNavigation.goBackWithResult(context, saleItems);
  }
}
