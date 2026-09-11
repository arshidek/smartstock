import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class ProductMainImage extends StatelessWidget {
  final List<String> images;
  final String? displayImage;
  final int currentImageIndex;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const ProductMainImage({
    super.key,
    required this.images,
    required this.displayImage,
    required this.currentImageIndex,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
      ),
      child: Stack(
        children: [
          Center(
            child: displayImage != null && displayImage!.isNotEmpty
                ? displayImage!.startsWith('data:image')
                      ? Image.memory(
                          UriData.parse(displayImage!).contentAsBytes(),
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.image_not_supported_outlined,
                                size: AppSizes.size80,
                                color: AppColors.grey,
                              ),
                        )
                      : kIsWeb
                      ? Image.network(
                          displayImage!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.image_not_supported_outlined,
                                size: AppSizes.size80,
                                color: AppColors.grey,
                              ),
                        )
                      : Image.file(
                          File(displayImage!),
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.image_not_supported_outlined,
                                size: AppSizes.size80,
                                color: AppColors.grey,
                              ),
                        )
                : const Icon(
                    Icons.image_outlined,
                    size: AppSizes.size80,
                    color: AppColors.grey,
                  ),
          ),
          if (currentImageIndex == 0 && images.isNotEmpty)
            Positioned(
              top: AppSizes.padding16,
              left: AppSizes.padding16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.bannerBlue,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.yellow,
                      size: AppSizes.size15,
                    ),
                    SizedBox(width: AppSizes.size5),
                    Text(
                      "Primary",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppSizes.font12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (images.length > 1) ...[
            Positioned(
              left: AppSizes.size10,
              top: 0,
              bottom: 0,
              child: Center(
                child: InkWell(
                  onTap: onPrevious,
                  child: CircleAvatar(
                    backgroundColor: AppColors.lightBlue,
                    radius: AppSizes.borderRadius18,
                    child: const Icon(
                      Icons.chevron_left,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: AppSizes.size10,
              top: 0,
              bottom: 0,
              child: Center(
                child: InkWell(
                  onTap: onNext,
                  child: CircleAvatar(
                    backgroundColor: AppColors.lightBlue,
                    radius: AppSizes.borderRadius18,
                    child: const Icon(
                      Icons.chevron_right,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
