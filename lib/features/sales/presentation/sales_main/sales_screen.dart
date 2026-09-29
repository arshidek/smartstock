import 'package:flutter/material.dart';
import '../../../../app/app_navigation.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/responsive/responsive.dart';
import '../../function/sale_history_functions.dart';
import '../../../../core/widgets/bottom_nav/app_bottom_navigation_bar.dart';
import '../../../../data/models/sale_model.dart';
import '../add_sale/add_sale_screen.dart';
import 'mobile/mobile_sales_screen.dart';
import 'web/web_sales_screen.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  List<SaleModel> _sales = [];
  bool _isLoading = true;

  // Stats
  int _totalSales = 0;
  double _totalAmount = 0.0;
  int _totalProductsSold = 0;
  String _latestSaleProduct = "N/A";
  Map<String, dynamic> _todaySummary = {};

  final SaleHistoryFunctions _historyFunctions = SaleHistoryFunctions();

  @override
  void initState() {
    super.initState();
    _loadSales();
  }

  Future<void> _loadSales() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final sales = _historyFunctions.loadSales();
      setState(() {
        _sales = sales;
        _calculateStats();
      });
    } catch (e) {
      debugPrint("Error loading sales: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _calculateStats() {
    _totalSales = _sales.length;
    _totalAmount = _historyFunctions.getTotalAmount(_sales);
    _totalProductsSold = _historyFunctions.getTotalProductsSold(_sales);
    _todaySummary = _historyFunctions.getTodaySummary(_sales);

    if (_sales.isNotEmpty) {
      // Find the most recent sale
      final recentSale = _sales.reduce(
        (a, b) => a.saleDate.isAfter(b.saleDate) ? a : b,
      );
      if (recentSale.items.isNotEmpty) {
        _latestSaleProduct = recentSale.items.first.productName;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background.colors[0],
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Sales Management',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.font24,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.background),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(50),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.blue),
                  ),
                )
              else
                Responsive.isMobile(context)
                    ? MobileSalesScreen(
                        sales: _sales,
                        totalSales: _totalSales,
                        totalAmount: _totalAmount,
                        totalProductsSold: _totalProductsSold,
                        latestSaleProduct: _latestSaleProduct,
                        todaySummary: _todaySummary,
                        onLoadSales: _loadSales,
                      )
                    : WebSalesScreen(
                        sales: _sales,
                        totalSales: _totalSales,
                        totalAmount: _totalAmount,
                        totalProductsSold: _totalProductsSold,
                        latestSaleProduct: _latestSaleProduct,
                        todaySummary: _todaySummary,
                        onLoadSales: _loadSales,
                      ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 1),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
        elevation: 5,
        icon: const Icon(Icons.add),
        label: const Text(
          "Add Sale",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          final result = await AppNavigation.goToScreen(
            context,
            const AddSaleScreen(),
          );

          if (result != null) {
            _loadSales();
          }
        },
      ),
    );
  }
}
