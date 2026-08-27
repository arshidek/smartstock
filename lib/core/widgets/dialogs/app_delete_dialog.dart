import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppDeleteDialog {
  AppDeleteDialog._();

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AppSizes.size5,
            sigmaY: AppSizes.size5,
          ),
          child: Dialog(
            elevation: AppSizes.size20,
            backgroundColor: Colors.transparent,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(AppSizes.padding25),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.padding25),
                border: Border.all(color: AppColors.white),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.15),
                    blurRadius: AppSizes.blurRadius,
                    spreadRadius: 2,
                    offset: const Offset(0, AppSizes.size10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Delete Icon
                  Container(
                    width: AppSizes.size100,
                    height: AppSizes.size100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xffFF6B6B), Color(0xffE53935)],
                      ),
                    ),
                    child: Icon(
                      Icons.delete_forever_rounded,
                      color: AppColors.white,
                      size: AppSizes.size45,
                    ),
                  ),

                  const SizedBox(height: AppSizes.size25),

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: AppSizes.font24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: AppSizes.size12),

                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppSizes.font16,
                      color: AppColors.grey,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: AppSizes.size30),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            AppNavigation.goBackWithResult(context, false);
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(AppSizes.size50),
                            side: BorderSide(color: AppColors.lightBlue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSizes.borderRadius16,
                              ),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: AppSizes.size15),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            AppNavigation.goBackWithResult(context, true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            elevation: 0,
                            minimumSize: const Size.fromHeight(AppSizes.size50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSizes.borderRadius16,
                              ),
                            ),
                          ),
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
