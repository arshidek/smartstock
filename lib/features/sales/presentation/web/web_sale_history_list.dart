import 'package:flutter/material.dart';
import '../../../../app/app_navigation.dart';
import '../../../../core/services/sale_service.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/dialogs/app_delete_dialog.dart';
import '../../../../data/models/sale_model.dart';
import '../../widgets/AppSaleCard.dart';
import '../sale_details_screen.dart';
import '../update_sale_screen.dart';

class WebSaleHistoryList extends StatelessWidget {
  final List<SaleModel> sales;
  final VoidCallback onLoadSales;

  const WebSaleHistoryList({
    super.key,
    required this.sales,
    required this.onLoadSales,
  });

  @override
  Widget build(BuildContext context) {
    if (sales.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 15),
            Text(
              "No Sales Found",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Try searching with another product or invoice.",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 140,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: sales.length,
      itemBuilder: (context, index) {
        final sale = sales[index];
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
          onTap: () {
            AppNavigation.goToScreen(
              context,
              SaleDetailsScreen(sale: sale),
            );
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
        );
      },
    );
  }
}
