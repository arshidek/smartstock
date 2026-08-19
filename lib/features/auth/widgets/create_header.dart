import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class CreateHeader extends StatelessWidget {
  const CreateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Create Account",
          style: TextStyle(
            fontSize: AppSizes.font32,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Text(
          "Fill in the details below to create your account",
          style: TextStyle(color: AppColors.grey, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
