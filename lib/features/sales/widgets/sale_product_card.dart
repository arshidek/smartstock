import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import 'sale_product_image.dart';
import 'sale_product_details.dart';

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

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSizes.padding16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
            border: Border.all(
              color: isSelected
                  ? AppColors.blue
                  : AppColors.blue.withValues(alpha: 0.08),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.08),
                blurRadius: AppSizes.blurRadius,
                spreadRadius: 1,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: AppColors.blueShadow,
                blurRadius: AppSizes.borderRadius12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final row = Row(
                children: [
                  /// IMAGE
                  SaleProductImage(imagePath: imagePath),
                  const SizedBox(width: AppSizes.size15),

                  /// DETAILS
                  SaleProductDetails(
                    name: name,
                    brand: brand,
                    category: category,
                    status: status,
                    stock: stock,
                    price: price,
                    statusColor: statusColor,
                    showStatus: showStatus,
                    trailingTop: trailingTop,
                    trailingBottom: trailingBottom,
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
