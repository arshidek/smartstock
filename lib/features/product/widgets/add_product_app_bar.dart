import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

/// App bar for the Add Product screen.
class AddProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddProductAppBar({super.key});

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
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Product',
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.font24
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
