import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/responsive/responsive_row.dart';
import '../../../../../core/widgets/cards/app_card_widget.dart';
import '../../../../../data/models/brand_model.dart';
import '../../../../../data/models/category_model.dart';
import '../../../../../data/models/product_model.dart';
import '../../../widgets/product_detail_image_viewer.dart';
import '../../../widgets/product_detail_info_card.dart';
import '../../../widgets/product_information_section.dart';

class WebProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  final BrandModel? brand;
  final CategoryModel? category;
  final String formattedDate;

  const WebProductDetailScreen({
    super.key,
    required this.product,
    this.brand,
    this.category,
    required this.formattedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.background),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppCardWidget(
              child: Column(
                children: [
                  ResponsiveRow(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ProductDetailImageViewer(
                          images: product.allImages,
                        ),
                      ),
                      const SizedBox(width: AppSizes.size40),
                      Expanded(
                        child: ProductDetailInfoCard(
                          product: product,
                          brand: brand,
                          category: category,
                          formattedDate: formattedDate,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.size20),
                  const Divider(),
                  const SizedBox(height: AppSizes.size20),
                  ProductInformationSection(
                    product: product,
                    brand: brand,
                    category: category,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
