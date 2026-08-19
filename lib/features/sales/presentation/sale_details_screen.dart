import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/widgets/cards/app_card_widget.dart';

import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../data/models/sale_model.dart';

class SaleDetailsScreen extends StatefulWidget {
  final SaleModel sale;
  const SaleDetailsScreen({super.key, required this.sale});

  @override
  State<SaleDetailsScreen> createState() => _SaleDetailsScreenState();
}

class _SaleDetailsScreenState extends State<SaleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final sale = widget.sale;
    final items = sale.items;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        automaticallyImplyLeading: false,

        leading: IconButton(
          onPressed: () => AppNavigation.goBack(context),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
            size: AppSizes.size30,
          ),
        ),

        titleSpacing: 0,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sale Details",
              style: TextStyle(
                color: AppColors.black,
                fontSize: AppSizes.font24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 2),

            Text(
              "View completed sale information",
              style: TextStyle(
                color: AppColors.grey,
                fontSize: AppSizes.font12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {
              // Print Invoice
            },
            icon: const Icon(
              Icons.print_outlined,
              color: AppColors.black,
              size: AppSizes.size25,
            ),
          ),

          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.black),
            onSelected: (value) {
              switch (value) {
                case "share":
                  // Share Invoice
                  break;

                case "invoice":
                  // Open Invoice Screen
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: "invoice", child: Text("View Invoice")),
              PopupMenuItem(value: "share", child: Text("Share Invoice")),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.background),

        child: ListView(
          children: [
            const SizedBox(height: 15),

            /// Sale Information
            AppCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sale Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  _buildRow("Invoice No", sale.invoiceNo),
                  _buildRow(
                    "Sale Date",
                    "${sale.saleDate.day}/${sale.saleDate.month}/${sale.saleDate.year}",
                  ),
                  _buildRow("Payment Method", sale.paymentMethod),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// Customer Details
            AppCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Customer Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  _buildRow(
                    "Customer Name",
                    sale.customerName.isEmpty ? "N/A" : sale.customerName,
                  ),

                  _buildRow(
                    "Phone Number",
                    sale.customerPhone.isEmpty ? "N/A" : sale.customerPhone,
                  ),

                  _buildRow(
                    "Email",
                    sale.customerEmail.isEmpty ? "N/A" : sale.customerEmail,
                  ),

                  _buildRow(
                    "Address",
                    sale.customerAddress.isEmpty ? "N/A" : sale.customerAddress,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// Products
            AppCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Products",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  ...items.map((item) {
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
              ),
            ),

            const SizedBox(height: 15),

            /// Summary
            AppCardWidget(
              child: Column(
                children: [
                  _buildRow("Subtotal", "₹${sale.subTotal.toStringAsFixed(2)}"),

                  _buildRow("Discount", "₹${sale.discount.toStringAsFixed(2)}"),

                  _buildRow("Total Quantity", "${sale.totalQuantity}"),

                  _buildRow(
                    "Profit",
                    "₹${sale.totalProfit.toStringAsFixed(2)}",
                  ),

                  const Divider(),

                  _buildRow(
                    "Grand Total",
                    "₹${sale.grandTotal.toStringAsFixed(2)}",
                    isBold: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// Note
            AppCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Note",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Text(sale.note.isEmpty ? "No note added." : sale.note),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(title, style: const TextStyle(color: Colors.grey)),
          ),

          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
                fontSize: isBold ? 18 : 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
