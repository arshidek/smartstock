import 'package:flutter/material.dart';
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
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          brand?.name ?? "Unknown",
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),

        const SizedBox(height: 24),
        const Divider(color: Color(0xFFE2E8F0)),
        const SizedBox(height: 24),

        // 2x2 Grid Info
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
        const SizedBox(height: 24),
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

        const SizedBox(height: 32),

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
        Icon(icon, color: Colors.blueAccent, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: Responsive.isMobile(context) ? 14 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: const Color(0xFF1E293B),
                  fontSize: Responsive.isMobile(context) ? 16 : 18,
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
