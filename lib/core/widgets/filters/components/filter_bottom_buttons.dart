import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../buttons/app_button.dart';
import '../../buttons/app_outline_button.dart';

class FilterBottomButtons extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback onApply;

  const FilterBottomButtons({
    Key? key,
    required this.onReset,
    required this.onApply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: AppOutlineButton(
            onPressed: onReset,
            icon: Icons.refresh,
            text: "Reset",
            fontSize: AppSizes.font16,
            expandText: false,
          ),
        ),
        const SizedBox(width: AppSizes.size15),
        Expanded(
          flex: 1,
          child: AppButton(
            onPressed: onApply,
            text: "Apply Filters ",
            icon: Icons.filter_alt_outlined,
            backgroundColor: AppColors.blue,
            textColor: AppColors.white,
            iconColor: AppColors.white,
          ),
        ),
      ],
    );
  }
}
