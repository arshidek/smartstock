import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppOutlineButton extends StatelessWidget {
  final String text;
  final String? subText;
  final IconData? icon;
  final Widget? trailing;
  final VoidCallback onPressed;
  final double? fontSize;
  final Color borderColor;
  final Color textColor;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final bool isSelected;
  final bool expandText;
  final Color backgroundColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const AppOutlineButton({
    super.key,
    required this.text,
    this.subText,
    this.icon,
    this.trailing,
    required this.onPressed,
    this.fontSize,
    this.width,
    this.height,
    this.padding,
    this.borderColor = AppColors.blue,
    this.textColor = AppColors.blue,
    this.iconColor = AppColors.blue,
    this.iconBackgroundColor,
    this.backgroundColor = AppColors.blue,
    this.isSelected = false,
    this.expandText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      constraints: BoxConstraints(minHeight: height ?? AppSizes.size55),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: AppSizes.padding12,
                vertical: 8,
              ),
          backgroundColor: isSelected ? backgroundColor : AppColors.white,
          side: BorderSide(color: borderColor, width: AppSizes.borderSize2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Container(
                padding: EdgeInsets.all(iconBackgroundColor != null ? 8 : 0),
                decoration: iconBackgroundColor != null
                    ? BoxDecoration(
                        color: isSelected
                            ? Colors.white.withOpacity(0.2)
                            : iconBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      )
                    : null,
                child: Icon(
                  icon,
                  color: isSelected ? AppColors.white : iconColor,
                  size: AppSizes.font18,
                ),
              ),
              const SizedBox(width: AppSizes.size12),
            ],
            if (expandText)
              Expanded(child: _buildTextColumn())
            else
              Flexible(child: _buildTextColumn()),
            if (trailing != null) ...[
              const SizedBox(width: AppSizes.size8),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: expandText
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isSelected ? AppColors.white : textColor,
            fontWeight: FontWeight.w600,
            fontSize: fontSize ?? AppSizes.font18,
          ),
        ),
        if (subText != null)
          Text(
            subText!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isSelected
                  ? AppColors.white.withOpacity(0.8)
                  : Colors.grey.shade600,
              fontSize: AppSizes.font12,
            ),
          ),
      ],
    );
  }
}
