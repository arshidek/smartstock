import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../data/models/brand_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';

class ProductInformationSection extends StatelessWidget {
  final ProductModel product;
  final BrandModel? brand;
  final CategoryModel? category;

  const ProductInformationSection({
    super.key,
    required this.product,
    required this.brand,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppSizes.padding20),
      padding: const EdgeInsets.all(AppSizes.padding25),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.blue, size: 25),
              SizedBox(width: 10),
              Text(
                "Product Information",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 10),
          _infoRow(
            context,
            "Barcode",
            product.barcode.isEmpty ? "Not Available" : product.barcode,
          ),
          _infoRow(context, "Brand", brand?.name ?? "Unknown"),
          _infoRow(context, "Category", category?.name ?? "Unknown"),
          _infoRow(
            context,
            "Description",
            product.description.isEmpty
                ? "No Description"
                : product.description,
          ),
          _infoRow(
            context,
            "Added By",
            product.createdBy.isEmpty ? "System" : product.createdBy,
          ),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: Responsive.isMobile(context) ? 14 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.isMobile(context) ? 14 : 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
