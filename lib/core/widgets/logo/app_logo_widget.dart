import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: AppSizes.logoSize,
            height: AppSizes.logoSize,
            decoration: BoxDecoration(
              color: AppColors.logoBackground,
              borderRadius: BorderRadius.circular(AppSizes.logoRadius),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blueShadow,
                  blurRadius: AppSizes.blurRadius,
                  spreadRadius: AppSizes.spreadRadius,
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/app_logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(height: AppSizes.size20),

        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Smart',
                style: TextStyle(
                  fontSize: AppSizes.size40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              TextSpan(
                text: 'Stock',
                style: TextStyle(
                  fontSize: AppSizes.size40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                ),
              ),
            ],
          ),
        ),

        const Text(
          "Smart Inventory Management",
          style: TextStyle(
            fontSize: AppSizes.font16,
            color: AppColors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
