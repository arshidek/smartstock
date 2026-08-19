import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../app/app_navigation.dart';
import '../../../core/services/category_service.dart';
import '../../../core/services/product_service.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/utils/image_picker_helper.dart';
import '../../../core/widgets/dialogs/app_info_dialog.dart';
import '../../../data/models/category_model.dart';

class CategoryFunctions {
  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();

  bool _isPickingImage = false;

  CategoryFunctions();

  Future<bool> saveCategory({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController categoryController,
    required TextEditingController descriptionController,
    String? imagePath,
  }) async {
    if (_categoryService.categoryExists(categoryController.text.trim())) {
      return false;
    }

    final category = CategoryModel(
      id: const Uuid().v4(),
      name: categoryController.text.trim(),
      description: descriptionController.text.trim(),
      imagePath: imagePath,
    );

    await _categoryService.saveCategories(category);

    AppSnackBar.success(context, "Category added successfully!");

    AppNavigation.goBackWithResult(context, true);

    return true;
  }

  // Update Category
  Future<void> updateCategory({
    required BuildContext context,
    required CategoryModel category,
    required GlobalKey<FormState> formKey,
    required TextEditingController categoryController,
    required TextEditingController descriptionController,
    required String imagePath,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Update values
    category.name = categoryController.text.trim();
    category.description = descriptionController.text.trim();
    category.imagePath = imagePath;

    // Save to Hive
    await category.save();

    AppSnackBar.success(context, "Category updated successfully!");

    AppNavigation.goBackWithResult(context, true);
  }

  Future<void> deleteCategory({
    required BuildContext context,
    required CategoryModel category,
  }) async {
    if (_productService.isCategoryUsed(category.id)) {
      await AppInfoDialog.show(
        context: context,
        title: "Cannot Delete Category",
        message:
            "This category is already assigned to one or more products.\n\nPlease delete or update those products first.",
      );

      return;
    }

    await _categoryService.deleteCategory(category.id);

    AppSnackBar.success(context, "Category deleted successfully!");

    AppNavigation.goBackWithResult(context, true);
  }

  Future<XFile?> pickCategoryImage() async {
    if (_isPickingImage) return null;

    _isPickingImage = true;

    try {
      return await ImagePickerHelper.pickImageXFile();
    } finally {
      _isPickingImage = false;
    }
  }

  List<CategoryModel> getCategories() {
    return _categoryService.getAllCategories();
  }

  List<CategoryModel> searchCategories({
    required List<CategoryModel> categories,
    required String query,
  }) {
    if (query.trim().isEmpty) {
      return categories;
    }

    return categories.where((category) {
      return category.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
