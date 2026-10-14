import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/hive_boxes.dart';
import '../../../../../core/services/user_service.dart';
import '../../../../../data/models/user_model.dart';
import '../../../function/drawer_functions.dart';
import '../../../widgets/drawer_dashboard_card.dart';
import '../../../widgets/drawer_footer_card.dart';
import '../../../widgets/drawer_items_menu.dart';
import '../../../widgets/drawer_menu_item.dart';
import '../../../widgets/drawer_profile_header.dart';

class WebAppDrawer extends StatelessWidget {
  final UserService userService;
  final bool isCollapsed;
  final VoidCallback? onToggleCollapse;

  const WebAppDrawer({
    super.key,
    required this.userService,
    this.isCollapsed = false,
    this.onToggleCollapse,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = userService.getCurrentUser();
    if (currentUser == null) return const SizedBox();

    return SizedBox(
      width: isCollapsed ? 90 : 280,
      child: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.blue, AppColors.lightBlue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                if (onToggleCollapse != null)
                  Align(
                    alignment: isCollapsed
                        ? Alignment.center
                        : Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        isCollapsed ? Icons.menu_open : Icons.menu,
                        color: AppColors.white,
                      ),
                      onPressed: onToggleCollapse,
                    ),
                  ),
                ValueListenableBuilder<Box<UserModel>>(
                  valueListenable: Hive.box<UserModel>(
                    HiveBoxes.users,
                  ).listenable(),
                  builder: (context, box, _) {
                    final updatedUser = userService.getCurrentUser();
                    if (updatedUser == null) return const SizedBox();
                    return DrawerProfileHeader(
                      currentUser: updatedUser,
                      isCollapsed: isCollapsed,
                    );
                  },
                ),
                const SizedBox(height: AppSizes.size15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.padding16,
                  ),
                  child: DrawerDashboardCard(isCollapsed: isCollapsed),
                ),
                const SizedBox(height: AppSizes.size15),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.padding16,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius16,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackShadow,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: AppColors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius16,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSizes.padding8,
                            ),
                            child: Column(
                              children: [
                                DrawerItemsMenu(
                                  isCollapsed: isCollapsed,
                                  onExpandRequested: () {
                                    if (isCollapsed &&
                                        onToggleCollapse != null) {
                                      onToggleCollapse!();
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.padding16,
                                  ),
                                  child: Divider(
                                    height: 1,
                                    color: AppColors.lightGrey.withOpacity(0.2),
                                  ),
                                ),
                                DrawerMenuItem(
                                  icon: Icons.shopping_cart_outlined,
                                  iconColor: AppColors.darkGreen,
                                  bgColor: AppColors.lightDarkGreen,
                                  title: "Sales",
                                  isCollapsed: isCollapsed,
                                  onTap: () =>
                                      DrawerFunctions.navigateToSales(context),
                                ),
                                DrawerMenuItem(
                                  icon: Icons.bar_chart,
                                  iconColor: AppColors.warning,
                                  bgColor: AppColors.lightWarning,
                                  title: "Reports",
                                  isCollapsed: isCollapsed,
                                  onTap: () =>
                                      DrawerFunctions.navigateToReports(
                                        context,
                                      ),
                                ),
                                DrawerMenuItem(
                                  icon: Icons.notifications_none,
                                  iconColor: AppColors.error,
                                  bgColor: AppColors.lightRed,
                                  title: "Stock Management",
                                  isCollapsed: isCollapsed,
                                  onTap: () =>
                                      DrawerFunctions.navigateToStock(context),
                                ),
                                DrawerMenuItem(
                                  icon: Icons.person_outline,
                                  iconColor: AppColors.purple,
                                  bgColor: AppColors.lightPurple,
                                  title: "Profile",
                                  isCollapsed: isCollapsed,
                                  onTap: () =>
                                      DrawerFunctions.navigateToProfile(
                                        context,
                                      ),
                                ),
                                DrawerMenuItem(
                                  icon: Icons.settings_outlined,
                                  iconColor: AppColors.lightBlack,
                                  bgColor: AppColors.lightGrey.withOpacity(0.2),
                                  title: "Settings",
                                  isCollapsed: isCollapsed,
                                  onTap: () =>
                                      DrawerFunctions.navigateToSettings(
                                        context,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.size15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.padding16,
                    vertical: AppSizes.padding16,
                  ),
                  child: DrawerFooterCard(isCollapsed: isCollapsed),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
