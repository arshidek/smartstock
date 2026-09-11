import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final bool showFilter;

  const AppSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onFilterTap,
    this.showFilter = true,
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
            IconButton(
              onPressed: onFilterTap,
              icon: const Icon(Icons.tune, color: AppColors.blue),
            ),
          ],
        ],
      ),
    );
  }
}
