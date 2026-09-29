import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../report/presentation/report_screen/report_screen.dart';
import '../../sales/presentation/sales_main/sales_screen.dart';
import '../../settings/presentation/settings_screen/settings_screen.dart';
import '../../stock/presentation/stock_management_screen/stock_management_screen.dart';
import '../../profile/presentation/profile_screen/profile_screen.dart';

class DrawerFunctions {
  static void navigateToSales(BuildContext context) {
    AppNavigation.goToScreen(context, SalesScreen());
  }

  static void navigateToReports(BuildContext context) {
    AppNavigation.goToScreen(context, const ReportScreen());
  }

  static void navigateToStock(BuildContext context) {
    AppNavigation.goToScreen(context, StockManagementScreen(stockType: StockType.lowStock));
  }

  static void navigateToProfile(BuildContext context) {
    AppNavigation.goToScreen(context, const ProfileScreen());
  }

  static void navigateToSettings(BuildContext context) {
    AppNavigation.goToScreen(context,  SettingsScreen());
  }
}
