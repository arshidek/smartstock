import 'package:flutter/material.dart';
import '../../../../../app/app_navigation.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/widgets/search/app_search_bar.dart';
import '../../../../../data/models/sale_model.dart';
import 'mobile_sale_history_list.dart';

class MobileSaleHistoryScreen extends StatelessWidget {
  final TextEditingController searchController;
  final List<SaleModel> sales;
  final int filterCount;
  final VoidCallback onFilterTap;
  final Function(String) searchSales;
  final VoidCallback loadSales;

  const MobileSaleHistoryScreen({
    super.key,
    required this.searchController,
    required this.sales,
    required this.filterCount,
    required this.onFilterTap,
    required this.searchSales,
    required this.loadSales,
  });

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
              "Sales History",
              style: TextStyle(
                color: AppColors.black,
                fontSize: AppSizes.font24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Text(
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
            Padding(
              padding: const EdgeInsets.all(AppSizes.font16),
              child: AppSearchBar(
                controller: searchController,
                hintText: "Search by invoice or product...",
                onChanged: searchSales,
                showFilter: true,
                filterCount: filterCount,
                onFilterTap: onFilterTap,
              ),
            ),
            if (filterCount > 0)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding16,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$filterCount Filter${filterCount > 1 ? 's' : ''} Applied',
                    style: const TextStyle(
                      color: AppColors.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: AppSizes.font13,
                    ),
                  ),
                ),
              ),
            Expanded(
              child: MobileSaleHistoryList(
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
