import 'package:flutter/material.dart';

import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/dialogs/app_delete_dialog.dart';
import '../../../core/widgets/popup/app_popup_menu.dart';
import '../../../data/models/brand_model.dart';
import '../function/brand_functions.dart';
import '../presentation/edit_brand_bottom_sheet.dart';

class BrandDetailsAppBar extends StatefulWidget implements PreferredSizeWidget {
  final BrandModel brand;
  final BrandFunctions brandFunctions;
  final VoidCallback onRefresh;

  const BrandDetailsAppBar({
    super.key,
    required this.brand,
    required this.brandFunctions,
    required this.onRefresh,
  });

  @override
  State<BrandDetailsAppBar> createState() => _BrandDetailsAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BrandDetailsAppBarState extends State<BrandDetailsAppBar> {
  Future<void> _editBrand() async {
    final result = await AppNavigation.showBottomSheet<bool>(
      context,
      EditBrandBottomSheet(brand: widget.brand),
    );
    print("BottomSheet Result: $result");
    if (result == true) {
      final updatedBrand = widget.brandFunctions.getBrands().firstWhere(
        (b) => b.id == widget.brand.id,
      );

      widget.brand.name = updatedBrand.name;
      widget.brand.description = updatedBrand.description;
      widget.brand.imagePath = updatedBrand.imagePath;

      print("Before Refresh: ${widget.brand.name}");
      widget.onRefresh();
      print("After Refresh: ${widget.brand.name}");
    }
  }

  Future<void> _deleteBrand() async {
    final confirm = await AppDeleteDialog.show(
      context: context,
      title: "Delete Brand",
      message: "Are you sure you want to delete ${widget.brand.name}?",
    );

    if (confirm == true) {
      await widget.brandFunctions.deleteBrand(
        context: context,
        brand: widget.brand,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarColor,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.black,
          size: AppSizes.size30,
        ),
        onPressed: () {
          AppNavigation.goBack(context);
        },
      ),
      title: Text(
        widget.brand.name.toUpperCase(),
        style: const TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.font24,
        ),
      ),
      actions: [AppPopupMenu(onEdit: _editBrand, onDelete: _deleteBrand)],
    );
  }
}
