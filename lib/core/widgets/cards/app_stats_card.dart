import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import 'package:smartstock_inventory/core/responsive/responsive.dart';
import '../../constants/app_colors.dart';

class AppStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final double? valueFontSize;
  final VoidCallback? onTap;

  const AppStatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    this.valueFontSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSizes.borderRadius25),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius25),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(AppSizes.padding12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius25),

            border: Border.all(color: AppColors.white, width: 1),

            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(.04),
                blurRadius: AppSizes.blurRadius,
                spreadRadius: 1,
                offset: const Offset(0, AppSizes.size10),
              ),
            ],
          ),

          child: Builder(
            builder: (context) {
              final content = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: Responsive.isMobile(context)
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    width: AppSizes.size40,
                    height: AppSizes.size40,
                    decoration: BoxDecoration(
                      color: iconBackgroundColor,
                      borderRadius: BorderRadius.circular(
                        AppSizes.borderRadius16,
                      ),
                    ),
                    child: Icon(icon, color: iconColor, size: AppSizes.size25),
                  ),

                  const SizedBox(height: AppSizes.size8),

                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: AppSizes.font16,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSizes.size5),

                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: valueFontSize ?? AppSizes.font26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: AppSizes.size5),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: AppSizes.font13,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ],
                ],
              );

              return FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: content,
              );
            },
          ),
        ),
      ),
    );
  }
}
