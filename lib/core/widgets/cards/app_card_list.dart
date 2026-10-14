import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppCardList extends StatelessWidget {
  final String? imagePath;
  final String name;
  final String subtitle;
  final String totalValue;
  final VoidCallback? onTap;
  final String? productId;
  final String? brand;
  final String? category;
  final String? stock;
  final String? status;

  const AppCardList({
    super.key,
    this.imagePath,
    required this.name,
    required this.subtitle,
    required this.totalValue,
    this.onTap,
    this.productId,
    this.brand,
    this.category,
    this.stock,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = status?.toUpperCase() == "OUT OF STOCK";
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.padding16),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(AppSizes.padding16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.08),
                  blurRadius: AppSizes.blurRadius,
                  spreadRadius: 1,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                /// Image
                Container(
                  width: AppSizes.size80,
                  height: AppSizes.size80,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadius16,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadius16,
                    ),
                    child: imagePath != null && imagePath!.isNotEmpty
                        ? (kIsWeb
                              ? Image.network(
                                  imagePath!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.image_outlined,
                                        size: AppSizes.size32,
                                        color: AppColors.grey,
                                      ),
                                )
                              : ((kIsWeb || File(imagePath!).existsSync())
                                    ? kIsWeb
                                          ? Image.network(
                                              imagePath!,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(
                                              File(imagePath!),
                                              fit: BoxFit.cover,
                                            )
                                    : const Icon(
                                        Icons.image_outlined,
                                        size: AppSizes.size32,
                                        color: AppColors.grey,
                                      )))
                        : const Icon(
                            Icons.image_outlined,
                            size: AppSizes.size32,
                            color: AppColors.grey,
                          ),
                  ),
                ),

                const SizedBox(width: AppSizes.size10),

                /// Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: AppSizes.size20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Product ID (Optional)
                      if (productId != null) ...[
                        const SizedBox(height: AppSizes.size5),
                        Text(
                          "ID : $productId",
                          style: const TextStyle(
                            fontSize: AppSizes.font14,
                            color: AppColors.grey,
                          ),
                        ),
                      ],

                      // Brand & Category (Optional)
                      if (brand != null || category != null) ...[
                        const SizedBox(height: AppSizes.size5),
                        Text(
                          "${brand ?? ""}${brand != null && category != null ? " • " : ""}${category ?? ""}",
                          style: const TextStyle(
                            fontSize: AppSizes.font14,
                            color: AppColors.grey,
                          ),
                        ),
                      ],

                      // Subtitle (Existing)
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: AppSizes.size5),
                        Row(
                          children: [
                            const Icon(
                              Icons.widgets_outlined,
                              size: AppSizes.size20,
                              color: AppColors.grey,
                            ),
                            const SizedBox(width: AppSizes.size5),
                            Expanded(
                              child: Text(
                                subtitle,
                                style: const TextStyle(
                                  fontSize: AppSizes.font16,
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],

                      // Stock (Optional)
                      if (stock != null) ...[
                        const SizedBox(height: AppSizes.size5),
                        Text(
                          "Stock : $stock",
                          style: const TextStyle(
                            fontSize: AppSizes.font13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],

                      // Price
                      const SizedBox(height: AppSizes.font15),
                      Row(
                        children: [
                          const Icon(
                            Icons.currency_rupee,
                            size: AppSizes.size20,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: AppSizes.size5),
                          Text(
                            totalValue,
                            style: const TextStyle(
                              fontSize: AppSizes.font16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),

                      // Status (Optional)
                      if (status != null) ...[
                        const SizedBox(height: AppSizes.size8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.padding10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isOutOfStock
                                ? Colors.red.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            status!,
                            style: TextStyle(
                              color: isOutOfStock
                                  ? AppColors.error
                                  : AppColors.warning,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                /// Arrow
                Container(
                  width: AppSizes.size40,
                  height: AppSizes.size40,
                  decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: AppSizes.size15,
                    color: AppColors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
