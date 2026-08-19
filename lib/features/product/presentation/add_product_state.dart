import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/services/brand_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/services/user_service.dart';
import '../../../data/models/brand_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/user_model.dart';
import '../function/product_function.dart';

class AddProductState {
  final BrandService brandService;
  final CategoryService categoryService;
  final UserService userService;
  final ProductFunction productFunction;

  List<BrandModel> brands = [];
  List<CategoryModel> categories = [];
  UserModel? currentUser;
  late String productId;
  String? selectedBrandId;
  String? selectedCategoryId;
  List<File> images = [];
  String? imageError;
  String? productError;
  String? barcodeError;

  final formKey = GlobalKey<FormState>();

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  AddProductState({
    required this.brandService,
    required this.categoryService,
    required this.userService,
    required this.productFunction,
  });

  void dispose() {
    productNameController.dispose();
    purchasePriceController.dispose();
    sellingPriceController.dispose();
    stockController.dispose();
    barcodeController.dispose();
    descriptionController.dispose();
  }
}
