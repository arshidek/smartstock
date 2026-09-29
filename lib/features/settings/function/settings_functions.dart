import 'package:flutter/material.dart';
import '../../../../app/app_navigation.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/hive_service.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/dialogs/logout_dialog.dart';
import '../../auth/presentation/login/login_screen.dart';

class SettingsFunctions {
  void handleLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LogoutDialog(
        onLogout: () async {
          AppNavigation.goBack(context);

          final authService = AuthService();
          final hiveService = HiveService();
          final userId = authService.getCurrentUserId();

          await authService.logout();

          if (userId != null) {
            await hiveService.closeUserBoxes(userId);
          }

          if (!context.mounted) return;

          AppNavigation.goToScreenAndRemoveAll(context, const LoginScreen());

          AppSnackBar.success(context, "Logged out successfully!");
        },
      ),
    );
  }
}
