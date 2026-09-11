import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../constants/app_colors.dart';
import '../../buttons/app_outline_button.dart';
import '../../cards/app_card_widget.dart';

class FilterCustomChip extends StatelessWidget {
  final String label;
  final String? subLabel;
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterCustomChip({
    Key? key,
    required this.label,
    this.subLabel,
    this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppOutlineButton(
      text: label,
      subText: subLabel,
      icon: icon,
      fontSize: AppSizes.font16,
      expandText: subLabel != null,
      isSelected: isSelected,
      onPressed: onTap,
      textColor: AppColors.black,
      iconColor: iconColor ?? AppColors.black,
      iconBackgroundColor: iconBackgroundColor,
      borderColor: isSelected ? Colors.transparent : AppColors.lightGrey,
      backgroundColor: AppColors.blue,
      trailing: isSelected
          ? Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                size: AppSizes.size12,
                color: AppColors.blue,
              ),
            )
          : null,
    );
  }
}

class FilterSectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  const FilterSectionCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCardWidget(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(AppSizes.padding16),
      backgroundColor: AppColors.white,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSizes.padding10),
                  decoration: const BoxDecoration(
                    color: AppColors.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.blue,
                    size: AppSizes.size22,
                  ),
                ),
                const SizedBox(width: AppSizes.size12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: AppSizes.font16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: AppSizes.font12,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.size15),
            child,
          ],
        ),
      ),
    );
  }
}
