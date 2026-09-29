import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/product_service.dart';
import '../../../core/widgets/cards/app_card_list.dart';
import '../../../data/models/category_model.dart';
import '../presentation/category_details/category_details_screen.dart';

class CategoryListView extends StatelessWidget {
  final List<CategoryModel> categories;
  final bool isTabletOrWeb;
  final ProductService productService;

  const CategoryListView({
    super.key,
    required this.categories,
    required this.isTabletOrWeb,
    required this.productService,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Center(child: Text("No Category Found"));
    }

    if (isTabletOrWeb) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSizes.padding16,
          mainAxisExtent: 180,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () async {
              await AppNavigation.goToScreen(
                context,
                CategoryDetailsScreen(category: category),
              );
            },
            child: AppCardList(
              imagePath: category.imagePath,
              name: category.name,
              subtitle:
                  "${productService.getCategoryProductCount(category.id)} Products",
              totalValue:
                  "₹${productService.getCategoryTotalValue(category.id).toStringAsFixed(2)}",
            ),
          );
        },
      );
    }

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        return GestureDetector(
          onTap: () async {
            await AppNavigation.goToScreen(
              context,
              CategoryDetailsScreen(category: category),
            );
          },
          child: AppCardList(
            imagePath: category.imagePath,
            name: category.name,
            subtitle:
                "${productService.getCategoryProductCount(category.id)} Products",
            totalValue:
                "₹${productService.getCategoryTotalValue(category.id).toStringAsFixed(2)}",
          ),
        );
      },
    );
  }
}
