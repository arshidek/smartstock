import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../data/models/product_model.dart';

class ProductPriceStockCards extends StatelessWidget {
  final ProductModel product;

  const ProductPriceStockCards({super.key, required this.product});

  Color get _stockColor {
    if (product.stock <= 0) return AppColors.error;
    if (product.stock <= 5) return AppColors.warning;
    return AppColors.success;
  }

  Color get _stockBgColor {
    if (product.stock <= 0) return AppColors.lightError;
    if (product.stock <= 5) return AppColors.lightWarning;
    return AppColors.lightGreen;
  }

  String get _stockLabel {
    if (product.stock <= 0) return "Out of Stock";
    if (product.stock <= 5) return "Low Stock";
    return "In Stock";
  }

  IconData get _stockStatusIcon {
    if (product.stock <= 0) return Icons.remove_circle_outline_rounded;
    if (product.stock <= 5) return Icons.warning_amber_rounded;
    return Icons.check_circle_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Row(
      children: [
        // ─── Price Card ───────────────────────────────────────────────
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
                // Header: icon + label
                Row(
                  children: [
                    Container(
                      width: AppSizes.size40,
                      height: AppSizes.size40,
                      decoration: BoxDecoration(
                        color: AppColors.blue.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius8,
                        ),
                      ),
                      child: const Icon(
                        Icons.currency_rupee_rounded,
                        color: AppColors.blue,
                        size: AppSizes.size22,
                      ),
                    ),
                    const SizedBox(width: AppSizes.size10),
                    Expanded(
                      child: Text(
                        "Price",
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: isMobile
                              ? AppSizes.font14
                              : AppSizes.font16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.size12),
                // Price value
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "₹${product.sellingPrice}",
                    style: TextStyle(
                      color: AppColors.bannerBlue,
                      fontSize: isMobile ? AppSizes.font22 : AppSizes.font28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.size4),
                Text(
                  "Selling Price",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: isMobile ? AppSizes.font12 : AppSizes.font13,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSizes.size15),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSizes.padding16),
            decoration: BoxDecoration(
              color: _stockBgColor,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: AppSizes.size40,
                      height: AppSizes.size40,
                      decoration: BoxDecoration(
                        color: _stockColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius8,
                        ),
                      ),
                      child: Icon(
                        Icons.inventory_2_outlined,
                        color: _stockColor,
                        size: AppSizes.size22,
                      ),
                    ),
                    const SizedBox(width: AppSizes.size8),
                    Expanded(
                      child: Text(
                        "Available Quantity",
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: isMobile
                              ? AppSizes.font12
                              : AppSizes.font14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.size12),
                // Quantity value
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${product.stock} Units",
                    style: TextStyle(
                      color: _stockColor,
                      fontSize: isMobile ? AppSizes.font22 : AppSizes.font28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.size4),
                // Status label with icon
                Row(
                  children: [
                    Icon(
                      _stockStatusIcon,
                      color: _stockColor,
                      size: AppSizes.size16,
                    ),
                    const SizedBox(width: AppSizes.size5),
                    Text(
                      _stockLabel,
                      style: TextStyle(
                        color: _stockColor,
                        fontSize: isMobile ? AppSizes.font12 : AppSizes.font13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
