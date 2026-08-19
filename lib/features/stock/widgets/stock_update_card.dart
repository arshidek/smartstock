import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/buttons/app_outline_button.dart';
import '../../../core/widgets/cards/app_card_widget.dart';

class StockUpdateCard extends StatelessWidget {
  final bool isAddStock;
  final int quantity;
  final ValueChanged<bool> onActionChanged;
  final ValueChanged<int> onQuantityChanged;

  const StockUpdateCard({
    super.key,
    required this.isAddStock,
    required this.quantity,
    required this.onActionChanged,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Stock Update",
            style: TextStyle(
              fontSize: AppSizes.font20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppSizes.size20),

          Row(
            children: [
              _buildActionCard(
                title: "Add Stock",
                subtitle: "Increase Stock",
                icon: Icons.add_circle_outline,
                color: AppColors.success,
                isSelected: isAddStock,
                onTap: () => onActionChanged(true),
              ),

              const SizedBox(width: AppSizes.size12),

              _buildActionCard(
                title: "Remove Stock",
                subtitle: "Decrease Stock",
                icon: Icons.remove_circle_outline,
                color: AppColors.error,
                isSelected: !isAddStock,
                onTap: () => onActionChanged(false),
              ),
            ],
          ),

          const SizedBox(height: AppSizes.size20),

          const Divider(),

          const SizedBox(height: AppSizes.size20),

          const Text(
            "Quantity",
            style: TextStyle(
              fontSize: AppSizes.font16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppSizes.size15),

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
                  onQuantityChanged(quantity + 1);
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

          const Text(
            "Quick Select",
            style: TextStyle(
              fontSize: AppSizes.font16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: AppSizes.size10),

          Wrap(
            spacing: AppSizes.size10,
            runSpacing: AppSizes.size10,
            children: [1, 5, 10, 25].map((q) {
              return AppOutlineButton(
                text: "$q",
                icon: Icons.add,
                onPressed: () => onQuantityChanged(quantity + q),
                width: AppSizes.size60,
                height: AppSizes.size40,
                fontSize: AppSizes.font18,
                padding: EdgeInsets.zero,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSizes.padding16),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.1) : AppColors.white,
            border: Border.all(
              color: isSelected ? color : AppColors.lightGrey,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(AppSizes.borderRadius12),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: AppSizes.size32),
              const SizedBox(height: AppSizes.size10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: AppSizes.size5),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: AppSizes.font12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
