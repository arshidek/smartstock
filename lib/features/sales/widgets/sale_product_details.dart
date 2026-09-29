import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class SaleProductDetails extends StatelessWidget {
  final String name;
  final String brand;
  final String category;
  final String status;
  final String stock;
  final String price;
  final Color statusColor;
  final bool showStatus;
  final String? trailingTop;
  final String? trailingBottom;

  const SaleProductDetails({
    super.key,
    required this.name,
    required this.brand,
    required this.category,
    required this.status,
    required this.stock,
    required this.price,
    required this.statusColor,
    required this.showStatus,
    this.trailingTop,
    this.trailingBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: AppSizes.font18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSizes.size8),
                Text(
                  "$brand • $category",
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: AppSizes.font14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.size8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              showStatus
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.padding10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.font12,
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          trailingTop ?? "",
                          style: const TextStyle(
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.font13,
                          ),
                        ),
                        const SizedBox(height: AppSizes.size5),
                        Text(
                          trailingBottom ?? "",
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: AppSizes.font12,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: AppSizes.size8),
              Text(
                "Stock : $stock",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppSizes.size8),
              Text(
                price,
                style: const TextStyle(
                  fontSize: AppSizes.font20,
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
