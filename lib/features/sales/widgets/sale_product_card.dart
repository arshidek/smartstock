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
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSizes.padding16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
            border: Border.all(
              color: isSelected ? AppColors.blue : AppColors.lightGrey,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(.06),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final row = Row(
                children: [
                  /// IMAGE
                  Container(
                    width: AppSizes.size85,
                    height: AppSizes.size85,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius16,
                      ),
                    ),
                    child: Container(
                      width: AppSizes.size90,
                      height: AppSizes.size90,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius16,
                        ),
                        border: Border.all(color: AppColors.lightBlue),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius16,
                        ),
                        child: imagePath != null && imagePath!.isNotEmpty
                            ? imagePath!.startsWith('data:image')
                                  ? Image.memory(
                                      UriData.parse(
                                        imagePath!,
                                      ).contentAsBytes(),
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (
                                            context,
                                            error,
                                            stackTrace,
                                          ) => const Icon(
                                            Icons.image_not_supported_outlined,
                                            color: AppColors.grey,
                                            size: AppSizes.size32,
                                          ),
                                    )
                                  : kIsWeb
                                  ? Image.network(
                                      imagePath!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (
                                            context,
                                            error,
                                            stackTrace,
                                          ) => const Icon(
                                            Icons.image_not_supported_outlined,
                                            color: AppColors.grey,
                                            size: AppSizes.size32,
                                          ),
                                    )
                                  : Image.file(
                                      File(imagePath!),
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (
                                            context,
                                            error,
                                            stackTrace,
                                          ) => const Icon(
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
                  ),

                  const SizedBox(width: AppSizes.size15),

                  /// DETAILS
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// LEFT COLUMN
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: AppSizes.font18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: AppSizes.size8),
                              Text(
                                "$brand • $category",
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontSize: AppSizes.font14,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: AppSizes.size8),

                        /// RIGHT COLUMN
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            showStatus
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSizes.padding10,
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
                                        fontSize: AppSizes.font12,
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
                                          fontSize: AppSizes.font13,
                                        ),
                                      ),
                                      const SizedBox(height: AppSizes.size5),
                                      Text(
                                        trailingBottom ?? "",
                                        style: const TextStyle(
                                          color: AppColors.grey,
                                          fontSize: AppSizes.font12,
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: AppSizes.size8),
                            Text(
                              "Stock : $stock",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: AppSizes.size8),
                            Text(
                              price,
                              style: const TextStyle(
                                fontSize: AppSizes.font20,
                                color: AppColors.success,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );

              return FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: SizedBox(width: constraints.maxWidth, child: row),
              );
            },
          ),
        ),
      ),
    );
  }
}
