import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class DashboardInventoryValueCard extends StatelessWidget {
  final String formattedInvValue;
  final IconData growthIcon;
  final Color growthColor;
  final String growthSign;
  final double invGrowth;

  const DashboardInventoryValueCard({
    super.key,
    required this.formattedInvValue,
    required this.growthIcon,
    required this.growthColor,
    required this.growthSign,
    required this.invGrowth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.padding20),
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Total Inventory Value",
            style: TextStyle(
              color: AppColors.white70,
              fontSize: AppSizes.font14,
            ),
          ),
          const SizedBox(height: AppSizes.size8),
          Text(
            formattedInvValue,
            style: TextStyle(
              color: AppColors.white,
              fontSize: AppSizes.font32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.size8),
          Row(
            children: [
              Icon(growthIcon, color: growthColor, size: AppSizes.size18),
              const SizedBox(width: AppSizes.size4),
              Text(
                "$growthSign${invGrowth.abs().toStringAsFixed(1)}% vs last month",
                style: const TextStyle(color: AppColors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
