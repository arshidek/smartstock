import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../app/app_navigation.dart';
import '../../../core/services/brand_service.dart';
import '../../../core/services/product_service.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/utils/image_picker_helper.dart';
import '../../../core/widgets/dialogs/app_info_dialog.dart';
import '../../../data/models/brand_model.dart';
import '../presentation/add_brand/add_brand_bottom_sheet.dart';
import '../presentation/brand_details/brand_details_screen.dart';

class BrandFunctions {
  final BrandService _brandService = BrandService();
  final ProductService _productService = ProductService();

  bool _isPickingImage = false;

  List<BrandModel> getBrands() {
    return _brandService.getAllBrands();
  }

  Future<bool> saveBrand({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController brandController,
    required TextEditingController descriptionController,
    String? imagePath,
  }) async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    if (_brandService.brandExists(brandController.text.trim())) {
      return false;
    }

    final brand = BrandModel(
      id: const Uuid().v4(),
      name: brandController.text.trim(),
      description: descriptionController.text.trim(),
      imagePath: imagePath,
    );

    await _brandService.saveBrand(brand);

    AppSnackBar.success(context, "Brand added successfully!");

    AppNavigation.goBackWithResult(context, true);

    return true;
  }

  // Update Brand
  Future<String?> updateBrand({
    required BuildContext context,
    required BrandModel brand,
    required GlobalKey<FormState> formKey,
    required TextEditingController brandController,
    required TextEditingController descriptionController,
    required XFile? image,
  }) async {
    if (image == null) {
      return "Please select a brand image";
    }

    if (!formKey.currentState!.validate()) {
      return "Validation failed";
    }

    if (_brandService.brandExists(
      brandController.text.trim(),
      excludeId: brand.id,
    )) {
      return "Brand already exists";
    }

    brand.name = brandController.text.trim();
    brand.description = descriptionController.text.trim();
    brand.imagePath = image.path;

    await _brandService.saveBrand(brand);

    AppSnackBar.success(context, "Brand updated successfully!");

    AppNavigation.goBackWithResult(context, true);

    return null;
  }

  Future<void> deleteBrand({
    required BuildContext context,
    required BrandModel brand,
  }) async {
    debugPrint("Delete Brand Clicked");

    if (_productService.isBrandUsed(brand.id)) {
      await AppInfoDialog.show(
        context: context,
        title: "Cannot Delete Brand",
        message:
            "This brand is already assigned to one or more products.\n"
            "\nPlease delete or update those products first.",
      );

      return;
    }

    await _brandService.deleteBrand(brand.id);

    AppSnackBar.success(context, "Brand deleted successfully!");

    AppNavigation.goBackWithResult(context, true);
  }

  Future<bool?> openBrandDetails(BuildContext context, BrandModel brand) async {
    return await AppNavigation.goToScreen<bool>(
      context,
      BrandDetailsScreen(brand: brand),
    );
  }

  List<BrandModel> searchBrands({
    required List<BrandModel> brands,
    required String query,
  }) {
    if (query.trim().isEmpty) {
      return brands;
    }

    return brands.where((brand) {
      return brand.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  Future<bool> openAddBrand(BuildContext context) async {
    final result = await AppNavigation.showBottomSheet<bool>(
      context,
      const AddBrandBottomSheet(),
    );

    return result ?? false;
  }

  Future<XFile?> pickBrandImage() async {
    if (_isPickingImage) return null;

    _isPickingImage = true;

    try {
      return await ImagePickerHelper.pickImageXFile();
    } finally {
      _isPickingImage = false;
    }
  }
}
