import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../data/models/product_model.dart';

class ProductPriceStockCards extends StatelessWidget {
  final ProductModel product;

  const ProductPriceStockCards({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Price Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSizes.padding16),
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.isMobile(context)
                        ? AppSizes.font14
                        : AppSizes.font16,
                  ),
                ),
                const SizedBox(height: AppSizes.size8),
                Text(
                  "₹${product.sellingPrice}",
                  style: TextStyle(
                    color: AppColors.bannerBlue,
                    fontSize: Responsive.isMobile(context)
                        ? AppSizes.font20
                        : AppSizes.font28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSizes.size15),
        // Stock Status Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSizes.padding16),
            decoration: BoxDecoration(
              color: product.stockColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stock Status",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.isMobile(context)
                        ? AppSizes.font14
                        : AppSizes.font16,
                  ),
                ),
                const SizedBox(height: AppSizes.size8),
                Row(
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          product.stockStatus,
                          style: TextStyle(
                            color: product.stockColor,
                            fontSize: Responsive.isMobile(context)
                                ? AppSizes.font18
                                : AppSizes.font24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (product.stock <= 5 && product.stock > 0) ...[
                      const SizedBox(width: AppSizes.size5),
                      Icon(
                        Icons.warning_amber_rounded,
                        color: product.stockColor,
                        size: AppSizes.size20,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
