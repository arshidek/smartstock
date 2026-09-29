import '../../../core/services/sale_service.dart';
import '../../../data/models/sale_model.dart';

class SaleHistoryFunctions {
  final SaleService _saleService = SaleService();

  List<SaleModel> loadSales() {
    final sales = _saleService.getAllSales();
    sales.sort((a, b) => b.saleDate.compareTo(a.saleDate));
    return sales;
  }

  double getTotalAmount(List<SaleModel> sales) {
    return sales.fold(0, (sum, sale) => sum + sale.grandTotal);
  }

  int getTotalProductsSold(List<SaleModel> sales) {
    return sales.fold(0, (sum, sale) => sum + sale.totalQuantity);
  }

  Map<String, dynamic> getTodaySummary(List<SaleModel> sales) {
    int transactions = 0;
    double amount = 0;
    int quantity = 0;
    double profit = 0;

    final today = DateTime.now();

    for (final sale in sales) {
      if (sale.saleDate.year == today.year &&
          sale.saleDate.month == today.month &&
          sale.saleDate.day == today.day) {
        transactions++;
        amount += sale.grandTotal;
        quantity += sale.totalQuantity;
        profit += sale.totalProfit;
      }
    }

    return {
      "transactions": transactions,
      "amount": amount,
      "quantity": quantity,
      "profit": profit,
    };
  }
}
