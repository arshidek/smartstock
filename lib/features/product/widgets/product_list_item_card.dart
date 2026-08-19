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
        // Product Image
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: imagePath != null && imagePath!.isNotEmpty
              ? kIsWeb
                    ? Image.network(
                        imagePath!,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(imagePath!),
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      )
              : const Icon(
                  Icons.image_outlined,
                  size: 40,
                  color: AppColors.grey,
                ),
        ),

        const SizedBox(width: AppSizes.size15),

        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Left Side
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 18, // Slightly larger
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      brandName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      categoryName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppSizes.size12),

              /// Right Side
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 1. Stock Banner (top right)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: stockColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      stockStatus,
                      style: TextStyle(
                        color: stockColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 2. Stock Count (middle)
                  Text(
                    "Stock : $stock",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppColors.grey,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 3. Price (bottom)
                  Text(
                    "₹$sellingPrice",
                    style: const TextStyle(
                      fontSize: 18,
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
