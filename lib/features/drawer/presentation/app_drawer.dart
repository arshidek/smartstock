import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import 'package:smartstock_inventory/features/stock/presentation/stock_management_screen.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/hive_boxes.dart';
import '../../../data/models/user_model.dart';
import '../../../core/services/user_service.dart';
import '../../report/presentation/report_screen.dart';
import '../../settings/presentation/settings_screen.dart';
import '../../../app/app_navigation.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../sales/presentation/sales_screen.dart';
import '../widgets/drawer_profile_header.dart';
import '../widgets/drawer_dashboard_card.dart';
import '../widgets/drawer_items_menu.dart';
import '../widgets/drawer_menu_item.dart';
import '../widgets/drawer_footer_card.dart';

class AppDrawer extends StatefulWidget {
  final bool isCollapsed;
  final VoidCallback? onToggleCollapse;

  const AppDrawer({super.key, this.isCollapsed = false, this.onToggleCollapse});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final currentUser = _userService.getCurrentUser();
    if (currentUser == null) return const SizedBox();

    return Container(
      width: widget.isCollapsed ? 90 : 280,
      child: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.blue, AppColors.lightBlue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                if (kIsWeb && widget.onToggleCollapse != null)
                  Align(
                    alignment: widget.isCollapsed
                        ? Alignment.center
                        : Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        widget.isCollapsed ? Icons.menu_open : Icons.menu,
                        color: AppColors.white,
                      ),
                      onPressed: widget.onToggleCollapse,
                    ),
                  ),

                ValueListenableBuilder<Box<UserModel>>(
                  valueListenable: Hive.box<UserModel>(
                    HiveBoxes.users,
                  ).listenable(),
                  builder: (context, box, _) {
                    final updatedUser = _userService.getCurrentUser();
                    if (updatedUser == null) return const SizedBox();
                    return DrawerProfileHeader(
                      currentUser: updatedUser,
                      isCollapsed: widget.isCollapsed,
                    );
                  },
                ),

                const SizedBox(height: AppSizes.size15),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.padding16,
                  ),
                  child: DrawerDashboardCard(isCollapsed: widget.isCollapsed),
                ),

                const SizedBox(height: AppSizes.size15),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.padding16,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.9),
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
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.padding8,
                        ),
                        children: [
                          DrawerItemsMenu(
                            isCollapsed: widget.isCollapsed,
                            onExpandRequested: () {
                              if (widget.isCollapsed &&
                                  widget.onToggleCollapse != null) {
                                widget.onToggleCollapse!();
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
                            isCollapsed: widget.isCollapsed,
                            onTap: () {
                              AppNavigation.goToScreen(context, SalesScreen());
                            },
                          ),

                          DrawerMenuItem(
                            icon: Icons.bar_chart,
                            iconColor: AppColors.warning,
                            bgColor: AppColors.lightWarning,
                            title: "Reports",
                            isCollapsed: widget.isCollapsed,
                            onTap: () {
                              AppNavigation.goToScreen(
                                context,
                                const ReportScreen(),
                              );
                            },
                          ),

                          DrawerMenuItem(
                            icon: Icons.notifications_none,
                            iconColor: AppColors.error,
                            bgColor: AppColors.lightRed,
                            title: "Stock Management",
                            isCollapsed: widget.isCollapsed,
                            onTap: () {
                              AppNavigation.goToScreen(
                                context,
                                StockManagementScreen(
                                  stockType: StockType.lowStock,
                                ),
                              );
                            },
                          ),

                          DrawerMenuItem(
                            icon: Icons.person_outline,
                            iconColor: AppColors.purple,
                            bgColor: AppColors.lightPurple,
                            title: "Profile",
                            isCollapsed: widget.isCollapsed,
                            onTap: () {
                              AppNavigation.goToScreen(
                                context,
                                const ProfileScreen(),
                              );
                            },
                          ),

                          DrawerMenuItem(
                            icon: Icons.settings_outlined,
                            iconColor: AppColors.lightBlack,
                            bgColor: AppColors.lightGrey.withOpacity(0.2),
                            title: "Settings",
                            isCollapsed: widget.isCollapsed,
                            onTap: () {
                              AppNavigation.goToScreen(
                                context,
                                const SettingsScreen(),
                              );
                            },
                          ),
                        ],
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
                  child: DrawerFooterCard(isCollapsed: widget.isCollapsed),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
