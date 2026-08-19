import 'package:flutter/material.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/services/brand_service.dart';
import '../../../core/services/category_service.dart';
import '../../../data/models/product_model.dart';
import '../presentation/product_detail_screen.dart';
import '../../../app/app_navigation.dart';
import 'product_card_list.dart';

/// A widget that displays a list or grid of products depending on the screen size.
class ProductGridList extends StatelessWidget {
  final List<ProductModel> products;
  final BrandService brandService;
  final CategoryService categoryService;
  final VoidCallback onRefresh;

  const ProductGridList({
    super.key,
    required this.products,
    required this.brandService,
    required this.categoryService,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 120),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final brand = brandService.getBrandById(product.brandId);
          final category = categoryService.getCategoryById(product.categoryId);

          return GestureDetector(
            onTap: () async {
              await AppNavigation.goToScreen(
                context,
                ProductDetailScreen(product: product),
              );
              onRefresh();
            },
            child: ProductCardList(
              imagePath: product.imagePath,
              productName: product.name,
              brandName: brand?.name ?? "Unknown",
              categoryName: category?.name ?? "Unknown",
              sellingPrice: product.sellingPrice,
              stock: product.stock,
              stockStatus: product.stockStatus,
              stockColor: product.stockColor,
            ),
          );
        },
      );
    } else {
      return GridView.builder(
        padding: const EdgeInsets.only(
          bottom: 120,
          left: 12,
          right: 12,
          top: 12,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 140, // Adapted for new padding
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final brand = brandService.getBrandById(product.brandId);
          final category = categoryService.getCategoryById(product.categoryId);

          return GestureDetector(
            onTap: () async {
              await AppNavigation.goToScreen(
                context,
                ProductDetailScreen(product: product),
              );
              onRefresh();
            },
            child: ProductCardList(
              imagePath: product.imagePath,
              productName: product.name,
              brandName: brand?.name ?? "Unknown",
              categoryName: category?.name ?? "Unknown",
              sellingPrice: product.sellingPrice,
              stock: product.stock,
              stockStatus: product.stockStatus,
              stockColor: product.stockColor,
            ),
          );
        },
      );
    }
  }
}
