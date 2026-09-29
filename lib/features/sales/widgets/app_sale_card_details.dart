import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class AppSaleCardDetails extends StatelessWidget {
  final String productName;
  final String paymentMethod;
  final int quantity;
  final bool showMenu;
  final String brandName;
  final String categoryName;
  final String amount;
  final String date;
  final String profit;

  const AppSaleCardDetails({
    super.key,
    required this.productName,
    required this.paymentMethod,
    required this.quantity,
    required this.showMenu,
    required this.brandName,
    required this.categoryName,
    required this.amount,
    required this.date,
    required this.profit,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: AppSizes.font18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.size8),
              Text(
                paymentMethod,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppSizes.size8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
                ),
                child: Text(
                  "$quantity Qty",
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (showMenu) const SizedBox(width: AppSizes.size28),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "$brandName • $categoryName",
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: AppSizes.font13,
                  ),
                ),
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: AppSizes.font18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.size5),
          Row(
            children: [
              Expanded(
                child: Text(
                  date,
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: AppSizes.font13,
                  ),
                ),
              ),
              Text(
                "Profit $profit",
                style: const TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
