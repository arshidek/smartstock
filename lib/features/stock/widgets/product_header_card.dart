import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../data/models/brand_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';
import '../../../core/responsive/responsive.dart';

class ProductHeaderCard extends StatelessWidget {
  final ProductModel product;
  final BrandModel? brand;
  final CategoryModel? category;
  final VoidCallback? onEditDate;

  const ProductHeaderCard({
    super.key,
    required this.product,
    required this.brand,
    required this.category,
    this.onEditDate,
  });

  String _formatDate(DateTime date) {
    final monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    final month = monthNames[date.month - 1];
    return "$month ${date.day}, ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: AppSizes.size100,
              height: AppSizes.size100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
                border: Border.all(color: AppColors.lightGrey),
              ),
              child: product.imagePath.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius12,
                      ),
                      child: kIsWeb
                          ? Image.network(product.imagePath, fit: BoxFit.cover)
                          : Image.file(
                              File(product.imagePath),
                              fit: BoxFit.cover,
                            ),
                    )
                  : const Icon(
                      Icons.image,
                      size: AppSizes.size50,
                      color: AppColors.grey,
                    ),
            ),

            const SizedBox(width: AppSizes.size15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: AppSizes.font22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: AppSizes.size5),

                  Text(
                    "${brand?.name ?? ""} • ${category?.name ?? ""}",
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: AppSizes.font16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSizes.size40),

        Divider(color: AppColors.lightGrey),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: AppSizes.font18,
                        color: AppColors.blue,
                      ),
                      SizedBox(width: AppSizes.size7),
                      Text(
                        "Last Updated",
                        style: TextStyle(
                          fontSize: AppSizes.font14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.size10),

                  InkWell(
                    onTap: onEditDate,
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadius12,
                    ),
                    child: Builder(
                      builder: (context) {
                        final isMobile = Responsive.isMobile(context);
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile
                                ? AppSizes.padding8
                                : AppSizes.padding10,
                            vertical: isMobile ? 4.0 : AppSizes.padding8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blue.withOpacity(0.08),
                            border: Border.all(
                              color: AppColors.blue.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadius12,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: isMobile ? 14 : 18,
                                color: AppColors.blue,
                              ),
                              SizedBox(width: isMobile ? 4 : AppSizes.size8),
                              Text(
                                _formatDate(product.createdAt),
                                style: TextStyle(
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMobile
                                      ? AppSizes.font12
                                      : AppSizes.font16,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: AppSizes.size5),
                ],
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: AppSizes.font18,
                        color: AppColors.blue,
                      ),
                      SizedBox(width: AppSizes.size7),
                      Text(
                        "Updated By",
                        style: TextStyle(
                          fontSize: AppSizes.font14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.size10),

                  Text(
                    product.createdBy,
                    style: const TextStyle(
                      fontSize: AppSizes.font16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
