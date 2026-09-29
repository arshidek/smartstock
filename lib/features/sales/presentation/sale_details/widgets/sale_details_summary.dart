import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../data/models/sale_model.dart';

class SaleDetailsSummary extends StatelessWidget {
  final SaleModel sale;

  const SaleDetailsSummary({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRow("Subtotal", "₹${sale.subTotal.toStringAsFixed(2)}"),
        _buildRow("Discount", "₹${sale.discount.toStringAsFixed(2)}"),
        _buildRow("Total Quantity", "${sale.totalQuantity}"),
        _buildRow("Profit", "₹${sale.totalProfit.toStringAsFixed(2)}"),
        const Divider(),
        _buildRow(
          "Grand Total",
          "₹${sale.grandTotal.toStringAsFixed(2)}",
          isBold: true,
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: AppColors.grey)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
                fontSize: isBold ? AppSizes.font16 : AppSizes.font14,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
