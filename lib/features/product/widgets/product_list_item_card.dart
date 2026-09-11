import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class ProductListItemCard extends StatelessWidget {
  final String? imagePath;
  final String productName;
  final String brandName;
  final String categoryName;
  final double sellingPrice;
  final int stock;
  final String stockStatus;
  final Color stockColor;

  const ProductListItemCard({
    super.key,
    this.imagePath,
    required this.productName,
    required this.brandName,
    required this.categoryName,
    required this.sellingPrice,
    required this.stock,
    required this.stockStatus,
    required this.stockColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: imagePath != null && imagePath!.isNotEmpty
              ? imagePath!.startsWith('data:image')
                  ? Image.memory(
                      UriData.parse(imagePath!).contentAsBytes(),
                      width: AppSizes.size90,
                      height: AppSizes.size90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: AppSizes.size90,
                          height: AppSizes.size90,
                          color: AppColors.lightGrey.withOpacity(0.2),
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            size: AppSizes.size40,
                            color: AppColors.grey,
                          ),
                        );
                      },
                    )
                  : kIsWeb
                    ? Image.network(
                        imagePath!,
                        width: AppSizes.size90,
                        height: AppSizes.size90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: AppSizes.size90,
                            height: AppSizes.size90,
                            color: AppColors.lightGrey.withOpacity(0.2),
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                              size: AppSizes.size40,
                              color: AppColors.grey,
                            ),
                          );
                        },
                      )
                    : Image.file(
                        File(imagePath!),
                        width: AppSizes.size90,
                        height: AppSizes.size90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: AppSizes.size90,
                            height: AppSizes.size90,
                            color: AppColors.lightGrey.withOpacity(0.2),
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                              size: AppSizes.size40,
                              color: AppColors.grey,
                            ),
                          );
                        },
                      )
              : Container(
                  width: AppSizes.size90,
                  height: AppSizes.size90,
                  color: AppColors.lightGrey.withOpacity(0.2),
                  child: const Icon(
                    Icons.image_outlined,
                    size: AppSizes.size40,
                    color: AppColors.grey,
                  ),
                ),
        ),

        const SizedBox(width: AppSizes.size15),

        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: AppSizes.font18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSizes.size5),
                    Text(
                      brandName,
                      style: const TextStyle(
                        fontSize: AppSizes.font14,
                        color: AppColors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSizes.size5),
                    Text(
                      categoryName,
                      style: const TextStyle(
                        fontSize: AppSizes.font14,
                        color: AppColors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppSizes.size12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.padding10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: stockColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
                    ),
                    child: Text(
                      stockStatus,
                      style: TextStyle(
                        color: stockColor,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.font12,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSizes.size10),

                  Text(
                    "Stock : $stock",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppSizes.font13,
                      color: AppColors.grey,
                    ),
                  ),

                  const SizedBox(height: AppSizes.size10),

                  Text(
                    "₹$sellingPrice",
                    style: const TextStyle(
                      fontSize: AppSizes.font18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
