import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';

class ReportUiHelpers {
  static Widget buildProductImage(String imagePath) {
    return Container(
      width: AppSizes.size40,
      height: AppSizes.size40,
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(AppSizes.padding8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
        child: imagePath.isNotEmpty
            ? imagePath.startsWith('data:image')
                ? Image.memory(
                    UriData.parse(imagePath).contentAsBytes(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.grey,
                        size: AppSizes.size20),
                  )
                : kIsWeb
                    ? Image.network(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.grey,
                            size: AppSizes.size20),
                      )
                    : Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.grey,
                            size: AppSizes.size20),
                      )
            : const Icon(Icons.image_outlined, color: AppColors.grey, size: AppSizes.size20),
      ),
    );
  }

  static Widget buildRevenueTrailing(String amount, double percent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.font16,
                ),
              ),
              const SizedBox(width: AppSizes.size5),
              Text(
                "($percent%)",
                style: const TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: AppSizes.font12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.size5),
        Container(
          width: AppSizes.size80,
          height: 4,
          decoration: BoxDecoration(
            color:AppColors.lightBlue, // Light background
            borderRadius: BorderRadius.circular(2),
          ),
          alignment: Alignment.centerLeft,
          child: Container(
            width: AppSizes.size80 * (percent / 100),
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.blue, // Blue progress line
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}
