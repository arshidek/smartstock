import 'package:flutter/material.dart';
import 'package:smartstock_inventory/features/stock/presentation/stock_management_screen.dart';
import '../../../core/constants/app_colors.dart';
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
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final currentUser = _userService.getCurrentUser();
    if (currentUser == null) return const SizedBox();

    return Drawer(
      backgroundColor: Colors.transparent, // Transparent to show gradient
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          // Use custom AppColors for the main drawer background gradient
          gradient: LinearGradient(
            colors: [AppColors.blue, AppColors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // --- 1. Dynamic Profile Header ---
              DrawerProfileHeader(currentUser: currentUser),

              const SizedBox(height: 16),

              // --- 2. Dashboard Card ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const DrawerDashboardCard(),
              ),

              const SizedBox(height: 16),

              // --- 3. Main Menu Card ---
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackShadow,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: [
                        // Items (Expandable Accordion)
                        const DrawerItemsMenu(),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(
                            height: 1,
                            color: AppColors.lightGrey.withOpacity(0.2),
                          ),
                        ),

                        DrawerMenuItem(
                          icon: Icons.shopping_cart_outlined,
                          iconColor: const Color(
                            0xFF06B6D4,
                          ), // Custom cyan for Sales
                          bgColor: const Color(0xFFCFFAFE),
                          title: "Sales",
                          onTap: () {
                            AppNavigation.goToScreen(context, SalesScreen());
                          },
                        ),

                        DrawerMenuItem(
                          icon: Icons.bar_chart,
                          iconColor: AppColors.warning, // Custom warning/orange
                          bgColor: AppColors.lightWarning,
                          title: "Reports",
                          onTap: () {
                            AppNavigation.goToScreen(
                              context,
                              const ReportScreen(),
                            );
                          },
                        ),

                        DrawerMenuItem(
                          icon: Icons.notifications_none,
                          iconColor: AppColors.error, // Custom error/red
                          bgColor: AppColors.lightRed,
                          title: "Stock Alerts",
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
                          iconColor: AppColors.purple, // Custom purple
                          bgColor: AppColors.lightPurple,
                          title: "Profile",
                          onTap: () {
                            AppNavigation.goToScreen(
                              context,
                              const ProfileScreen(),
                            );
                          },
                        ),

                        DrawerMenuItem(
                          icon: Icons.settings_outlined,
                          iconColor: AppColors.lightBlack, // Gray/Black
                          bgColor: AppColors.lightGrey.withOpacity(0.2),
                          title: "Settings",
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

              const SizedBox(height: 16),

              // --- 4. Footer ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: const DrawerFooterCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
