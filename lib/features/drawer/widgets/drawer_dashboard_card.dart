import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../app/app_navigation.dart';
import '../../dashboard/presentation/dashboard_screen/dashboard_screen.dart';

class DrawerDashboardCard extends StatelessWidget {
  final bool isCollapsed;

  const DrawerDashboardCard({super.key, this.isCollapsed = false});

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackShadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isCollapsed
          ? InkWell(
              onTap: () => AppNavigation.goToScreenAndRemoveAll(
                context,
                const DashboardScreen(),
              ),
              borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.padding12,
                ),
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.padding8),
                  decoration: BoxDecoration(
                    color: AppColors.glassIconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.home,
                    color: AppColors.blue,
                    size: AppSizes.size24,
                  ),
                ),
              ),
            )
          : ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.padding16,
                vertical: 4,
              ),
              leading: Container(
                padding: const EdgeInsets.all(AppSizes.padding8),
                decoration: BoxDecoration(
                  color: AppColors.glassIconBackground,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
                ),
                child: Icon(
                  Icons.home,
                  color: AppColors.blue,
                  size: AppSizes.size24,
                ),
              ),
              title: Text(
                "Dashboard",
                style: TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.font16,
                ),
              ),
              onTap: () => AppNavigation.goToScreenAndRemoveAll(
                context,
                const DashboardScreen(),
              ),
            ),
    );

    if (isCollapsed) {
      return Tooltip(message: "Dashboard", child: cardContent);
    }

    return cardContent;
  }
}
