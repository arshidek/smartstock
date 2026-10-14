import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../../function/sale_history_functions.dart';
import '../../../../core/widgets/filters/app_filter_bottom_sheet.dart';
import '../../../../data/models/sale_model.dart';
import 'mobile/mobile_sale_history_screen.dart';
import 'web/web_sale_history_screen.dart';

class SaleHistoryScreen extends StatefulWidget {
  const SaleHistoryScreen({super.key});

  @override
  State<SaleHistoryScreen> createState() => _SaleHistoryScreenState();
}

class _SaleHistoryScreenState extends State<SaleHistoryScreen> {
  List<SaleModel> allSales = [];
  List<SaleModel> sales = [];
  final TextEditingController searchController = TextEditingController();
  Map<String, dynamic>? activeFilters;
  int filterCount = 0;

  @override
  void initState() {
    super.initState();
    loadSales();
  }

  void loadSales() {
    final SaleHistoryFunctions historyFunctions = SaleHistoryFunctions();
    allSales = historyFunctions.loadSales();
    applyFilters();
  }

  void applyFilters() {
    String query = searchController.text.trim();
    List<SaleModel> temp = List.from(allSales);

    if (query.isNotEmpty) {
      temp = temp.where((sale) {
        return sale.items.any(
              (item) =>
                  item.productName.toLowerCase().contains(query.toLowerCase()),
            ) ||
            sale.invoiceNo.toLowerCase().contains(query.toLowerCase()) ||
            sale.customerName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    setState(() {
      sales = temp;
    });
  }

  void searchSales(String value) {
    applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? MobileSaleHistoryScreen(
            searchController: searchController,
            sales: sales,
            filterCount: filterCount,
            searchSales: searchSales,
            loadSales: loadSales,
            onFilterTap: () async {
              final result = await showModalBottomSheet<Map<String, dynamic>>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => AppFilterBottomSheet(
                  isSalesFilter: true,
                  initialFilters: activeFilters,
                ),
              );
              if (result != null) {
                final brands = List<String>.from(result['brands'] ?? []);
                final categories = List<String>.from(
                  result['categories'] ?? [],
                );
                int count = 0;
                if (brands.isNotEmpty) count++;
                if (categories.isNotEmpty) count++;
                if (result['sort'] != null) count++;
                if (result['startDate'] != null || result['endDate'] != null)
                  count++;
                setState(() {
                  activeFilters = result;
                  filterCount = count;
                });
                applyFilters();
              }
            },
          )
        : WebSaleHistoryScreen(
            searchController: searchController,
            sales: sales,
            filterCount: filterCount,
            searchSales: searchSales,
            loadSales: loadSales,
            onFilterTap: () async {
              final result = await showModalBottomSheet<Map<String, dynamic>>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => AppFilterBottomSheet(
                  isSalesFilter: true,
                  initialFilters: activeFilters,
                ),
              );
              if (result != null) {
                final brands = List<String>.from(result['brands'] ?? []);
                final categories = List<String>.from(
                  result['categories'] ?? [],
                );
                int count = 0;
                if (brands.isNotEmpty) count++;
                if (categories.isNotEmpty) count++;
                if (result['sort'] != null) count++;
                if (result['startDate'] != null || result['endDate'] != null)
                  count++;
                setState(() {
                  activeFilters = result;
                  filterCount = count;
                });
                applyFilters();
              }
            },
          );
  }
}
