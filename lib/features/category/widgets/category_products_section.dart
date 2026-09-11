import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/cards/app_card_list.dart';
import '../../../core/responsive/responsive.dart';
import '../../../data/models/product_model.dart';

class CategoryProductsSection extends StatelessWidget {
  final List<ProductModel> products;
  final Function(ProductModel)? onTap;

  const CategoryProductsSection({
    super.key,
    required this.products,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              Icon(
                Icons.widgets_outlined,
                size: AppSizes.size60,
                color: AppColors.grey,
              ),
              SizedBox(height: AppSizes.size15),
              Text(
                "No Products Yet",
                style: TextStyle(
                  fontSize: AppSizes.font20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppSizes.size5),
              Text(
                "This category doesn't contain any products.",
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: AppSizes.font16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding16),
      child: !Responsive.isMobile(context)
          ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSizes.padding16,
                mainAxisExtent: 180,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return AppCardList(
                  imagePath: product.imagePath,
                  name: product.name,
                  subtitle: "Stock : ${product.stock}",
                  totalValue: "₹${product.sellingPrice}",
                  onTap: () {
                    if (onTap != null) {
                      onTap!(product);
                    }
                  },
                );
              },
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return AppCardList(
                  imagePath: product.imagePath,
                  name: product.name,
                  subtitle: "Stock : ${product.stock}",
                  totalValue: "₹${product.sellingPrice}",
                  onTap: () {
                    if (onTap != null) {
                      onTap!(product);
                    }
                  },
                );
              },
            ),
    );
  }
}
