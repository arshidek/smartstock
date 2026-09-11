import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutDialog({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(AppSizes.padding25),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSizes.size90,
              height: AppSizes.size90,
              decoration: BoxDecoration(
                color: AppColors.lightRed,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: AppSizes.size60,
                  height: AppSizes.size60,
                  decoration: BoxDecoration(
                    color: AppColors.lightError,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: AppColors.error,
                    size: AppSizes.size30,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.size25),

            const Text(
              "Logout",
              style: TextStyle(
                fontSize: AppSizes.font24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: AppSizes.size12),

            const Text(
              "Are you sure you want to logout?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: AppSizes.font16,
              ),
            ),

            const SizedBox(height: AppSizes.size30),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      AppNavigation.goBack(context);
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(AppSizes.size55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius16,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: AppSizes.font16),
                    ),
                  ),
                ),

                const SizedBox(width: AppSizes.size15),

                Expanded(
                  child: ElevatedButton(
                    onPressed: onLogout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      minimumSize: const Size.fromHeight(AppSizes.size55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius16,
                        ),
                      ),
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: AppSizes.font16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
