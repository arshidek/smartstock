import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../data/models/brand_model.dart';

class BrandDescriptionSection extends StatelessWidget {
  final BrandModel brand;
  final bool isReadMoreExpanded;
  final VoidCallback onReadMore;

  const BrandDescriptionSection({
    super.key,
    required this.brand,
    required this.isReadMoreExpanded,
    required this.onReadMore,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
          child: brand.imagePath != null && brand.imagePath!.isNotEmpty
              ? (kIsWeb
                    ? Image.network(
                        brand.imagePath!,
                        width: AppSizes.size80,
                        height: AppSizes.size80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: AppSizes.size80,
                          height: AppSizes.size80,
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadius12,
                            ),
                          ),
                          child: const Icon(
                            Icons.image,
                            size: AppSizes.size45,
                            color: AppColors.grey,
                          ),
                        ),
                      )
                    : ((kIsWeb || File(brand.imagePath!).existsSync())
                          ? kIsWeb
                                ? Image.network(
                                    brand.imagePath!,
                                    width: AppSizes.size80,
                                    height: AppSizes.size80,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(brand.imagePath!),
                                    width: AppSizes.size80,
                                    height: AppSizes.size80,
                                    fit: BoxFit.cover,
                                  )
                          : Container(
                              width: AppSizes.size80,
                              height: AppSizes.size80,
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.borderRadius12,
                                ),
                              ),
                              child: const Icon(
                                Icons.image,
                                size: AppSizes.size45,
                                color: AppColors.grey,
                              ),
                            )))
              : Container(
                  width: AppSizes.size80,
                  height: AppSizes.size80,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadius12,
                    ),
                  ),
                  child: const Icon(
                    Icons.image,
                    size: AppSizes.size45,
                    color: AppColors.grey,
                  ),
                ),
        ),

        const SizedBox(width: AppSizes.size20),

        /// Description
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.description,
                    color: AppColors.blue,
                    size: AppSizes.size22,
                  ),
                  SizedBox(width: AppSizes.size7),
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: AppSizes.font18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.size15),

              Text(
                brand.description?.trim().isNotEmpty == true
                    ? brand.description!
                    : "No description available.",
                style: const TextStyle(
                  fontSize: AppSizes.font14,
                  color: AppColors.grey,
                  height: 1.5,
                ),
                maxLines: isReadMoreExpanded ? null : 4,
                overflow: isReadMoreExpanded
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
              ),

              if ((brand.description ?? "").length > 120)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: onReadMore,
                    child: Text(
                      isReadMoreExpanded ? "Read less ▲" : "Read more ▼",
                      style: const TextStyle(
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
