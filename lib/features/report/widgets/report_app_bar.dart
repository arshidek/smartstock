import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../app/app_navigation.dart';
import '../../../core/widgets/popup/app_popup_menu.dart';

class ReportAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onRefresh;
  final VoidCallback onExport;
  final VoidCallback onShare;

  const ReportAppBar({
    super.key,
    required this.onRefresh,
    required this.onExport,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blue,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => AppNavigation.goBack(context),
        icon:  Icon(
          Icons.arrow_back,
          color: AppColors.white,
          size: AppSizes.size30,
        ),
      ),
      titleSpacing: 0,
      title:  Text(
        "Reports",
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.font24,
        ),
      ),
      actions: [
        AppPopupMenu.report(
          onRefresh: onRefresh,
          onShare: onShare,
          onExport: onExport,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
