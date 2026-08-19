import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../app/app_navigation.dart';
import '../../brand/presentation/brand_list_screen.dart';
import '../../category/presentation/category_screen.dart';
import '../../product/presentation/product_list_screen.dart';

class DrawerItemsMenu extends StatelessWidget {
  const DrawerItemsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.glassIconBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.widgets_outlined, color: AppColors.blue, size: 24),
        ),
        title: Text(
          "Items",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
        iconColor: AppColors.grey,
        collapsedIconColor: AppColors.grey,
        children: [
          Stack(
            children: [
              Positioned(
                left: 28,
                top: 0,
                bottom: 16,
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
                    iconColor: const Color(0xFF3B82F6),
                    title: "Products",
                    onTap: () => AppNavigation.goToScreen(
                      context,
                      const ProductListScreen(),
                    ),
                  ),
                  DrawerSubMenuItem(
                    icon: Icons.local_offer_outlined,
                    iconColor: const Color(0xFF8B5CF6),
                    title: "Categories",
                    onTap: () => AppNavigation.goToScreen(
                      context,
                      const CategoryScreen(),
                    ),
                  ),
                  DrawerSubMenuItem(
                    icon: Icons.workspace_premium_outlined,
                    iconColor: const Color(0xFF10B981),
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
      contentPadding: const EdgeInsets.only(left: 48, right: 16),
      leading: Icon(icon, color: iconColor, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF4B5563),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        size: 18,
        color: Color(0xFF9CA3AF),
      ),
      onTap: onTap,
    );
  }
}
