import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import 'package:smartstock_inventory/core/services/product_service.dart';
import 'package:smartstock_inventory/core/widgets/cards/app_card_widget.dart';
import 'package:smartstock_inventory/data/models/category_model.dart';
import 'package:smartstock_inventory/data/models/product_model.dart';
import 'package:smartstock_inventory/features/product/presentation/product_detail/product_detail_screen.dart';
import 'package:smartstock_inventory/features/category/function/category_functions.dart';
import 'package:smartstock_inventory/features/category/widgets/category_summary_cards.dart';
import 'package:smartstock_inventory/features/category/widgets/category_details_app_bar.dart';
import 'package:smartstock_inventory/features/category/widgets/category_description_section.dart';
import 'package:smartstock_inventory/features/category/widgets/category_products_section.dart';

class WebCategoryDetailsScreen extends StatefulWidget {
  final CategoryModel category;
  const WebCategoryDetailsScreen({super.key, required this.category});

  @override
  State<WebCategoryDetailsScreen> createState() =>
      _WebCategoryDetailsScreenState();
}

class _WebCategoryDetailsScreenState extends State<WebCategoryDetailsScreen> {
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
        onRefresh: () => setState(() => _loadProducts()),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.background),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.padding25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: AppCardWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryDescriptionSection(
                        category: widget.category,
                        isReadMoreExpanded: _isReadMoreExpanded,
                        onReadMore: () => setState(
                          () => _isReadMoreExpanded = !_isReadMoreExpanded,
                        ),
                      ),
                      const SizedBox(height: AppSizes.size20),
                      CategorySummaryCards(
                        categoryName: widget.category.name,
                        productsCount: _products.length,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.size24),
              Expanded(
                flex: 2,
                child: CategoryProductsSection(
                  products: _products,
                  onTap: (product) async {
                    final result = await AppNavigation.goToScreen(
                      context,
                      ProductDetailScreen(product: product),
                    );
                    if (result == true) setState(() => _loadProducts());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
