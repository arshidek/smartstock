import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/widgets/dialogs/app_delete_dialog.dart';
import '../../../core/widgets/popup/app_popup_menu.dart';
import '../../../data/models/product_model.dart';
import '../../../core/services/product_service.dart';
import '../presentation/edit_product/edit_product_screen.dart';

class ProductDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final ProductModel product;
  final VoidCallback onRefresh;
  final ProductService _productService = ProductService();

  ProductDetailAppBar({
    super.key,
    required this.product,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBarColor,
      title: const Text(
        "Product Details",
        style: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.font24,
        ),
      ),

      elevation: 1,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.black,
          size: AppSizes.size30,
        ),
        onPressed: () {
          AppNavigation.goBack(context);
        },
      ),
      actions: [
        AppPopupMenu(
          onEdit: () async {
            final result = await AppNavigation.goToScreen(
              context,
              EditProductScreen(product: product),
            );
            if (result == true) {
              onRefresh();
            }
          },
          onDelete: () async {
            final confirm = await AppDeleteDialog.show(
              context: context,
              title: "Delete Product",
              message: "Are you sure you want to delete this product?",
            );
            if (confirm == true) {
              await _productService.deleteProduct(product.id);
              if (context.mounted) {
                AppSnackBar.success(context, "Product deleted successfully");
                AppNavigation.goBackWithResult(context, true);
              }
            }
          },
          iconColor: AppColors.black,
        ),
        const SizedBox(width: AppSizes.size12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
