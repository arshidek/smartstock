import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';

class ProductEmptyState extends StatelessWidget {
  const ProductEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(AppSizes.margin12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius18),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.widgets_outlined,
            size: AppSizes.size60,
            color: AppColors.blue,
          ),
          const SizedBox(height: AppSizes.size12),
          const Text(
            "No Products Found",
            style: TextStyle(
              fontSize: AppSizes.font18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.size5),
          const Text(
            "Try another product name, brand or product ID.",
            style: TextStyle(color: AppColors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
