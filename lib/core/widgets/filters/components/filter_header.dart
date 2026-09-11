import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';

class FilterHeader extends StatelessWidget {
  final VoidCallback onClose;

  const FilterHeader({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding20),
      child: Row(
        children: [
          Container(
            width: AppSizes.size45,
            height: AppSizes.size45,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.blue,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.filter_alt_outlined,
              color: AppColors.blue,
              size: AppSizes.size24,
            ),
          ),
          const SizedBox(width: AppSizes.size15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Filter & Sort",
                  style: TextStyle(
                    fontSize: AppSizes.font22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  "Find exactly what you need",
                  style: TextStyle(
                    fontSize: AppSizes.font13,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onClose,
            child: Container(
              padding: const EdgeInsets.all(AppSizes.padding10),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: AppSizes.size24,
                color: AppColors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
