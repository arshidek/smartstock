import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/widgets/buttons/app_button.dart';

class AddProductToSaleBottomBar extends StatelessWidget {
  final double totalPrice;
  final int quantity;
  final double ratePerUnit;
  final VoidCallback onAddToListPressed;

  const AddProductToSaleBottomBar({
    super.key,
    required this.totalPrice,
    required this.quantity,
    required this.ratePerUnit,
    required this.onAddToListPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding16,
        vertical: AppSizes.padding10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Price",
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSizes.size8),
                Text(
                  "₹${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: AppSizes.font26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(height: AppSizes.size5),
                Text(
                  "$quantity × ₹${ratePerUnit.toStringAsFixed(2)}",
                  style: const TextStyle(color: AppColors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.size20),
          kIsWeb
              ? SizedBox(
                  width: 180,
                  child: AppButton(
                    text: "Add to List",
                    icon: Icons.add_circle,
                    backgroundColor: AppColors.blue,
                    textColor: AppColors.white,
                    iconColor: AppColors.white,
                    onPressed: onAddToListPressed,
                  ),
                )
              : Expanded(
                  child: AppButton(
                    text: "Add to List",
                    icon: Icons.add_circle,
                    backgroundColor: AppColors.blue,
                    textColor: AppColors.white,
                    iconColor: AppColors.white,
                    onPressed: onAddToListPressed,
                  ),
                ),
        ],
      ),
    );
  }
}
