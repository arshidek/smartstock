import 'dart:io';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/widgets/cards/app_card_widget.dart';
import '../../../../../data/models/brand_model.dart';
import '../../../../../data/models/category_model.dart';
import '../../../widgets/add_product_image_name.dart';
import '../../../widgets/add_product_pricing_inventory.dart';
import '../../../widgets/edit_product_action_buttons.dart';

class WebEditProductScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<File> images;
  final String? imageError;
  final TextEditingController productNameController;
  final VoidCallback onPickImages;
  final Function(int) onRemoveImage;

  final TextEditingController purchasePriceController;
  final TextEditingController sellingPriceController;
  final TextEditingController stockController;
  final TextEditingController barcodeController;
  final TextEditingController descriptionController;

  final List<BrandModel> brands;
  final List<CategoryModel> categories;
  final String? selectedBrandId;
  final String? selectedCategoryId;

  final ValueChanged<String?> onBrandChanged;
  final ValueChanged<String?> onCategoryChanged;
  final VoidCallback onScanBarcode;

  final VoidCallback onUpdateProduct;
  final VoidCallback onUpdateStock;

  const WebEditProductScreen({
    super.key,
    required this.formKey,
    required this.images,
    required this.imageError,
    required this.productNameController,
    required this.onPickImages,
    required this.onRemoveImage,
    required this.purchasePriceController,
    required this.sellingPriceController,
    required this.stockController,
    required this.barcodeController,
    required this.descriptionController,
    required this.brands,
    required this.categories,
    required this.selectedBrandId,
    required this.selectedCategoryId,
    required this.onBrandChanged,
    required this.onCategoryChanged,
    required this.onScanBarcode,
    required this.onUpdateProduct,
    required this.onUpdateStock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.background),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: AppCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddProductImageName(
                    images: images,
                    imageError: imageError,
                    productError: null,
                    productNameController: productNameController,
                    onPickImages: onPickImages,
                    onRemoveImage: onRemoveImage,
                  ),
                  const SizedBox(height: AppSizes.size20),
                  const Divider(),
                  const SizedBox(height: AppSizes.size20),
                  AddProductPricingInventory(
                    purchasePriceController: purchasePriceController,
                    sellingPriceController: sellingPriceController,
                    stockController: stockController,
                    barcodeController: barcodeController,
                    descriptionController: descriptionController,
                    barcodeError: null,
                    brands: brands,
                    categories: categories,
                    selectedBrandId: selectedBrandId,
                    selectedCategoryId: selectedCategoryId,
                    onBrandChanged: onBrandChanged,
                    onCategoryChanged: onCategoryChanged,
                    onScanBarcode: onScanBarcode,
                  ),
                  const SizedBox(height: AppSizes.size40),
                  const Divider(),
                  const SizedBox(height: AppSizes.size20),
                  EditProductActionButtons(
                    onUpdateProduct: onUpdateProduct,
                    onUpdateStock: onUpdateStock,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
