import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: AppSizes.font32,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          "Login to continue to your account",
          style: TextStyle(color: AppColors.grey, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
