import 'package:flutter/cupertino.dart';
import 'package:smartstock_inventory/core/services/auth_service.dart';

import '../../../app/app_navigation.dart';
import '../../../core/services/hive_service.dart';
import '../../../core/services/user_service.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../data/models/user_model.dart';
import '../../dashboard/presentation/dashboard_screen/dashboard_screen.dart';

class AuthFunction {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  final HiveService _hiveService = HiveService();

  Future<void> login({
    required BuildContext context,
    required String usernameOrEmail,
    required String password,
    required bool mounted,
  }) async {
    final user = _userService.login(usernameOrEmail, password);

    if (user == null) {
      AppSnackBar.error(context, "Invalid username/email or password");
      return;
    }

    await _authService.login(user.id);
    await _hiveService.openUserBoxes(user.id);

    if (!mounted) return;

    AppSnackBar.success(context, "Login successful!");

    AppNavigation.goToScreenAndRemoveAll(context, const DashboardScreen());
  }

  Future<void> createAccount({
    required BuildContext context,
    required String username,
    required String email,
    required String password,
    required bool mounted,
  }) async {
    final exists = _userService.userExists(username, email);

    if (exists) {
      AppSnackBar.error(context, "Username or Email already exists");
      return;
    }

    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: username,
      email: email,
      phone: "",
      shopName: "",
      password: password,
      createdAt: DateTime.now(),
    );

    await _userService.saveUser(user);
    await _authService.login(user.id);
    await _hiveService.openUserBoxes(user.id);

    if (!mounted) return;

    AppSnackBar.success(context, "Account created successfully!");

    AppNavigation.goToScreenAndRemoveAll(context, const DashboardScreen());
  }
}
