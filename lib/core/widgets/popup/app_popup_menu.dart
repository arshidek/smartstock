import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppPopupMenu extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onRestock;
  final bool isRestockMenu;

  const AppPopupMenu({super.key, this.onEdit, this.onDelete})
    : onRestock = null,
      isRestockMenu = false;

  const AppPopupMenu.restock({super.key, required this.onRestock})
    : onEdit = null,
      onDelete = null,
      isRestockMenu = true;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      elevation: AppSizes.size12,
      color: AppColors.white,
      shadowColor: AppColors.black.withOpacity(0.25),
      surfaceTintColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
        side: BorderSide(color: AppColors.white),
      ),
      constraints: const BoxConstraints(minWidth: AppSizes.size220),
      offset: const Offset(0, AppSizes.size55),
      icon: const Icon(
        Icons.more_vert_rounded,
        size: AppSizes.size30,
        color: AppColors.black,
      ),

      onSelected: (value) {
        switch (value) {
          case "restock":
            onRestock?.call();
            break;

          case "edit":
            onEdit?.call();
            break;

          case "delete":
            onDelete?.call();
            break;
        }
      },

      itemBuilder: (context) {
        if (isRestockMenu) {
          return [
            _menuItem(
              value: "restock",
              title: "Restock",
              icon: Icons.add_box_outlined,
              color: AppColors.blue,
              bgColor: AppColors.lightBlue,
            ),
          ];
        }

        return [
          _menuItem(
            value: "edit",
            title: "Edit Brand",
            icon: Icons.edit_rounded,
            color: AppColors.blue,
            bgColor: AppColors.lightBlue,
          ),

          const PopupMenuDivider(height: 1),

          _menuItem(
            value: "delete",
            title: "Delete Brand",
            icon: Icons.delete_outline_rounded,
            color: AppColors.error,
            bgColor: AppColors.lightRed,
          ),
        ];
      },
    );
  }

  PopupMenuItem<String> _menuItem({
    required String value,
    required String title,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    return PopupMenuItem<String>(
      value: value,
      height: AppSizes.size60,
      child: Row(
        children: [
          Container(
            width: AppSizes.size45,
            height: AppSizes.size45,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
            ),
            child: Icon(icon, color: color, size: AppSizes.size22),
          ),
          const SizedBox(width: AppSizes.size15),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: AppSizes.font16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
