import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/widgets/cards/app_card_widget.dart';
import '../../../../data/models/product_model.dart';

class ProductListGrid extends StatelessWidget {
  final List<ProductModel> filteredProducts;
  final Widget Function(int index) buildProductCard;

  const ProductListGrid({
    super.key,
    required this.filteredProducts,
    required this.buildProductCard,
  });

  @override
  Widget build(BuildContext context) {
    if (filteredProducts.isEmpty) {
      return AppCardWidget(
        margin: const EdgeInsets.symmetric(horizontal: AppSizes.padding16),
        child: const SizedBox(
          height: 180,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.widgets_outlined, size: 60, color: AppColors.grey),
              SizedBox(height: 12),
              Text(
                "No Products Found",
                style: TextStyle(
                  fontSize: AppSizes.font18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Select another Brand or Category",
                style: TextStyle(color: AppColors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Responsive.isMobile(context)
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) => buildProductCard(index),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 150,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) => buildProductCard(index),
          );
  }
}
