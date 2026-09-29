import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../data/models/sale_model.dart';

class SaleDetailsInformation extends StatelessWidget {
  final SaleModel sale;

  const SaleDetailsInformation({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sale Information",
          style: TextStyle(
            fontSize: AppSizes.font18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.size15),
        _buildRow(
          "Sale Date",
          "${sale.saleDate.day} ${['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][sale.saleDate.month - 1]} ${sale.saleDate.year}",
        ),
        _buildRow("Payment Method", sale.paymentMethod),
      ],
    );
  }

  Widget _buildRow(String label, String value) {
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
              style: const TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
