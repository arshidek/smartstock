import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppCustomTextField {
  // ─── Single-line field ───────────────────────────────────────────────────
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
    final Widget iconWidget = Container(
      width: AppSizes.size40,
      height: AppSizes.size40,
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
      ),
      child: Icon(icon, color: AppColors.blue, size: AppSizes.size22),
    );

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
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding10),
          child: iconWidget,
        ),
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

  // ─── Professional multiline / description field ──────────────────────────
  /// Custom textarea: icon + placeholder label always visible on the first
  /// row inside the border. The user types freely in the area below.
  static Widget multilineField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    int minLines = 4,
    TextInputAction textInputAction = TextInputAction.newline,
    void Function(String)? onChanged,
    Color? borderColor,
    double? borderRadius,
  }) {
    return FormField<String>(
      initialValue: controller.text,
      validator: (_) => validator(controller.text),
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: AppColors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(
                  borderRadius ?? AppSizes.borderRadius12,
                ),
                border: Border.all(
                  color: state.hasError
                      ? AppColors.error
                      : (borderColor ?? AppColors.textFieldBlue),
                  width: AppSizes.borderSize2,
                ),
              ),
              padding: const EdgeInsets.all(AppSizes.padding12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Icon + hint label row (always visible) ──
                  Row(
                    children: [
                      Container(
                        width: AppSizes.size40,
                        height: AppSizes.size40,
                        decoration: BoxDecoration(
                          color: AppColors.lightBlue,
                          borderRadius: BorderRadius.circular(
                            AppSizes.borderRadius12,
                          ),
                        ),
                        child: Icon(
                          icon,
                          color: AppColors.blue,
                          size: AppSizes.size22,
                        ),
                      ),
                      const SizedBox(width: AppSizes.size10),
                      Text(
                        hint,
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontSize: AppSizes.font14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.size8),
                  // ── Free-form typing area ──
                  TextField(
                    controller: controller,
                    onChanged: (v) {
                      state.didChange(v);
                      onChanged?.call(v);
                    },
                    minLines: minLines,
                    maxLines: null,
                    textInputAction: textInputAction,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: AppSizes.font14,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Start typing...',
                      hintStyle: TextStyle(
                        color: AppColors.lightGrey,
                        fontSize: AppSizes.font14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSizes.size5,
                  left: AppSizes.padding12,
                ),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: AppColors.error,
                    fontSize: AppSizes.font12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
