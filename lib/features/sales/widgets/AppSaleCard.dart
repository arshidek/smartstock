import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/popup/app_popup_menu.dart';

class AppSaleCard extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String invoiceNo;
  final String brandName;
  final String categoryName;
  final String date;
  final String paymentMethod;
  final int quantity;
  final String amount;
  final String profit;
  final VoidCallback? onTap;
  final bool showMenu;
  final VoidCallback? onUpdate;
  final VoidCallback? onDelete;

  const AppSaleCard({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.invoiceNo,
    required this.brandName,
    required this.categoryName,
    required this.date,
    required this.paymentMethod,
    required this.quantity,
    required this.amount,
    required this.profit,
    this.showMenu = false,
    this.onTap,
    this.onUpdate,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSizes.padding16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius20),
            border: Border.all(color: AppColors.blue.withValues(alpha: 0.08)),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.08),
                blurRadius: AppSizes.blurRadius,
                spreadRadius: 1,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: AppColors.blueShadow,
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final row = Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: imagePath.isNotEmpty
                        ? kIsWeb
                              ? Image.network(
                                  imagePath,
                                  width: 85,
                                  height: 85,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(imagePath),
                                  width: 85,
                                  height: 85,
                                  fit: BoxFit.cover,
                                )
                        : Container(
                            width: 85,
                            height: 85,
                            color: AppColors.lightGrey,
                            child: const Icon(Icons.image_outlined),
                          ),
                  ),

                  const SizedBox(width: 16),

                  /// DETAILS
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Top Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                productName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              paymentMethod,
                              style: const TextStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.lightBlue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "$quantity Qty",
                                style: const TextStyle(
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (showMenu)
                              AppPopupMenu.sale(
                                onUpdate: onUpdate,
                                onDelete: onDelete,
                              ),
                          ],
                        ),



                        /// Brand + Category and Amount Row
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "$brandName • $categoryName",
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Text(
                              amount,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        /// Date and Profit Row
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                date,
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 13,
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
                  ),
                ],
              );

              return FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: constraints.maxWidth,
                  child: row,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
