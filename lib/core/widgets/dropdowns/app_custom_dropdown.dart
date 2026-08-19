import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppCustomDropdown {
  static Widget dropdown<T>({
    required String label,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    IconData? icon,
    String? Function(T?)? validator,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      isExpanded: true,
      isDense: true,

      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.blue,
        size: 28,
      ),

      style: const TextStyle(
        color: AppColors.black,
        fontSize: AppSizes.font16,
        fontWeight: FontWeight.w500,
      ),

      borderRadius: BorderRadius.circular(AppSizes.borderRadius12),

      dropdownColor: AppColors.white,

      decoration: InputDecoration(
        hintText: label,

        labelStyle: const TextStyle(
          color: AppColors.grey,
          fontSize: AppSizes.font16,
          fontWeight: FontWeight.w500,
        ),

        hintStyle: const TextStyle(color: AppColors.grey),

        filled: true,
        fillColor: AppColors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),

        prefixIcon: icon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: Icon(icon, color: AppColors.grey),
              ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
          borderSide: const BorderSide(
            color: AppColors.textFieldBlue,
            width: 1.8,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
          borderSide: const BorderSide(color: AppColors.blue, width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),

        errorStyle: const TextStyle(
          color: AppColors.error,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
