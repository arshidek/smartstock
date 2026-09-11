import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class SplashContent extends StatelessWidget {
  final Animation<double> scaleAnimation;

  const SplashContent({super.key, required this.scaleAnimation});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),

          ScaleTransition(
            scale: scaleAnimation,
            child: Center(
              child: Container(
                width: AppSizes.size160,
                height: AppSizes.size160,
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
          ),

          const SizedBox(height: AppSizes.size40),

          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Smart',
                  style: TextStyle(
                    fontSize: AppSizes.font42,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                TextSpan(
                  text: 'Stock',
                  style: TextStyle(
                    fontSize: AppSizes.font42,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.size10),

          const Text(
            "Manage your mobile shop \n inventory easily",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSizes.font18,
              color: AppColors.lightBlack,
            ),
          ),

          const Spacer(),

          Column(
            children: [
              const Text(
                "Loading...",
                style: TextStyle(
                  color: AppColors.blue,
                  fontSize: AppSizes.font16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSizes.size15),
              SizedBox(
                width: AppSizes.size240,
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.white,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.blue,
                  ),
                  minHeight: AppSizes.size7,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.size60),
        ],
      ),
    );
  }
}
