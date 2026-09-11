import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../app/app_navigation.dart';
import '../../brand/presentation/brand_list_screen.dart';
import '../../category/presentation/category_screen.dart';
import '../../product/presentation/product_list_screen.dart';

class DrawerItemsMenu extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback? onExpandRequested;

  const DrawerItemsMenu({
    super.key,
    this.isCollapsed = false,
    this.onExpandRequested,
  });

  @override
  Widget build(BuildContext context) {
    if (isCollapsed) {
      return Tooltip(
        message: "Items",
        child: InkWell(
          onTap: onExpandRequested,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.padding12),
            child: Container(
              padding: const EdgeInsets.all(AppSizes.padding8),
              decoration: BoxDecoration(
                color: AppColors.glassIconBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.widgets_outlined, color: AppColors.blue, size: AppSizes.size24),
            ),
          ),
        ),
      );
    }

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: AppSizes.padding16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(AppSizes.padding8),
          decoration: BoxDecoration(
            color: AppColors.glassIconBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.widgets_outlined, color: AppColors.blue, size: AppSizes.size24),
        ),
        title: Text(
          "Items",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            fontSize: AppSizes.font16,
          ),
        ),
        iconColor: AppColors.grey,
        collapsedIconColor: AppColors.grey,
        children: [
          Stack(
            children: [
              Positioned(
                left: AppSizes.size28,
                top: 0,
                bottom: AppSizes.size16,
                child: Container(
                  width: 3,
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Column(
                children: [
                  DrawerSubMenuItem(
                    icon: Icons.widgets_outlined,
                    iconColor: AppColors.blue,
                    title: "Products",
                    onTap: () => AppNavigation.goToScreen(
                      context,
                      const ProductListScreen(),
                    ),
                  ),
                  DrawerSubMenuItem(
                    icon: Icons.local_offer_outlined,
                    iconColor: AppColors.purple,
                    title: "Categories",
                    onTap: () => AppNavigation.goToScreen(
                      context,
                      const CategoryScreen(),
                    ),
                  ),
                  DrawerSubMenuItem(
                    icon: Icons.workspace_premium_outlined,
                    iconColor: AppColors.success,
                    title: "Brands",
                    onTap: () => AppNavigation.goToScreen(
                      context,
                      const BrandListScreen(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawerSubMenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  const DrawerSubMenuItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: AppSizes.padding48, right: AppSizes.padding16),
      leading: Icon(icon, color: iconColor, size: AppSizes.size22),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppSizes.font16,
          color:AppColors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        size: AppSizes.size18,
        color: AppColors.grey,
      ),
      onTap: onTap,
    );
  }
}
