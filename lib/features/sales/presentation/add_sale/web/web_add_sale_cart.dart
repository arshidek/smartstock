import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/widgets/cards/app_card_widget.dart';
import '../../../../../data/models/sale_item_model.dart';
import '../../../function/sale_calculation_functions.dart';
import '../../../function/sale_save_functions.dart';
import '../../../function/sale_update_functions.dart';
import '../../../widgets/cart_item_card.dart';

class WebAddSaleCart extends StatelessWidget {
  final List<SaleItemModel> cartItems;
  final SaleCalculationFunctions saleCalculationFunctions;
  final SaleSaveFunctions saleSaveFunctions;
  final SaleUpdateFunctions saleUpdateFunctions;
  final Function(List<SaleItemModel>) onCartUpdated;

  const WebAddSaleCart({
    super.key,
    required this.cartItems,
    required this.saleCalculationFunctions,
    required this.saleSaveFunctions,
    required this.saleUpdateFunctions,
    required this.onCartUpdated,
  });

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return AppCardWidget(
        margin: const EdgeInsets.symmetric(horizontal: AppSizes.padding16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                size: AppSizes.size60,
                color: AppColors.grey,
              ),
              const SizedBox(height: AppSizes.size15),
              const Text(
                "No Products Added",
                style: TextStyle(
                  fontSize: AppSizes.font20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.size10),
              const Text(
                "Tap the 'Add Product' button below to add products to this sale.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppSizes.font16,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 150,
        crossAxisSpacing: 10,
      ),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];

        return CartItemCard(
          item: item,
          onQuantityChanged: (change) {
            saleCalculationFunctions.updateQuantity(cartItems, index, change);
            onCartUpdated(cartItems);
          },
          onRemove: () {
            saleCalculationFunctions.removeItem(cartItems, index);
            onCartUpdated(cartItems);
          },
        );
      },
    );
  }
}
