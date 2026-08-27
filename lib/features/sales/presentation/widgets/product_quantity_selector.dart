import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/buttons/app_outline_button.dart';
import '../../../../core/widgets/cards/app_card_widget.dart';
import '../../../../data/models/product_model.dart';

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
                  if (quantity > 1) {
                    onQuantityChanged(quantity - 1);
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
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.size15,
                ),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderRadius12,
                  ),
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
                  if (selectedProduct == null) return;
                  int maxSaleQuantity = selectedProduct!.stock;
                  if (maxSaleQuantity <= 0) {
                    AppSnackBar.warning(context, "Product is Out of Stock.");
                    return;
                  }
                  if (quantity < maxSaleQuantity) {
                    onQuantityChanged(quantity + 1);
                  } else {
                    AppSnackBar.warning(context, "Only $maxSaleQuantity units can be sold.");
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
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Quick Add',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [1, 5, 10, 25].map((q) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: q != 25 ? AppSizes.size10 : 0,
                  ),
                  child: AppOutlineButton(
                    text: "$q",
                    icon: Icons.add,
                    height: AppSizes.size40,
                    fontSize: AppSizes.font18,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (selectedProduct == null) return;
                      int maxSaleQuantity = selectedProduct!.stock;
                      if (maxSaleQuantity <= 0) {
                        AppSnackBar.warning(context, "Product is Out of Stock.");
                        return;
                      }
                      if (quantity + q <= maxSaleQuantity) {
                        onQuantityChanged(quantity + q);
                      } else {
                        onQuantityChanged(maxSaleQuantity);
                      }
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
