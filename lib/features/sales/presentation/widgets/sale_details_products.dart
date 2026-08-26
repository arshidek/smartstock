import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../data/models/sale_model.dart';

class SaleDetailsProducts extends StatelessWidget {
  final SaleModel sale;

  const SaleDetailsProducts({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Products",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        ...sale.items.map((item) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              child: item.imagePath.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: kIsWeb
                          ? Image.network(
                              item.imagePath,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(item.imagePath),
                              fit: BoxFit.cover,
                            ),
                    )
                  : const Icon(Icons.widgets_outlined),
            ),
            title: Text(item.productName),
            subtitle: Text(
              "${item.quantity} × ₹${item.sellingPrice.toStringAsFixed(2)}",
            ),
            trailing: Text(
              "₹${item.totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }),
      ],
    );
  }
}
