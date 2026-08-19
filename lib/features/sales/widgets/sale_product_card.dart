import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class SaleProductCard extends StatelessWidget {
  final String? imagePath;
  final String name;
  final String productId;
  final String brand;
  final String category;
  final String stock;
  final String status;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;
  final String? trailingTop;
  final String? trailingBottom;
  final bool showStatus;

  const SaleProductCard({
    super.key,
    this.imagePath,
    required this.name,
    required this.productId,
    required this.brand,
    required this.category,
    required this.stock,
    required this.status,
    required this.price,
    required this.isSelected,
    required this.onTap,
    this.trailingTop,
    this.trailingBottom,
    this.showStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;

    switch (status) {
      case "Out of Stock":
        statusColor = AppColors.error;
        break;

      case "Low Stock":
        statusColor = AppColors.warning;
        break;

      default:
        statusColor = AppColors.success;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding16,
        vertical: AppSizes.size10,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.blue : AppColors.lightGrey,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.06),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              /// IMAGE
              Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.lightBlue),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: imagePath != null && imagePath!.isNotEmpty
                        ? kIsWeb
                              ? Image.network(imagePath!, fit: BoxFit.cover)
                              : Image.file(File(imagePath!), fit: BoxFit.cover)
                        : const Icon(
                            Icons.image_outlined,
                            color: AppColors.grey,
                            size: 35,
                          ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              /// DETAILS
              Expanded(
                child: Column(
                  children: [
                    /// Product Name + Price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    /// ID + Stock
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "ID : $productId",
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),

                        Text(
                          "Stock : $stock",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    /// Brand + Category + Status
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "$brand • $category",
                            style: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        showStatus
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(.15),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    trailingTop ?? "",
                                    style: const TextStyle(
                                      color: AppColors.success,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    trailingBottom ?? "",
                                    style: const TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
