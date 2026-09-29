import 'package:flutter/material.dart';
import '../../../../../app/app_navigation.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/widgets/cards/app_card_widget.dart';
import '../../../../../data/models/sale_model.dart';
import '../widgets/sale_details_customer.dart';
import '../widgets/sale_details_information.dart';
import '../widgets/sale_details_products.dart';
import '../widgets/sale_details_summary.dart';

class WebSaleDetailsScreen extends StatelessWidget {
  final SaleModel sale;

  const WebSaleDetailsScreen({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.background),
        child: ListView(
          children: [
            const SizedBox(height: AppSizes.size15),
            AppCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SaleDetailsInformation(sale: sale),
                  const Divider(height: AppSizes.size30),
                  SaleDetailsCustomer(sale: sale),
                  const Divider(height: AppSizes.size30),
                  SaleDetailsProducts(sale: sale),
                  const Divider(height: AppSizes.size30),
                  SaleDetailsSummary(sale: sale),
                  const Divider(height: AppSizes.size30),
                  const Text(
                    "Note",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.font18,
                    ),
                  ),
                  const SizedBox(height: AppSizes.size10),
                  Text(
                    sale.note.isEmpty ? "No note provided." : sale.note,
                    style: TextStyle(
                      color: sale.note.isEmpty
                          ? AppColors.grey
                          : AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.size25),
          ],
        ),
      ),
    );
  }
}
