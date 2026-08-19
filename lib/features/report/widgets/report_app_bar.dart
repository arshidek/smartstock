import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';

class ReportAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onRefresh;
  final VoidCallback onExport;
  final VoidCallback onShare;

  const ReportAppBar({
    super.key,
    required this.onRefresh,
    required this.onExport,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: false,
      title: const Row(
        children: [
          Icon(Icons.widgets_outlined, color: AppColors.black),
          SizedBox(width: AppSizes.padding8),
          Text(
            "Reports",
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.font20,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onRefresh,
          icon: const Icon(Icons.refresh, color: AppColors.black),
        ),
        IconButton(
          onPressed: onShare,
          icon: const Icon(Icons.share_outlined, color: AppColors.black),
        ),
        Padding(
          padding: const EdgeInsets.only(right: AppSizes.padding16),
          child: Center(
            child: ElevatedButton.icon(
              onPressed: onExport,
              icon: const Icon(Icons.download, size: 16),
              label: const Text("Export"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding16,
                  vertical: AppSizes.padding8,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
