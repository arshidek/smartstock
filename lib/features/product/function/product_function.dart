import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../app/app_navigation.dart';
import '../../../core/services/brand_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/services/product_service.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../data/models/product_model.dart';

enum ProductSaveResult {
  success,
  duplicateProduct,
  duplicateBarcode,
  invalidForm,
}

class ProductFunction {
  ProductFunction();
  final ProductService _productService = ProductService();
  final brandService = BrandService();
  final categoryService = CategoryService();

  Future<ProductSaveResult> saveProduct({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController productNameController,
    required TextEditingController purchasePriceController,
    required TextEditingController sellingPriceController,
    required TextEditingController stockController,
    required TextEditingController barcodeController,
    required TextEditingController descriptionController,
    required String? brandId,
    required String? categoryId,
    required List<File> images, // Changed to support multi-images
    required String createdBy,
    required bool status,
  }) async {
    if (!formKey.currentState!.validate()) {
      return ProductSaveResult.invalidForm;
    }

    if (brandId == null || categoryId == null) {
      return ProductSaveResult.invalidForm;
    }

    if (_productService.productExists(productNameController.text.trim())) {
      return ProductSaveResult.duplicateProduct;
    }

    if (barcodeController.text.trim().isNotEmpty &&
        _productService.barcodeExists(barcodeController.text.trim())) {
      return ProductSaveResult.duplicateBarcode;
    }

    final product = ProductModel(
      id: const Uuid().v4(),
      productId: const Uuid().v4().substring(0, 8),
      name: productNameController.text.trim(),
      brandId: brandId,
      categoryId: categoryId,
      purchasePrice: double.parse(purchasePriceController.text),
      sellingPrice: double.parse(sellingPriceController.text),
      stock: int.parse(stockController.text),
      barcode: barcodeController.text.trim(),
      description: descriptionController.text.trim(),
      imagePath: images.isNotEmpty
          ? images.first.path
          : "", // Keep first for backward compat
      imagePaths: images
          .map((e) => e.path)
          .toList(), // Added to support multi-images
      createdBy: createdBy,
      createdAt: DateTime.now(),
      isActive: status,
    );

    await _productService.addProduct(product);
    AppSnackBar.success(context, "Product added successfully!");

    AppNavigation.goBackWithResult(context, true);

    return ProductSaveResult.success;
  }

  Future<void> updateProduct({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required ProductModel product,
    required TextEditingController productNameController,
    required TextEditingController purchasePriceController,
    required TextEditingController sellingPriceController,
    required TextEditingController stockController,
    required TextEditingController barcodeController,
    required TextEditingController descriptionController,
    required String? brandId,
    required String? categoryId,
    required List<File> images, // Changed to support multi-images
    required bool status,
  }) async {
    if (!formKey.currentState!.validate()) {
      debugPrint("Form validation failed");
      return;
    }
    if (brandId == null || categoryId == null) {
      debugPrint("Brand or Category is null");
      AppSnackBar.error(context, "Please select Brand and Category");
      return;
    }
    product.name = productNameController.text.trim();
    product.purchasePrice = double.parse(purchasePriceController.text);
    product.sellingPrice = double.parse(sellingPriceController.text);
    product.brandId = brandId;
    product.categoryId = categoryId;
    product.stock = int.parse(stockController.text);
    product.barcode = barcodeController.text.trim();
    product.description = descriptionController.text.trim();
    if (images.isNotEmpty) {
      product.imagePath = images.first.path; // Update main image
      product.imagePaths = images
          .map((e) => e.path)
          .toList(); // Added to support multi-images
    }
    product.isActive = status;
    debugPrint("Saving product...");
    await product.save();
    debugPrint("Product saved");

    AppSnackBar.success(context, "Product updated successfully!");
    AppNavigation.goBackWithResult(context, true);
  }
}
