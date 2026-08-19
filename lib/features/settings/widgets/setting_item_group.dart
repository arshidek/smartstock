import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class SettingItemModel {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color iconColor;
  final Color iconBackgroundColor;
  final bool isDestructive;

  SettingItemModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.iconColor,
    required this.iconBackgroundColor,
    this.isDestructive = false,
  });
}

class SettingItemGroup extends StatelessWidget {
  final List<SettingItemModel> items;

  const SettingItemGroup({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.size20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackShadow.withValues(alpha: 0.03),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          int index = entry.key;
          SettingItemModel item = entry.value;

          return Column(
            children: [
              InkWell(
                onTap: item.onTap,
                borderRadius: _getBorderRadius(index, items.length),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.size15),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSizes.size12),
                        decoration: BoxDecoration(
                          color: item.iconBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(item.icon, size: 20, color: item.iconColor),
                      ),
                      const SizedBox(width: AppSizes.size15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: item.isDestructive
                                      ? AppColors.error
                                      : AppColors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item.subtitle,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.lightGrey,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
              if (index != items.length - 1)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFF1F5F9), // Very faint divider
                  indent: AppSizes.size15, // Indent from left
                  endIndent: AppSizes.size15,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  BorderRadius _getBorderRadius(int index, int length) {
    if (length == 1) {
      return BorderRadius.circular(AppSizes.borderRadius16);
    } else if (index == 0) {
      return const BorderRadius.vertical(
        top: Radius.circular(AppSizes.borderRadius16),
      );
    } else if (index == length - 1) {
      return const BorderRadius.vertical(
        bottom: Radius.circular(AppSizes.borderRadius16),
      );
    }
    return BorderRadius.zero;
  }
}
