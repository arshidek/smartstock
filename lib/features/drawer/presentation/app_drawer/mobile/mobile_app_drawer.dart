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

class MobileAppDrawer extends StatelessWidget {
  final UserService userService;

  const MobileAppDrawer({super.key, required this.userService});

  @override
  Widget build(BuildContext context) {
    final currentUser = userService.getCurrentUser();
    if (currentUser == null) return const SizedBox();

    return SizedBox(
      width: 280,
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
                ValueListenableBuilder<Box<UserModel>>(
                  valueListenable: Hive.box<UserModel>(
                    HiveBoxes.users,
                  ).listenable(),
                  builder: (context, box, _) {
                    final updatedUser = userService.getCurrentUser();
                    if (updatedUser == null) return const SizedBox();
                    return DrawerProfileHeader(
                      currentUser: updatedUser,
                      isCollapsed: false,
                    );
                  },
                ),
                const SizedBox(height: AppSizes.size15),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.padding16,
                  ),
                  child: DrawerDashboardCard(isCollapsed: false),
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
                                  isCollapsed: false,
                                  onExpandRequested: () {},
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
                                SizedBox(height: AppSizes.size10),
                                DrawerMenuItem(
                                  icon: Icons.shopping_cart_outlined,
                                  iconColor: AppColors.darkGreen,
                                  bgColor: AppColors.lightDarkGreen,
                                  title: "Sales",
                                  isCollapsed: false,
                                  onTap: () =>
                                      DrawerFunctions.navigateToSales(context),
                                ),
                                SizedBox(height: AppSizes.size10),
                                DrawerMenuItem(
                                  icon: Icons.bar_chart,
                                  iconColor: AppColors.warning,
                                  bgColor: AppColors.lightWarning,
                                  title: "Reports",
                                  isCollapsed: false,
                                  onTap: () =>
                                      DrawerFunctions.navigateToReports(
                                        context,
                                      ),
                                ),
                                SizedBox(height: AppSizes.size10),
                                DrawerMenuItem(
                                  icon: Icons.notifications_none,
                                  iconColor: AppColors.error,
                                  bgColor: AppColors.lightRed,
                                  title: "Stock Management",
                                  isCollapsed: false,
                                  onTap: () =>
                                      DrawerFunctions.navigateToStock(context),
                                ),
                                SizedBox(height: AppSizes.size10),
                                DrawerMenuItem(
                                  icon: Icons.person_outline,
                                  iconColor: AppColors.purple,
                                  bgColor: AppColors.lightPurple,
                                  title: "Profile",
                                  isCollapsed: false,
                                  onTap: () =>
                                      DrawerFunctions.navigateToProfile(
                                        context,
                                      ),
                                ),
                                SizedBox(height: AppSizes.size10),
                                DrawerMenuItem(
                                  icon: Icons.settings_outlined,
                                  iconColor: AppColors.lightBlack,
                                  bgColor: AppColors.lightGrey.withOpacity(0.2),
                                  title: "Settings",
                                  isCollapsed: false,
                                  onTap: () =>
                                      DrawerFunctions.navigateToSettings(
                                        context,
                                      ),
                                ),
                                SizedBox(height: AppSizes.size20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.size15),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.padding16,
                    vertical: AppSizes.padding16,
                  ),
                  child: DrawerFooterCard(isCollapsed: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
