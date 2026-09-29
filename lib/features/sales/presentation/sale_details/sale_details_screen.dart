import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import 'mobile/mobile_sale_details_screen.dart';
import 'web/web_sale_details_screen.dart';
import '../../../../data/models/sale_model.dart';


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
    return Responsive.isMobile(context)
        ? MobileSaleDetailsScreen(sale: sale)
        : WebSaleDetailsScreen(sale: sale);
  }
}

