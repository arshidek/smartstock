import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';

import '../../../core/constants/app_colors.dart';

class TodaySummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;

  const TodaySummaryCard({
    required this.title,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w600,
            fontSize: AppSizes.font13,
          ),
        ),

        const SizedBox(height: AppSizes.size5),

        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.font18,
            ),
          ),
        ),
      ],
    );
  }
}
