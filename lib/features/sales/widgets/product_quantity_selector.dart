import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/cards/app_card_widget.dart';
import '../../../../data/models/product_model.dart';
import 'product_quick_add_buttons.dart';

class ProductQuantitySelector extends StatelessWidget {
  final int quantity;
  final ProductModel? selectedProduct;
  final ValueChanged<int> onQuantityChanged;

  const ProductQuantitySelector({
    super.key,
    required this.quantity,
    required this.selectedProduct,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text.rich(
            TextSpan(
              text: 'Quantity ',
              children: [
                TextSpan(
                  text: "*",
                  style: TextStyle(color: AppColors.error),
                ),
              ],
            ),
            style: TextStyle(
              fontSize: AppSizes.font18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (selectedProduct == null) {
                    AppSnackBar.warning(
                      context,
                      "Please select a product first.",
                    );
                    return;
                  }
                  if (quantity > 0) {
                    onQuantityChanged(quantity - 1);
                  } else {
                    AppSnackBar.warning(
                      context,
                      "⚠️ Quantity cannot be less than zero.",
                    );
                  }
                },
                icon: const Icon(
                  Icons.remove_circle,
                  color: AppColors.blue,
                  size: AppSizes.size32,
                ),
              ),
              const SizedBox(width: AppSizes.size15),
              Container(
                width: AppSizes.size100,
                padding: const EdgeInsets.symmetric(vertical: AppSizes.size15),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
                ),
                child: Column(
                  children: [
                    Text(
                      "$quantity",
                      style: const TextStyle(
                        fontSize: AppSizes.font30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Units",
                      style: TextStyle(fontSize: AppSizes.font16),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.size15),
              IconButton(
                onPressed: () {
                  if (selectedProduct == null) {
                    AppSnackBar.warning(
                      context,
                      "⚠Please select a product first.",
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
                  if (quantity < maxQty) {
                    onQuantityChanged(quantity + 1);
                  } else {
                    AppSnackBar.warning(
                      context,
                      "\u26A0\uFE0F Only $maxQty units of $name are available.",
                    );
                  }
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: AppColors.blue,
                  size: AppSizes.size32,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.size20),
          Text(
            selectedProduct == null
                ? "Available: 0 units"
                : "Available: ${selectedProduct!.stock} units",
            style: TextStyle(
              color: selectedProduct == null
                  ? AppColors.grey
                  : selectedProduct!.stock <= 0
                  ? AppColors.error
                  : selectedProduct!.stock <= 5
                  ? AppColors.warning
                  : AppColors.success,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.size20),
          const Text(
            'Quick Add',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSizes.size10),
          ProductQuickAddButtons(
            selectedProduct: selectedProduct,
            currentQuantity: quantity,
            onQuantityChanged: onQuantityChanged,
          ),
        ],
      ),
    );
  }
}
