import 'package:flutter/material.dart';

import '../../../app/app_navigation.dart';
import '../../../core/services/user_service.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../data/models/user_model.dart';

class ProfileFunctions {
  final UserService _userService = UserService();
  ProfileFunctions();

  Future<void> updateProfile({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required UserModel user,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController shopController,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    await _userService.updateUser(
      user: user,
      username: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      shopName: shopController.text.trim(),
    );

    AppSnackBar.success(context, "Profile updated successfully!");

    AppNavigation.goBack(context);
  }
}
