import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/services/brand_service.dart';
import '../../../../core/services/category_service.dart';
import '../../../../core/services/product_service.dart';
import '../../../../data/models/brand_model.dart';
import '../../../../data/models/category_model.dart';
import '../../../../data/models/product_model.dart';

class EditProductState {
  final BrandService brandService;
  final CategoryService categoryService;
  final ProductService productService;

  List<CategoryModel> categories = [];
  List<BrandModel> brands = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedBrandId;
  String? selectedCategoryId;
  bool status = true;
  List<File> images = [];
  String? imageError;

  EditProductState({
    required this.brandService,
    required this.categoryService,
    required this.productService,
  });

  void loadProduct(ProductModel widgetProduct) {
    final product = productService.getProductById(widgetProduct.id);

    if (product == null) return;

    productNameController.text = product.name;
    purchasePriceController.text = product.purchasePrice.toString();
    sellingPriceController.text = product.sellingPrice.toString();
    stockController.text = product.stock.toString();
    barcodeController.text = product.barcode;
    descriptionController.text = product.description;
    selectedBrandId = product.brandId;
    selectedCategoryId = product.categoryId;
    status = product.isActive;

    if (product.allImages.isNotEmpty) {
      images = product.allImages.map((e) => File(e)).toList();
    }
  }

  void dispose() {
    productNameController.dispose();
    purchasePriceController.dispose();
    sellingPriceController.dispose();
    stockController.dispose();
    barcodeController.dispose();
    descriptionController.dispose();
  }
}
