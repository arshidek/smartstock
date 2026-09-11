import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppCardWidget extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const AppCardWidget({
    super.key,
    required this.child,
    this.backgroundColor,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(AppSizes.size15),
      padding: padding ?? const EdgeInsets.all(AppSizes.size25),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius25),
        border: Border.all(color: AppColors.blue.withOpacity(0.10), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.10),
            blurRadius: AppSizes.borderRadius30,
            spreadRadius: 1,
            offset: const Offset(0, AppSizes.size10),
          ),
          BoxShadow(
            color: AppColors.blueShadow,
            blurRadius: AppSizes.blurRadius,
            offset: const Offset(0, AppSizes.size10),
          ),
        ],
      ),
      child: child,
    );
  }
}
