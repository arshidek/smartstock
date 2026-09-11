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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.info_outline,
              color: AppColors.blue,
              size: AppSizes.size25,
            ),
            SizedBox(width: AppSizes.size10),
            Text(
              "Product Information",
              style: TextStyle(
                fontSize: AppSizes.font20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.size10),
        const Divider(),
        const SizedBox(height: AppSizes.size10),
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
          product.description.isEmpty ? "No Description" : product.description,
        ),
        _infoRow(
          context,
          "Added By",
          product.createdBy.isEmpty ? "System" : product.createdBy,
        ),
      ],
    );
  }

  Widget _infoRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.padding8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSizes.size130,
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: Responsive.isMobile(context)
                    ? AppSizes.font14
                    : AppSizes.font16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.isMobile(context)
                    ? AppSizes.font14
                    : AppSizes.font16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
