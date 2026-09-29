import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../data/models/brand_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';
import 'product_info_row.dart';

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
          children: const [
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
        ProductInfoRow(
          label: "Barcode",
          value: product.barcode.isEmpty ? "Not Available" : product.barcode,
        ),
        ProductInfoRow(label: "Brand", value: brand?.name ?? "Unknown"),
        ProductInfoRow(label: "Category", value: category?.name ?? "Unknown"),
        ProductInfoRow(
          label: "Stock",
          value: "${product.stock} Units · ${product.stockStatus}",
        ),
        ProductInfoRow(
          label: "Description",
          value: product.description.isEmpty
              ? "No Description"
              : product.description,
        ),
        ProductInfoRow(
          label: "Added By",
          value: product.createdBy.isEmpty ? "System" : product.createdBy,
        ),
      ],
    );
  }
}
