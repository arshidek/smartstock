import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../app/app_navigation.dart';
import '../../../features/sales/presentation/sales_main/sales_screen.dart';
import '../../../features/settings/presentation/settings_screen/settings_screen.dart';
import '../../constants/app_colors.dart';
import '../../../features/dashboard/presentation/dashboard_screen/dashboard_screen.dart';
import '../../../features/report/presentation/report_screen/report_screen.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavigationBar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget targetScreen;
    switch (index) {
      case 0:
        targetScreen = const DashboardScreen();
        break;
      case 1:
        targetScreen = SalesScreen();
        break;
      case 2:
        targetScreen = const ReportScreen();
        break;
      case 3:
        targetScreen = SettingsScreen();
        break;
      default:
        targetScreen = const DashboardScreen();
    }

    AppNavigation.goToReplacementScreen(context, targetScreen);
  }

  Widget _buildIcon(IconData iconData, Color iconColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.padding8),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(iconData, color: iconColor, size: AppSizes.size24),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      selectedItemColor: AppColors.black,
      unselectedItemColor: AppColors.grey,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      elevation: 8,
      backgroundColor: AppColors.appBarColor,
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon(
            Icons.home_outlined,
            AppColors.blue,
            Colors.transparent,
          ),
          activeIcon: _buildIcon(Icons.home, AppColors.white, AppColors.blue),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(
            Icons.shopping_cart_outlined,
            AppColors.darkGreen,
            Colors.transparent,
          ),
          activeIcon: _buildIcon(
            Icons.shopping_cart,
            AppColors.white,
            AppColors.darkGreen,
          ),
          label: "Sales",
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(
            Icons.bar_chart_outlined,
            AppColors.warning,
            Colors.transparent,
          ),
          activeIcon: _buildIcon(
            Icons.bar_chart,
            AppColors.white,
            AppColors.warning,
          ),
          label: "Reports",
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(
            Icons.settings_outlined,
            AppColors.lightBlack,
            Colors.transparent,
          ),
          activeIcon: _buildIcon(
            Icons.settings,
            AppColors.white,
            AppColors.lightBlack,
          ),
          label: "Settings",
        ),
      ],
    );
  }
}
