import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppCustomTextField {
  static Widget textField({
    required TextEditingController controller,
    required String label,
    String? hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    Widget? suffixIcon,

    EdgeInsetsGeometry? contentPadding,
    bool obscureText = false,
    TextInputAction textInputAction = TextInputAction.next,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
    Color? borderColor,
    double? borderRadius,
  }) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      obscureText: obscureText,
      textInputAction: textInputAction,
      style: const TextStyle(color: AppColors.black),
      decoration: InputDecoration(
        hintText: hint ?? label,
        contentPadding: contentPadding,
        labelStyle: const TextStyle(color: AppColors.grey),
        suffixIcon: suffixIcon,
        alignLabelWithHint: maxLines > 1,
        prefixIcon: maxLines > 1
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Icon(icon, color: AppColors.grey),
                  ),
                ],
              )
            : Icon(icon, color: AppColors.grey),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.borderRadius12),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.textFieldBlue,
            width: AppSizes.borderSize2,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.borderRadius12),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.textFieldBlue,
            width: AppSizes.borderSize2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.borderRadius12),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: AppSizes.borderSize2,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.borderRadius12),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: AppSizes.borderSize2,
          ),
        ),

        errorStyle: const TextStyle(
          color: AppColors.error,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
