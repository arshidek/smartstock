import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../data/models/brand_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';
import 'product_price_stock_cards.dart';

class ProductDetailInfoCard extends StatelessWidget {
  final ProductModel product;
  final BrandModel? brand;
  final CategoryModel? category;
  final String formattedDate;

  const ProductDetailInfoCard({
    super.key,
    required this.product,
    required this.brand,
    required this.category,
    required this.formattedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Subtitle
        Text(
          product.name,
          style: const TextStyle(
            fontSize: AppSizes.font26,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: AppSizes.size8),
        Text(
          brand?.name ?? "Unknown",
          style: const TextStyle(
            fontSize: AppSizes.font16,
            color: AppColors.grey,
          ),
        ),

        const SizedBox(height: AppSizes.size24),
        const Divider(color: AppColors.lightGrey),
        const SizedBox(height: AppSizes.size24),

        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                Icons.local_offer_outlined,
                "Category",
                category?.name ?? "Unknown",
              ),
            ),
            Expanded(
              child: _buildInfoItem(
                context,
                Icons.branding_watermark_outlined,
                "Brand",
                brand?.name ?? "Unknown",
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.size24),
        Row(
          children: [
            Expanded(
              child: _buildInfoItem(
                context,
                Icons.qr_code_scanner_outlined,
                "Barcode",
                product.barcode.isNotEmpty ? product.barcode : "Not Available",
              ),
            ),
            Expanded(
              child: _buildInfoItem(
                context,
                Icons.calendar_today_outlined,
                "Added On",
                formattedDate,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSizes.size30),

        // Bottom Cards
        ProductPriceStockCards(product: product),
      ],
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.blue, size: AppSizes.size22),
        const SizedBox(width: AppSizes.size12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: Responsive.isMobile(context)
                      ? AppSizes.font14
                      : AppSizes.font16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSizes.size5),
              Text(
                value,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: Responsive.isMobile(context)
                      ? AppSizes.font16
                      : AppSizes.font18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
