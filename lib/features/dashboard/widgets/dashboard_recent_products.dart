import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/category_model.dart';
import '../../../core/services/brand_service.dart';
import '../../product/presentation/product_list_screen.dart';
import '../../product/presentation/product_detail_screen.dart';
import '../../product/widgets/product_card_list.dart';

class DashboardRecentProducts extends StatelessWidget {
  final List<ProductModel> topRecent;
  final List<CategoryModel> categories;
  final BrandService brandService;

  const DashboardRecentProducts({
    super.key,
    required this.topRecent,
    required this.categories,
    required this.brandService,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recently Added Products",
              style: TextStyle(
                fontSize: AppSizes.font15,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (topRecent.isNotEmpty)
              InkWell(
                onTap: () {
                  AppNavigation.goToScreen(context, const ProductListScreen());
                },
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSizes.size16),

        if (topRecent.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: AppSizes.size45),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius18),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.widgets_outlined,
                  size: AppSizes.size60,
                  color: AppColors.blue,
                ),
                SizedBox(height: AppSizes.size12),
                Text(
                  "No Products Found",
                  style: TextStyle(
                    fontSize: AppSizes.font18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        else
          Builder(
            builder: (context) {
              final isWide = MediaQuery.of(context).size.width > 600;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWide ? 2 : 1,
                  crossAxisSpacing: AppSizes.size12,
                  mainAxisSpacing: AppSizes.size12,
                  mainAxisExtent: AppSizes.size110,
                ),
                itemCount: topRecent.length,
                itemBuilder: (context, index) {
                  final p = topRecent[index];
                  final cat = categories.firstWhere(
                    (c) => c.id == p.categoryId,
                    orElse: () => categories.first,
                  );
                  final brand = brandService.getBrandById(p.brandId);

                  return ProductCardList(
                    productName: p.name,
                    productId: p.productId,
                    brandName: brand?.name ?? 'Unknown Brand',
                    categoryName: cat.name,
                    sellingPrice: p.sellingPrice,
                    stock: p.stock,
                    stockStatus: p.stockStatus,
                    stockColor: p.stockColor,
                    imagePath: p.allImages.isNotEmpty ? p.allImages.first : null,
                    margin: EdgeInsets.zero,
                    onTap: () {
                      AppNavigation.goToScreen(
                        context,
                        ProductDetailScreen(product: p),
                      );
                    },
                  );
                },
              );
            },
          ),
      ],
    );
  }
}
