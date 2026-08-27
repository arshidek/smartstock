import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../constants/app_colors.dart';
import '../../../features/dashboard/presentation/dashboard_screen.dart';
import '../../../features/product/presentation/product_list_screen.dart';
import '../../../features/report/presentation/report_screen.dart';
import '../../../features/settings/presentation/settings_screen.dart';
import 'package:smartstock_inventory/features/sales/presentation/sales_screen.dart';

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
        targetScreen = const SettingsScreen();
        break;
      default:
        targetScreen = const DashboardScreen();
    }

    AppNavigation.goToScreen(context, targetScreen);
  }

  Widget _buildIcon(IconData iconData, Color iconColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(iconData, color: iconColor, size: 24),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      selectedItemColor: AppColors.black,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      elevation: 8,
      backgroundColor: AppColors.appBarColor,
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon(
            Icons.home_outlined,
            AppColors.blue,
            AppColors.lightBlue,
          ),
          activeIcon: _buildIcon(
            Icons.home,
            AppColors.blue,
            AppColors.lightBlue,
          ),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(
            Icons.shopping_cart_outlined,
            const Color(0xFF06B6D4),
            const Color(0xFFCFFAFE),
          ),
          activeIcon: _buildIcon(
            Icons.shopping_cart,
            const Color(0xFF06B6D4),
            const Color(0xFFCFFAFE),
          ),
          label: "Sales",
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(
            Icons.bar_chart_outlined,
            AppColors.warning,
            AppColors.lightWarning,
          ),
          activeIcon: _buildIcon(
            Icons.bar_chart,
            AppColors.warning,
            AppColors.lightWarning,
          ),
          label: "Reports",
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(
            Icons.settings_outlined,
            AppColors.lightBlack,
            AppColors.lightGrey.withOpacity(0.2),
          ),
          activeIcon: _buildIcon(
            Icons.settings,
            AppColors.lightBlack,
            AppColors.lightGrey.withOpacity(0.2),
          ),
          label: "Settings",
        ),
      ],
    );
  }
}
