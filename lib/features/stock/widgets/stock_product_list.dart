import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../app/app_navigation.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/services/brand_service.dart';
import '../../../core/services/category_service.dart';
import '../../../data/models/product_model.dart';
import '../../product/presentation/product_detail/product_detail_screen.dart';
import '../presentation/update_stock_screen/update_stock_screen.dart';
import 'stock_management_card.dart';

class StockProductList extends StatelessWidget {
  final List<ProductModel> products;
  final VoidCallback loadProducts;

  const StockProductList({
    super.key,
    required this.products,
    required this.loadProducts,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Text(
          "No Products Found",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget buildItem(BuildContext context, int index) {
      final product = products[index];
      final brand = BrandService().getBrandById(product.brandId);
      final category = CategoryService().getCategoryById(product.categoryId);

      return StockManagementCard(
        product: product,
        brandName: brand?.name ?? "",
        categoryName: category?.name ?? "",
        onTap: () {
          AppNavigation.goToScreen(
            context,
            ProductDetailScreen(product: product),
          );
        },
        onRestock: () async {
          final result = await AppNavigation.goToScreen(
            context,
            UpdateStockScreen(product: product),
          );

          if (result == true) {
            loadProducts();
          }
        },
      );
    }

    return Responsive.isMobile(context)
        ? ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding16),
            itemCount: products.length,
            itemBuilder: buildItem,
          )
        : GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisExtent: 155,
            ),
            itemCount: products.length,
            itemBuilder: buildItem,
          );
  }
}
