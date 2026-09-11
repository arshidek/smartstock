import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';

class CategorySummaryCards extends StatelessWidget {
  final String categoryName;
  final int productsCount;

  const CategorySummaryCards({
    super.key,
    required this.categoryName,
    required this.productsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSizes.padding10),
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withOpacity(.25),
              borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.local_offer_outlined,
                      size: Responsive.isMobile(context)
                          ? AppSizes.size12
                          : AppSizes.size15,
                      color: AppColors.blue,
                    ),
                    const SizedBox(width: AppSizes.size5),
                    Expanded(
                      child: Text(
                        "Category Name",
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.isMobile(context) ? 12 : 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.size7),
                Text(
                  categoryName.toUpperCase(),
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context)
                        ? 14
                        : AppSizes.font18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSizes.size10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppSizes.padding10),
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withOpacity(.25),
              borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.widgets_outlined,
                      size: Responsive.isMobile(context)
                          ? AppSizes.size12
                          : AppSizes.size15,
                      color: AppColors.blue,
                    ),
                    const SizedBox(width: AppSizes.size5),
                    Expanded(
                      child: Text(
                        "Products",
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.isMobile(context) ? 12 : 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.size7),
                Text(
                  "$productsCount Items",
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context)
                        ? 14
                        : AppSizes.font18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
