import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/buttons/app_button.dart';

/// Action buttons for the Edit Product screen.
class EditProductActionButtons extends StatelessWidget {
  final VoidCallback onUpdateProduct;
  final VoidCallback onUpdateStock;

  const EditProductActionButtons({
    super.key,
    required this.onUpdateProduct,
    required this.onUpdateStock,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isWeb(context)) {
      return Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 400, // Fixed width for web buttons
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: _buildUpdateStockButton()),
              const SizedBox(width: AppSizes.size15),
              Expanded(child: _buildUpdateProductButton()),
            ],
          ),
        ),
      );
    } else {
      return Row(
        children: [
          Expanded(child: _buildUpdateStockButton()),
          const SizedBox(width: AppSizes.size15),
          Expanded(child: _buildUpdateProductButton()),
        ],
      );
    }
  }

  Widget _buildUpdateProductButton() {
    return AppButton(
      text: "Update Product",
      icon: Icons.save,
      fontSize: AppSizes.font14,
      backgroundColor: AppColors.blue,
      textColor: AppColors.white,
      iconColor: AppColors.white,
      onPressed: onUpdateProduct,
    );
  }

  Widget _buildUpdateStockButton() {
    return AppButton(
      text: "Update Stock",
      icon: Icons.inventory,
      fontSize: AppSizes.font14,
      backgroundColor: AppColors.blue,
      textColor: AppColors.white,
      iconColor: AppColors.white,
      onPressed: onUpdateStock,
    );
  }
}
