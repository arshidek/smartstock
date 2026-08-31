import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/popup/app_popup_menu.dart';
import '../../../data/models/product_model.dart';

class StockManagementCard extends StatelessWidget {
  final ProductModel product;
  final String brandName;
  final String categoryName;
  final VoidCallback? onRestock;
  final VoidCallback? onTap;

  const StockManagementCard({
    super.key,
    required this.product,
    required this.brandName,
    required this.categoryName,
    this.onRestock,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = product.stock == 0;

    final Color statusColor = isOutOfStock
        ? AppColors.error
        : AppColors.warning;

    final String statusText = isOutOfStock ? "OUT OF STOCK" : "LOW STOCK";

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
            child: LayoutBuilder(
              builder: (context, constraints) {
                final row = Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Product Image
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
                        child:
                            product.imagePath.isNotEmpty &&
                                (kIsWeb || File(product.imagePath).existsSync())
                            ? kIsWeb
                                  ? Image.network(
                                      product.imagePath,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(product.imagePath),
                                      fit: BoxFit.cover,
                                    )
                            : const Icon(
                                Icons.image_outlined,
                                size: AppSizes.size32,
                                color: AppColors.grey,
                              ),
                      ),
                    ),

                    const SizedBox(width: AppSizes.size15),

                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Left Side
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: AppSizes.font20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: AppSizes.size5),

                                Text(
                                  brandName,
                                  style: const TextStyle(
                                    fontSize: AppSizes.font16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 2),

                                Text(
                                  categoryName,
                                  style: const TextStyle(
                                    fontSize: AppSizes.font14,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: AppSizes.size10),

                          /// Right Side
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppSizes.padding10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(.12),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        statusText,
                                        style: TextStyle(
                                          color: statusColor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: AppPopupMenu.restock(
                                      onRestock: onRestock,
                                      compact: true,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 2),

                              Text(
                                "Qty : ${product.stock}",
                                style: const TextStyle(
                                  fontSize: AppSizes.font14,
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: AppSizes.size5),

                              Text(
                                "₹${product.sellingPrice.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: AppSizes.font18,
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
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: row,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
