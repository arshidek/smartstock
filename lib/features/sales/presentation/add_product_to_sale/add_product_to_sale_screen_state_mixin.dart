import 'package:flutter/material.dart';
import '../../../../app/app_navigation.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../data/models/brand_model.dart';
import '../../../../data/models/category_model.dart';
import '../../../../data/models/product_model.dart';
import '../../../../data/models/sale_item_model.dart';
import '../../function/add_product_to_sale_functions.dart';
import 'add_product_to_sale_screen.dart';

mixin AddProductToSaleScreenStateMixin on State<AddProductToSaleScreen> {
  List<BrandModel> brands = [];
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  List<SaleItemModel> saleItems = [];

  final AddProductToSaleFunctions functions = AddProductToSaleFunctions();

  BrandModel? selectedBrand;
  CategoryModel? selectedCategory;
  ProductModel? selectedProduct;
  int quantity = 0;
  double ratePerUnit = 0;

  @override
  void initState() {
    super.initState();
    saleItems = List.from(widget.saleItems);

    brands = functions.loadBrands();
    categories = functions.loadCategories();
    products = functions.loadProducts();

    if (brands.isNotEmpty) {
      selectedBrand = brands.first;
    }

    if (categories.isNotEmpty) {
      selectedCategory = categories.first;
    }

    filterProducts();
  }

  void filterProducts() {
    filteredProducts = functions.filterProducts(
      products: products,
      selectedBrand: selectedBrand,
      selectedCategory: selectedCategory,
    );
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
      saleItems.add(
        SaleItemModel(
          productId: selectedProduct!.productId,
          productName: selectedProduct!.name,
          brandName: selectedBrand!.name,
          categoryName: selectedCategory!.name,
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
