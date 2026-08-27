


import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppPopupMenu extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onRestock;
  final VoidCallback? onUpdate;
  final VoidCallback? onRefresh;
  final VoidCallback? onShare;
  final VoidCallback? onExport;
  final bool isRestockMenu;
  final bool isSaleMenu;
  final bool isReportMenu;
  final bool compact;

  const AppPopupMenu({super.key, this.onEdit, this.onDelete, this.compact = false})
    : onRestock = null,
      onUpdate = null,
      onRefresh = null,
      onShare = null,
      onExport = null,
      isRestockMenu = false,
      isSaleMenu = false,
      isReportMenu = false;

  const AppPopupMenu.restock({super.key, required this.onRestock, this.compact = false})
    : onEdit = null,
      onDelete = null,
      onUpdate = null,
      onRefresh = null,
      onShare = null,
      onExport = null,
      isSaleMenu = false,
      isReportMenu = false,
      isRestockMenu = true;

  const AppPopupMenu.sale({super.key, required this.onUpdate, required this.onDelete, this.compact = false})
    : onEdit = null,
      onRestock = null,
      onRefresh = null,
      onShare = null,
      onExport = null,
      isRestockMenu = false,
      isReportMenu = false,
      isSaleMenu = true;

  const AppPopupMenu.report({
    super.key,
    required this.onRefresh,
    required this.onShare,
    required this.onExport,
    this.compact = false,
  })  : onEdit = null,
        onDelete = null,
        onRestock = null,
        onUpdate = null,
        isRestockMenu = false,
        isSaleMenu = false,
        isReportMenu = true;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      padding: compact ? EdgeInsets.zero : const EdgeInsets.all(8.0),
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
      icon: compact ? null : const Icon(
        Icons.more_vert_rounded,
        size: AppSizes.size30,
        color: AppColors.black,
      ),
      child: compact ? const Icon(Icons.more_vert, color: Colors.black87) : null,

      onSelected: (value) {
        switch (value) {
          case "restock":
            onRestock?.call();
            break;

          case "edit":
            onEdit?.call();
            break;

          case "update":
            onUpdate?.call();
            break;

          case "delete":
            onDelete?.call();
            break;
          case "refresh":
            onRefresh?.call();
            break;
            
          case "share":
            onShare?.call();
            break;
            
          case "export":
            onExport?.call();
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

        if (isSaleMenu) {
          return [
            _menuItem(
              value: "update",
              title: "Update Sale",
              icon: Icons.edit_rounded,
              color: AppColors.blue,
              bgColor: AppColors.lightBlue,
            ),
            const PopupMenuDivider(height: 1),
            _menuItem(
              value: "delete",
              title: "Delete Sale",
              icon: Icons.delete_outline_rounded,
              color: AppColors.error,
              bgColor: AppColors.lightRed,
            ),
          ];
        }

        if (isReportMenu) {
          return [
            _menuItem(
              value: "refresh",
              title: "Refresh Data",
              icon: Icons.refresh_rounded,
              color: AppColors.blue,
              bgColor: AppColors.lightBlue,
            ),
            const PopupMenuDivider(height: 1),
            _menuItem(
              value: "export",
              title: "Export PDF",
              icon: Icons.picture_as_pdf_outlined,
              color: AppColors.blue,
              bgColor: AppColors.lightBlue,
            ),
            const PopupMenuDivider(height: 1),
            _menuItem(
              value: "share",
              title: "Share Report",
              icon: Icons.share_rounded,
              color: AppColors.blue,
              bgColor: AppColors.lightBlue,
            ),
          ];
        }

        return [
          _menuItem(
            value: "edit",
            title: "Edit",
            icon: Icons.edit_rounded,
            color: AppColors.blue,
            bgColor: AppColors.lightBlue,
          ),

          const PopupMenuDivider(height: 1),

          _menuItem(
            value: "delete",
            title: "Delete",
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
