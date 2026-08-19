import 'package:flutter/material.dart';
import '../../../core/services/brand_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/services/product_service.dart';
import '../../../data/models/product_model.dart';
import '../function/product_validation_helper.dart';

class ProductListState {
  final TextEditingController searchController = TextEditingController();
  final ProductService productService = ProductService();
  final BrandService brandService = BrandService();
  final CategoryService categoryService = CategoryService();
  final ProductValidationHelper productValidationHelper =
      ProductValidationHelper();

  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];

  void dispose() {
    searchController.dispose();
  }

  void loadProducts() {
    allProducts = productService.getAllProducts();
    filteredProducts = List.from(allProducts);
  }

  void searchProducts(String value) {
    if (value.trim().isEmpty) {
      filteredProducts = List.from(allProducts);
      return;
    }

    filteredProducts = allProducts.where((product) {
      final brand = brandService.getBrandById(product.brandId)?.name ?? "";
      final category =
          categoryService.getCategoryById(product.categoryId)?.name ?? "";

      return product.name.toLowerCase().contains(value.toLowerCase()) ||
          product.productId.toLowerCase().contains(value.toLowerCase()) ||
          brand.toLowerCase().contains(value.toLowerCase()) ||
          category.toLowerCase().contains(value.toLowerCase());
    }).toList();
  }
}
