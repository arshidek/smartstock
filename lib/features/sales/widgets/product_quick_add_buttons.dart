import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/buttons/app_outline_button.dart';
import '../../../../data/models/product_model.dart';

class ProductQuickAddButtons extends StatelessWidget {
  final ProductModel? selectedProduct;
  final int currentQuantity;
  final ValueChanged<int> onQuantityChanged;

  const ProductQuickAddButtons({
    super.key,
    required this.selectedProduct,
    required this.currentQuantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [1, 5, 10, 25].map((q) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: q != 25 ? AppSizes.size10 : 0),
            child: AppOutlineButton(
              text: "$q",
              icon: Icons.add,
              height: AppSizes.size40,
              fontSize: AppSizes.font18,
              padding: EdgeInsets.zero,
              onPressed: () {
                if (selectedProduct == null) {
                  AppSnackBar.warning(
                    context,
                    "⚠️ Please select a product first.",
                  );
                  return;
                }
                final int maxQty = selectedProduct!.stock;
                final String name = selectedProduct!.name;
                if (maxQty <= 0) {
                  AppSnackBar.warning(
                    context,
                    "\u26A0\uFE0F $name is Out of Stock.",
                  );
                  return;
                }
                if (currentQuantity + q <= maxQty) {
                  onQuantityChanged(currentQuantity + q);
                } else {
                  AppSnackBar.warning(
                    context,
                    "\u26A0\uFE0F Only $maxQty units of $name are available.",
                  );
                }
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
