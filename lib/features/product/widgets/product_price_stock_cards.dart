import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6FB), // Light bluish-grey
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.isMobile(context) ? 14 : 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "₹${product.sellingPrice}",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: Responsive.isMobile(context) ? 24 : 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Stock Status Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: product.stockColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stock Status",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.isMobile(context) ? 14 : 16,
                  ),
                ),
                const SizedBox(height: 8),
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
                            fontSize: Responsive.isMobile(context) ? 18 : 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (product.stock <= 5 && product.stock > 0) ...[
                      const SizedBox(width: 6),
                      Icon(
                        Icons.warning_amber_rounded,
                        color: product.stockColor,
                        size: 20,
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
