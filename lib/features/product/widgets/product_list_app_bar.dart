import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../app/app_navigation.dart';

/// App bar for the product list screen.
class ProductListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductListAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarColor,
      elevation: 0,
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
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: AppSizes.size12),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: AppColors.black,
            size: 26,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
