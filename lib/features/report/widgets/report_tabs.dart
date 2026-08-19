import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

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
      padding: const EdgeInsets.all(AppSizes.padding25),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTab(
              context: context,
              title: "Inventory",
              icon: Icons.widgets_outlined,
              isSelected: selectedIndex == 0,
              activeColor: const Color(0xFF69E7B3), // Mint green from mockup
              activeTextColor: AppColors.black,
              onTap: () => onTabChanged(0),
            ),
          ),
          Expanded(
            child: _buildTab(
              context: context,
              title: "Revenue",
              icon: Icons.payments_outlined,
              isSelected: selectedIndex == 1,
              activeColor: const Color(0xFF4C2DB3), // Purple from mockup
              activeTextColor: AppColors.white,
              onTap: () => onTabChanged(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isSelected,
    required Color activeColor,
    required Color activeTextColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.padding16),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? activeTextColor : AppColors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? activeTextColor : AppColors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
