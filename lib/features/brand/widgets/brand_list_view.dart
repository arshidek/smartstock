import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/product_service.dart';
import '../../../core/widgets/cards/app_card_list.dart';
import '../../../data/models/brand_model.dart';
import '../presentation/brand_details_screen.dart';

class BrandListView extends StatelessWidget {
  final List<BrandModel> brands;
  final bool isTabletOrWeb;
  final ProductService productService;

  const BrandListView({
    super.key,
    required this.brands,
    required this.isTabletOrWeb,
    required this.productService,
  });

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) {
      return const Center(child: Text("No Brand Found"));
    }

    if (isTabletOrWeb) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSizes.padding16,
          mainAxisExtent: 180,
        ),
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          return GestureDetector(
            onTap: () async {
              await AppNavigation.goToScreen(
                context,
                BrandDetailsScreen(brand: brand),
              );
            },
            child: AppCardList(
              imagePath: brand.imagePath,
              name: brand.name,
              subtitle:
                  "${productService.getBrandProductCount(brand.id)} Products",
              totalValue:
                  "₹${productService.getBrandTotalValue(brand.id).toStringAsFixed(2)}",
            ),
          );
        },
      );
    }

    return ListView.builder(
      itemCount: brands.length,
      itemBuilder: (context, index) {
        final brand = brands[index];

        return GestureDetector(
          onTap: () async {
            await AppNavigation.goToScreen(
              context,
              BrandDetailsScreen(brand: brand),
            );
          },
          child: AppCardList(
            imagePath: brand.imagePath,
            name: brand.name,
            subtitle:
                "${productService.getBrandProductCount(brand.id)} Products",
            totalValue:
                "₹${productService.getBrandTotalValue(brand.id).toStringAsFixed(2)}",
          ),
        );
      },
    );
  }
}
