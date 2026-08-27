import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/responsive/responsive.dart';

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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 8,
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
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: item.imagePath.isNotEmpty
                      ? kIsWeb
                          ? Image.network(item.imagePath, fit: BoxFit.cover)
                          : Image.file(File(item.imagePath), fit: BoxFit.cover)
                      : const Icon(
                          Icons.image_outlined,
                          color: Colors.grey,
                          size: 35,
                        ),
                ),
              ),

              const SizedBox(width: 12),

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
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${item.brandName} • ${item.categoryName}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),

                    const SizedBox(height: 5),

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
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 22,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 10),

                  Text(
                    "Qty : ${item.quantity}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "₹${item.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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

    );
  }
}
