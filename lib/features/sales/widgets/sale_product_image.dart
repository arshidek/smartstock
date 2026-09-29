import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class SaleProductImage extends StatelessWidget {
  final String? imagePath;

  const SaleProductImage({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.size85,
      height: AppSizes.size85,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
      ),
      child: Container(
        width: AppSizes.size90,
        height: AppSizes.size90,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
          border: Border.all(color: AppColors.lightBlue),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
          child: imagePath != null && imagePath!.isNotEmpty
              ? imagePath!.startsWith('data:image')
                    ? Image.memory(
                        UriData.parse(imagePath!).contentAsBytes(),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.image_not_supported_outlined,
                              color: AppColors.grey,
                              size: AppSizes.size32,
                            ),
                      )
                    : kIsWeb
                    ? Image.network(
                        imagePath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.image_not_supported_outlined,
                              color: AppColors.grey,
                              size: AppSizes.size32,
                            ),
                      )
                    : Image.file(
                        File(imagePath!),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.image_not_supported_outlined,
                              color: AppColors.grey,
                              size: AppSizes.size32,
                            ),
                      )
              : const Icon(
                  Icons.image_outlined,
                  color: AppColors.grey,
                  size: AppSizes.size32,
                ),
        ),
      ),
    );
  }
}
