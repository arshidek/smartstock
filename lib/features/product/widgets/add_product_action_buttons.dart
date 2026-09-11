import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/buttons/app_button.dart';

/// Action buttons for the Add Product screen.
class AddProductActionButtons extends StatelessWidget {
  final VoidCallback onSave;

  const AddProductActionButtons({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isWeb(context)) {
      return Align(
        alignment: Alignment.centerRight,
        child: SizedBox(width: AppSizes.size240, child: _buildButton()),
      );
    } else {
      return _buildButton();
    }
  }

  Widget _buildButton() {
    return AppButton(
      text: "Save Product",
      icon: Icons.save,
      backgroundColor: AppColors.blue,
      textColor: AppColors.white,
      iconColor: AppColors.white,
      onPressed: onSave,
    );
  }
}
