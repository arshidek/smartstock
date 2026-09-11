import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/validator.dart';
import '../../../core/widgets/textfields/app_custom_text_field.dart';
import 'add_product_image_picker.dart';

/// Section for product name and images in the Add Product screen.
class AddProductImageName extends StatelessWidget {
  final List<File> images;
  final String? imageError;
  final String? productError;
  final TextEditingController productNameController;
  final VoidCallback onPickImages;
  final Function(int) onRemoveImage;

  const AddProductImageName({
    super.key,
    required this.images,
    required this.imageError,
    required this.productError,
    required this.productNameController,
    required this.onPickImages,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppSizes.padding20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainImagePicker(
                    images: images,
                    onPickImages: onPickImages,
                    onRemoveImage: onRemoveImage,
                    imageError: imageError,
                  ),
                ],
              ),
            ),

            const SizedBox(width: AppSizes.size20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text.rich(
                    TextSpan(
                      text: "Product Name ",
                      children: [
                        TextSpan(
                          text: "*",
                          style: TextStyle(color: AppColors.error),
                        ),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: AppSizes.size12,
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: AppSizes.size10),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppCustomTextField.textField(
                        controller: productNameController,
                        label: "Product Name",
                        hint: "Enter Product Name",
                        icon: Icons.widgets_outlined,
                        validator: (value) => Validator.validateName(
                          value,
                          fieldName: "Product name",
                        ),
                      ),
                      if (productError != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: AppSizes.padding10,
                            top: AppSizes.size5,
                          ),
                          child: Text(
                            productError!,
                            style: const TextStyle(
                              color: AppColors.error,
                              fontSize: AppSizes.font14,
                            ),
                          ),
                        ),
                    ],
                  ),

                  if (images.isNotEmpty)
                    ThumbnailImagePicker(
                      images: images,
                      onPickImages: onPickImages,
                      onRemoveImage: onRemoveImage,
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
