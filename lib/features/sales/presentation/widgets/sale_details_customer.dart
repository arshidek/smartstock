import 'package:flutter/material.dart';
import '../../../../data/models/sale_model.dart';

class SaleDetailsCustomer extends StatelessWidget {
  final SaleModel sale;

  const SaleDetailsCustomer({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
