import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/services/sale_service.dart';
import '../../../core/widgets/filters/app_filter_bottom_sheet.dart';
import '../../../core/widgets/search/app_search_bar.dart';
import '../../../data/models/sale_model.dart';
import 'mobile/mobile_sale_history_list.dart';
import 'web/web_sale_history_list.dart';

class SaleHistoryScreen extends StatefulWidget {
  const SaleHistoryScreen({super.key});

  @override
  State<SaleHistoryScreen> createState() => _SaleHistoryScreenState();
}

class _SaleHistoryScreenState extends State<SaleHistoryScreen> {
  List<SaleModel> allSales = [];
  List<SaleModel> sales = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSales();
  }

  void loadSales() {
    sales = SaleService().getAllSales();
    allSales = SaleService().getAllSales();
    setState(() {});
  }

  void searchSales(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        sales = List.from(allSales);
      });
      return;
    }

    setState(() {
      sales = allSales.where((sale) {
        return sale.items.any(
              (item) =>
                  item.productName.toLowerCase().contains(value.toLowerCase()),
            ) ||
            sale.invoiceNo.toLowerCase().contains(value.toLowerCase()) ||
            sale.customerName.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }

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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sales History",
              style: TextStyle(
                color: AppColors.black,
                fontSize: AppSizes.font24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              "View all completed sales",
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
        child: Column(
          children: [
            /// Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppSearchBar(
                controller: searchController,
                hintText: "Search by invoice or product...",
                onChanged: searchSales,
                onFilterTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) =>
                        const AppFilterBottomSheet(isSalesFilter: true),
                  );
                },
              ),
            ),

            /// Sales List
            Expanded(
              child: Responsive.isMobile(context)
                  ? MobileSaleHistoryList(
                      sales: sales,
                      onLoadSales: loadSales,
                    )
                  : WebSaleHistoryList(
                      sales: sales,
                      onLoadSales: loadSales,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
