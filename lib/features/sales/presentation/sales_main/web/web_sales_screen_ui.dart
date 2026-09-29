part of 'web_sales_screen.dart';

extension WebSalesScreenUI on WebSalesScreen {
  Widget _buildRecentSales(BuildContext context) {
    if (sales.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 45),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius18),
        ),
        child: const Column(
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: AppSizes.size60,
              color: AppColors.grey,
            ),
            SizedBox(height: AppSizes.size12),
            Text(
              "No Sales Found",
              style: TextStyle(
                fontSize: AppSizes.size18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    final recentSales = sales.take(5).toList();

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 140,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: recentSales.length,
      itemBuilder: (context, index) {
        final sale = recentSales[index];
        if (sale.items.isEmpty) return const SizedBox.shrink();
        final item = sale.items.first;

        return AppSaleCard(
          imagePath: item.imagePath,
          productName: item.productName,
          invoiceNo: sale.invoiceNo,
          brandName: item.brandName,
          categoryName: item.categoryName,
          date:
              "${sale.saleDate.day} ${['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][sale.saleDate.month - 1]} ${sale.saleDate.year}",
          paymentMethod: sale.paymentMethod,
          quantity: item.quantity,
          amount: "₹${item.totalPrice.toStringAsFixed(2)}",
          profit: "₹${item.profit.toStringAsFixed(2)}",
          showMenu: true,
          onUpdate: () async {
            final result = await AppNavigation.goToScreen(
              context,
              UpdateSaleScreen(sale: sale),
            );
            if (result == true) {
              onLoadSales();
            }
          },
          onDelete: () async {
            final confirm = await AppDeleteDialog.show(
              context: context,
              title: "Delete Sale",
              message: "Are you sure you want to delete this sale?",
            );

            if (confirm == true) {
              await SaleService().deleteSale(sale.id);
              onLoadSales();
              AppSnackBar.success(context, "Sale deleted successfully.");
            }
          },
          onTap: () {
            AppNavigation.goToScreen(context, SaleDetailsScreen(sale: sale));
          },
        );
      },
    );
  }

  Widget _buildTodaySummary() {
    return AppCardWidget(
      margin: const EdgeInsets.only(top: 14, bottom: 80),
      backgroundColor: AppColors.lightBlue,
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.analytics_outlined,
                color: AppColors.purple,
                size: AppSizes.size25,
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
                "${DateTime.now().day} ${['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][DateTime.now().month - 1]} ${DateTime.now().year}",
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
                  value: "${todaySummary["transactions"] ?? 0}",
                  valueColor: AppColors.black,
                ),
              ),
              Expanded(
                child: TodaySummaryCard(
                  title: "AMOUNT",
                  value: "₹${(todaySummary["amount"] ?? 0).toStringAsFixed(0)}",
                  valueColor: AppColors.black,
                ),
              ),
              Expanded(
                child: TodaySummaryCard(
                  title: "QTY",
                  value: "${todaySummary["quantity"] ?? 0}",
                  valueColor: AppColors.black,
                ),
              ),
              Expanded(
                child: TodaySummaryCard(
                  title: "PROFIT",
                  value: "₹${(todaySummary["profit"] ?? 0).toStringAsFixed(0)}",
                  valueColor: AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
