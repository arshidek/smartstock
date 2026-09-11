import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/dialogs/app_delete_dialog.dart';
import '../../../data/models/sale_item_model.dart';

class CartItemCard extends StatelessWidget {
  final SaleItemModel item;
  final Function(int)? onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.margin12),
      padding: EdgeInsets.all(AppSizes.padding16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
        border: Border.all(color: AppColors.lightGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: AppSizes.borderRadius8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final row = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              Container(
                width: AppSizes.size85,
                height: AppSizes.size85,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
                  child: item.imagePath.isNotEmpty
                      ? item.imagePath.startsWith('data:image')
                            ? Image.memory(
                                UriData.parse(item.imagePath).contentAsBytes(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.image_not_supported_outlined,
                                      color: AppColors.grey,
                                      size: AppSizes.size32,
                                    ),
                              )
                            : kIsWeb
                            ? Image.network(
                                item.imagePath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.image_not_supported_outlined,
                                      color: AppColors.grey,
                                      size: AppSizes.size32,
                                    ),
                              )
                            : Image.file(
                                File(item.imagePath),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.image_not_supported_outlined,
                                      color: AppColors.grey,
                                      size: AppSizes.size32,
                                    ),
                              )
                      : const Icon(
                          Icons.image_outlined,
                          color: AppColors.grey,
                          size: AppSizes.size32,
                        ),
                ),
              ),

              const SizedBox(width: AppSizes.size12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.productName,
                        style: const TextStyle(
                          fontSize: AppSizes.font16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${item.brandName} • ${item.categoryName}",
                        style: const TextStyle(color: AppColors.grey),
                      ),
                    ),

                    const SizedBox(height: AppSizes.size5),

                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "₹${item.sellingPrice.toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      final confirm = await AppDeleteDialog.show(
                        context: context,
                        title: "Remove Product",
                        message:
                            "Are you sure you want to remove this product from the sale?",
                      );

                      if (confirm == true) {
                        onRemove();
                      }
                    },
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadius20,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.delete,
                        color: AppColors.error,
                        size: AppSizes.size22,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSizes.size10),

                  Text(
                    "Qty : ${item.quantity}",
                    style: const TextStyle(
                      fontSize: AppSizes.font14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue,
                    ),
                  ),

                  const SizedBox(height: AppSizes.size5),

                  Text(
                    "₹${item.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: AppSizes.font16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.success
                    ),
                  ),
                ],
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
    );
  }
}
