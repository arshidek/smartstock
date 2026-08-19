import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppOutlineButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final double? fontSize;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;
  final bool isSelected;
  final Color backgroundColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const AppOutlineButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.fontSize,
    this.width,
    this.height,
    this.padding,
    this.borderColor = AppColors.blue,
    this.textColor = AppColors.blue,
    this.iconColor = AppColors.blue,
    this.backgroundColor = AppColors.blue,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? AppSizes.size55,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          backgroundColor: isSelected ? backgroundColor : AppColors.white,
          side: BorderSide(color: borderColor, width: AppSizes.borderSize2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.white : iconColor,
              size: AppSizes.font18,
            ),

            const SizedBox(width: AppSizes.size5),

            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? AppColors.white : textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize ?? AppSizes.font18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
