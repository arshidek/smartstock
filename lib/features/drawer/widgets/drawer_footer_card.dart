import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';

class DrawerFooterCard extends StatelessWidget {
  final bool isCollapsed;

  const DrawerFooterCard({super.key, this.isCollapsed = false});

  @override
  Widget build(BuildContext context) {
    if (isCollapsed) {
      return Tooltip(
        message: "SmartStock v1.0.0",
        child: Container(
          width: AppSizes.size48,
          height: AppSizes.size48,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
            child: Image.asset(
              'assets/images/app_logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.02),
            blurRadius: AppSizes.borderRadius8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: AppSizes.size48,
            height: AppSizes.size48,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/app_logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: AppSizes.size15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "SmartStock",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.font16,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(width: AppSizes.size8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
                      ),
                      child: const Text(
                        "v1.0",
                        style: TextStyle(
                          color: AppColors.blue,
                          fontSize: AppSizes.font10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.size5),
                const Text(
                  "© 2026",
                  style: TextStyle(color: AppColors.grey, fontSize: AppSizes.font12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
