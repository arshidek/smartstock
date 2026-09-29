import '../../../core/services/product_service.dart';
import '../../../core/services/sale_service.dart';
import '../../../data/models/product_model.dart';

class ProductAgg {
  String name;
  String category;
  String imagePath;
  String productId;
  int quantity;
  double revenue;

  ProductAgg(
    this.name,
    this.category,
    this.imagePath,
    this.productId,
    this.quantity,
    this.revenue,
  );
}

class TopSellingReportData {
  final ProductAgg agg;
  final ProductModel? productModel;
  final double percentage;

  TopSellingReportData(this.agg, this.productModel, this.percentage);
}

class TopSellingReportFunctions {
  final ProductService _productService = ProductService();
  final SaleService _saleService = SaleService();

  List<TopSellingReportData> getTopSellingProducts({DateTime? selectedDate}) {
    final sales = _saleService.getAllSales();
    final now = selectedDate ?? DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    double totalRevenue = 0;
    Map<String, ProductAgg> productSales = {};

    for (var sale in sales) {
      if ((sale.saleDate.isAfter(thirtyDaysAgo) ||
              sale.saleDate.isAtSameMomentAs(thirtyDaysAgo)) &&
          (sale.saleDate.isBefore(now) ||
              sale.saleDate.isAtSameMomentAs(now))) {
        for (var item in sale.items) {
          totalRevenue += item.totalPrice;

          if (productSales.containsKey(item.productId)) {
            productSales[item.productId]!.quantity += item.quantity;
            productSales[item.productId]!.revenue += item.totalPrice;
          } else {
            productSales[item.productId] = ProductAgg(
              item.productName,
              item.categoryName,
              item.imagePath,
              item.productId,
              item.quantity,
              item.totalPrice,
            );
          }
        }
      }
    }

    List<ProductAgg> sortedProducts = productSales.values.toList();
    sortedProducts.sort((a, b) => b.revenue.compareTo(a.revenue));
    sortedProducts = sortedProducts.take(5).toList();

    return sortedProducts.map((p) {
      double pct = totalRevenue == 0 ? 0 : (p.revenue / totalRevenue) * 100;
      final model = _productService.getProductByProductId(p.productId);
      return TopSellingReportData(p, model, pct);
    }).toList();
  }
}
