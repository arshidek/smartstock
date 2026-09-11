import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../constants/app_colors.dart';

class AppInfoDialog {
  AppInfoDialog._();

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AppSizes.size5,
            sigmaY: AppSizes.size5,
          ),
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(AppSizes.padding25),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSizes.padding25),
                border: Border.all(color: AppColors.white),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.12),
                    blurRadius: AppSizes.blurRadius,
                    spreadRadius: 2,
                    offset: const Offset(0, AppSizes.size10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Warning Icon
                  Container(
                    width: AppSizes.size100,
                    height: AppSizes.size100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.infoGradient,
                    ),
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.white,
                      size: AppSizes.size45,
                    ),
                  ),

                  const SizedBox(height: AppSizes.size25),

                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: AppSizes.size25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),

                  const SizedBox(height: AppSizes.size15),

                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: AppSizes.font16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: AppSizes.size30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        AppNavigation.goBack(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue,
                        elevation: 0,
                        minimumSize: const Size.fromHeight(AppSizes.size55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius16,
                          ),
                        ),
                      ),
                      child: Text(
                        "OK",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: AppSizes.font16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
