import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';

class ProductInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProductInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.padding8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSizes.size130,
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: Responsive.isMobile(context)
                    ? AppSizes.font14
                    : AppSizes.font16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.isMobile(context)
                    ? AppSizes.font14
                    : AppSizes.font16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
