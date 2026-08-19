import 'package:flutter/material.dart';
import 'package:smartstock_inventory/features/sales/presentation/sale_details_screen.dart';
import 'package:smartstock_inventory/features/sales/presentation/sale_history_screen.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/cards/app_card_widget.dart';
import '../../../core/widgets/cards/app_stats_card.dart';
import '../../../data/models/sale_model.dart';
import '../function/sale_functions.dart';
import '../widgets/AppSaleCard.dart';

import '../widgets/today_summary_card.dart';
import 'add_sale_screen.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/bottom_nav/app_bottom_navigation_bar.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final SaleFunctions _saleFunctions = SaleFunctions();
  List<SaleModel> _sales = [];
  Map<String, dynamic> _todaySummary = {};

  @override
  void initState() {
    super.initState();
    _loadSales();
  }

  void _loadSales() {
    setState(() {
      _sales = _saleFunctions.loadSales();
      _todaySummary = _saleFunctions.getTodaySummary(_sales);
    });
  }

  double get totalAmount => _saleFunctions.getTotalAmount(_sales);
  int get totalProductsSold => _saleFunctions.getTotalProductsSold(_sales);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            AppNavigation.goBack(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
            size: AppSizes.size30,
          ),
        ),
        title: Text(
          "Sales",
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.font24,
          ),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.background),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.padding16,
            AppSizes.padding16,
            AppSizes.padding16,
            AppSizes.size100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: Responsive.isMobile(context) ? 1.3 : 1.4,
                children: [
                  AppStatsCard(
                    title: "TOTAL SALES",
                    value: "${_sales.length}",
                    subtitle: "Transactions",
                    icon: Icons.shopping_cart_outlined,
                    iconColor: AppColors.purple,
                    iconBackgroundColor: AppColors.lightPurple,
                  ),

                  AppStatsCard(
                    title: "TOTAL AMOUNT",
                    value: "₹${totalAmount.toStringAsFixed(0)}",
                    subtitle: "Sales Value",
                    icon: Icons.account_balance_wallet_outlined,
                    iconColor: AppColors.success,
                    iconBackgroundColor: AppColors.lightGreen,
                  ),

                  AppStatsCard(
                    title: "PRODUCTS SOLD",
                    value: "$totalProductsSold",
                    subtitle: "Items Sold",
                    icon: Icons.widgets_outlined,
                    iconColor: AppColors.warning,
                    iconBackgroundColor: AppColors.lightWarning,
                  ),

                  AppStatsCard(
                    title: "LATEST SALE",
                    value: _sales.isEmpty
                        ? "--"
                        : _sales.last.items.first.productName,
                    subtitle: _sales.isEmpty
                        ? "No Sales"
                        : _sales.last.invoiceNo,
                    icon: Icons.access_time,
                    iconColor: AppColors.error,
                    iconBackgroundColor: AppColors.lightRed,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Sales",
                    style: TextStyle(
                      fontSize: AppSizes.font22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      AppNavigation.goToScreen(
                        context,
                        const SaleHistoryScreen(),
                      );
                    },
                    child: const Text(
                      "View All",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.size15),

              if (_sales.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 45),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 60,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "No Sales Found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _sales.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final sale = _sales[index];
                    final item = sale.items.first;

                    return AppSaleCard(
                      imagePath: item.imagePath,
                      productName: item.productName,
                      invoiceNo: sale.invoiceNo,
                      brandName: item.brandName,
                      categoryName: item.categoryName,
                      date:
                          "${sale.saleDate.day.toString().padLeft(2, '0')}/"
                          "${sale.saleDate.month.toString().padLeft(2, '0')}/"
                          "${sale.saleDate.year}",
                      paymentMethod: sale.paymentMethod,
                      quantity: item.quantity,
                      amount: "₹${item.totalPrice.toStringAsFixed(2)}",
                      profit: "₹${item.profit.toStringAsFixed(2)}",
                      onTap: () {
                        AppNavigation.goToScreen(
                          context,
                          SaleDetailsScreen(sale: sale),
                        );
                      },
                    );
                  },
                ),

              AppCardWidget(
                margin: const EdgeInsets.only(top: AppSizes.size20),
                backgroundColor: AppColors.lightBlue,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.analytics_outlined,
                          color: Colors.deepPurple,
                          size: 26,
                        ),

                        const SizedBox(width: AppSizes.size10),

                        const Expanded(
                          child: Text(
                            "Today's Summary",
                            style: TextStyle(
                              fontSize: AppSizes.font20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: AppSizes.font13,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSizes.size20),

                    const Divider(),

                    const SizedBox(height: AppSizes.size20),

                    Row(
                      children: [
                        Expanded(
                          child: TodaySummaryCard(
                            title: "TXNS",
                            value: "${_todaySummary["transactions"] ?? 0}",
                            valueColor: AppColors.black,
                          ),
                        ),

                        Expanded(
                          child: TodaySummaryCard(
                            title: "AMOUNT",
                            value:
                                "₹${(_todaySummary["amount"] ?? 0).toStringAsFixed(0)}",
                            valueColor: AppColors.black,
                          ),
                        ),

                        Expanded(
                          child: TodaySummaryCard(
                            title: "QTY",
                            value: "${_todaySummary["quantity"] ?? 0}",
                            valueColor: AppColors.black,
                          ),
                        ),

                        Expanded(
                          child: TodaySummaryCard(
                            title: "PROFIT",
                            value:
                                "₹${(_todaySummary["profit"] ?? 0).toStringAsFixed(0)}",
                            valueColor: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
          "New Sale",
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
