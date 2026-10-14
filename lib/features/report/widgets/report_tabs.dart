import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/buttons/app_button.dart';

class ReportTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const ReportTabs({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding20,
        vertical: AppSizes.padding10,
      ),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              text: "Inventory",
              icon: Icons.widgets_outlined,
              onPressed: () => onTabChanged(0),
              backgroundColor: selectedIndex == 0
                  ? AppColors.blue
                  : AppColors.white,
              textColor: selectedIndex == 0 ? AppColors.white : AppColors.black,
              iconColor: selectedIndex == 0 ? AppColors.white : AppColors.black,
            ),
          ),
          const SizedBox(width: AppSizes.padding10),
          Expanded(
            child: AppButton(
              text: "Revenue",
              icon: Icons.payments_outlined,
              onPressed: () => onTabChanged(1),
              backgroundColor: selectedIndex == 1
                  ? AppColors.success
                  : AppColors.white,
              textColor: selectedIndex == 1 ? AppColors.white : AppColors.black,
              iconColor: selectedIndex == 1 ? AppColors.white : AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
