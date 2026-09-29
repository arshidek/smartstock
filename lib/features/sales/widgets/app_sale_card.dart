import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/popup/app_popup_menu.dart';
import 'sale_product_image.dart';
import 'app_sale_card_details.dart';

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
                blurRadius: AppSizes.borderRadius12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final row = Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// IMAGE
                      SaleProductImage(imagePath: imagePath),

                      const SizedBox(width: AppSizes.font15),

                      AppSaleCardDetails(
                        productName: productName,
                        paymentMethod: paymentMethod,
                        quantity: quantity,
                        showMenu: showMenu,
                        brandName: brandName,
                        categoryName: categoryName,
                        amount: amount,
                        date: date,
                        profit: profit,
                      ),
                    ],
                  );

                  return FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: SizedBox(width: constraints.maxWidth, child: row),
                  );
                },
              ),
              if (showMenu)
                Positioned(
                  top: -12,
                  right: -12,
                  child: AppPopupMenu.sale(
                    compact: true,
                    iconColor: AppColors.black,
                    onUpdate: onUpdate,
                    onDelete: onDelete,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
