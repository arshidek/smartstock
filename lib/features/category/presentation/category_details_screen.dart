import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/product_service.dart';
import '../../../core/widgets/cards/app_card_widget.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';
import '../widgets/category_summary_cards.dart';
import '../../product/presentation/product_detail_screen.dart';
import '../function/category_functions.dart';
import '../widgets/category_details_app_bar.dart';
import '../widgets/category_description_section.dart';
import '../widgets/category_products_section.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryDetailsScreen({super.key, required this.category});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  final CategoryFunctions _categoryFunctions = CategoryFunctions();

  final ProductService _productService = ProductService();

  List<ProductModel> _products = [];

  bool _isReadMoreExpanded = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    _products = _productService.getProductsByCategory(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CategoryDetailsAppBar(
        category: widget.category,
        categoryFunctions: _categoryFunctions,
        onRefresh: () {
          setState(() {
            _loadProducts();
          });
        },
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.background),

        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.size10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoryDescriptionSection(
                      category: widget.category,
                      isReadMoreExpanded: _isReadMoreExpanded,
                      onReadMore: () {
                        setState(() {
                          _isReadMoreExpanded = !_isReadMoreExpanded;
                        });
                      },
                    ),

                    const SizedBox(height: AppSizes.size20),

                    // Extracted category summary cards to reduce lines
                    CategorySummaryCards(
                      categoryName: widget.category.name,
                      productsCount: _products.length,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSizes.size50),

              CategoryProductsSection(
                products: _products,
                onTap: (product) async {
                  final result = await AppNavigation.goToScreen(
                    context,
                    ProductDetailScreen(product: product),
                  );

                  if (result == true) {
                    setState(() {
                      _loadProducts();
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
