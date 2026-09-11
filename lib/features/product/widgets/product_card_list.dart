import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import 'product_list_item_card.dart';

class ProductCardList extends StatelessWidget {
  final String? imagePath;
  final String productName;
  final String? productId;
  final String brandName;
  final String categoryName;
  final double sellingPrice;
  final int stock;
  final String stockStatus;
  final Color stockColor;
  final bool showEdit;
  final VoidCallback? onEdit;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const ProductCardList({
    super.key,
    this.imagePath,
    required this.productName,
    this.productId,
    required this.brandName,
    required this.categoryName,
    required this.sellingPrice,
    required this.stock,
    required this.stockStatus,
    required this.stockColor,
    this.showEdit = false,
    this.onEdit,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:
            margin ??
            const EdgeInsets.only(
              left: AppSizes.padding12,
              right: AppSizes.padding12,
              bottom: AppSizes.padding12,
            ),
        padding: const EdgeInsets.all(AppSizes.padding10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.08),
              blurRadius: AppSizes.blurRadius,
              spreadRadius: 1,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ProductListItemCard(
          imagePath: imagePath,
          productName: productName,
          brandName: brandName,
          categoryName: categoryName,
          sellingPrice: sellingPrice,
          stock: stock,
          stockStatus: stockStatus,
          stockColor: stockColor,
        ),
      ),
    );
  }
}
