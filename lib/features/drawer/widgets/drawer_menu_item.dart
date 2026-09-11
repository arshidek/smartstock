import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';

class DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool isCollapsed;

  const DrawerMenuItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.isCollapsed = false,
  });

  @override
  Widget build(BuildContext context) {
    final itemContent = isCollapsed
        ? InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.padding12),
              child: Container(
                padding: const EdgeInsets.all(AppSizes.padding8),
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: AppSizes.size24),
              ),
            ),
          )
        : ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: AppSizes.padding16, vertical: 4),
            leading: Container(
              padding: const EdgeInsets.all(AppSizes.padding8),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
              ),
              child: Icon(icon, color: iconColor, size: AppSizes.size24),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontSize: AppSizes.font16,
              ),
            ),
            subtitle: subtitle != null
                ? Text(
                    subtitle!,
                    style: const TextStyle(fontSize: AppSizes.font12, color:AppColors.grey),
                  )
                : null,
            trailing: const Icon(
              Icons.chevron_right,
              size: AppSizes.size20,
              color: AppColors.grey,
            ),
            onTap: onTap,
          );

    if (isCollapsed) {
      return Tooltip(
        message: title,
        child: itemContent,
      );
    }
    return itemContent;
  }
}
