import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/dialogs/app_delete_dialog.dart';
import '../../../core/widgets/popup/app_popup_menu.dart';
import '../../../data/models/category_model.dart';
import '../function/category_functions.dart';
import '../presentation/edit_category_bottom_sheet.dart';

class CategoryDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final CategoryModel category;
  final CategoryFunctions categoryFunctions;
  final VoidCallback onRefresh;

  const CategoryDetailsAppBar({
    super.key,
    required this.category,
    required this.categoryFunctions,
    required this.onRefresh,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarColor,
      elevation: 1,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.black,
          size: AppSizes.size30,
        ),
        onPressed: () {
          AppNavigation.goBackWithResult(context, true);
        },
      ),
      title: Text(
        category.name.toUpperCase(),
        style: const TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.font24,
        ),
      ),
      actions: [
        AppPopupMenu(
          onEdit: () async {
            final result = await AppNavigation.showBottomSheet<bool>(
              context,
              EditCategoryBottomSheet(category: category),
            );

            if (result == true) {
              onRefresh();
            }
          },
          onDelete: () async {
            final confirm = await AppDeleteDialog.show(
              context: context,
              title: "Delete Category",
              message: "Are you sure you want to delete ${category.name}?",
            );

            if (confirm == true) {
              await categoryFunctions.deleteCategory(
                context: context,
                category: category,
              );

              AppNavigation.goBack(context);
            }
          },
        ),

        const SizedBox(width: AppSizes.size12),
      ],
    );
  }
}
