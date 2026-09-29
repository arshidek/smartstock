import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final bool showFilter;
  final int filterCount;

  const AppSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onFilterTap,
    this.showFilter = true,
    this.filterCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.size55,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        children: [
          const SizedBox(width: AppSizes.size12),

          const Icon(Icons.search, color: AppColors.grey),

          const SizedBox(width: AppSizes.size10),

          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: AppColors.grey,
                  fontSize: AppSizes.font16,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),

          if (showFilter) ...[
            Container(
              width: 1,
              height: AppSizes.size28,
              color: AppColors.lightGrey,
            ),

            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: onFilterTap,
                  icon: const Icon(Icons.tune, color: AppColors.blue),
                ),

                if (filterCount > 0)
                  Positioned(
                    right: 3,
                    top: 3,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$filterCount',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: AppSizes.font12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
