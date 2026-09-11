import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../app/app_navigation.dart';

class ProductListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarColor,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.black,
          size: AppSizes.size30,
        ),
        onPressed: () {
          AppNavigation.goBack(context);
        },
      ),
      title: const Text(
        'Products',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.black,
          fontSize: AppSizes.font24,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
