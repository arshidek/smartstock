import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/product_service.dart';
import '../../../core/widgets/cards/app_card_widget.dart';
import '../../../data/models/brand_model.dart';
import '../../../data/models/product_model.dart';
import '../widgets/brand_summary_cards.dart';
import '../../product/presentation/product_detail_screen.dart';
import '../function/brand_functions.dart';
import '../widgets/brand_description_section.dart';
import '../widgets/brand_details_app_bar.dart';
import '../widgets/brand_products_section.dart';

class BrandDetailsScreen extends StatefulWidget {
  final BrandModel brand;

  const BrandDetailsScreen({super.key, required this.brand});

  @override
  State<BrandDetailsScreen> createState() => _BrandDetailsScreenState();
}

class _BrandDetailsScreenState extends State<BrandDetailsScreen> {
  final BrandFunctions _brandFunctions = BrandFunctions();
  final ProductService _productService = ProductService();

  List<ProductModel> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    _products = _productService.getProductsByBrand(widget.brand.id);

    setState(() {});
  }

  bool _isReadMoreExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrandDetailsAppBar(
        brand: widget.brand,
        brandFunctions: _brandFunctions,
        onRefresh: () {
          setState(() {});
          _loadProducts();
        },
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: AppColors.background),

        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.size10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description Card
              AppCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BrandDescriptionSection(
                      brand: widget.brand,
                      isReadMoreExpanded: _isReadMoreExpanded,
                      onReadMore: () {
                        setState(() {
                          _isReadMoreExpanded = !_isReadMoreExpanded;
                        });
                      },
                    ),

                    const SizedBox(height: AppSizes.size20),

                    // Extracted brand summary cards to reduce lines
                    BrandSummaryCards(
                      brandName: widget.brand.name,
                      productsCount: _products.length,
                    ),
                  ],
                ),
              ),

              // Products
              const SizedBox(height: AppSizes.size50),

              BrandProductsSection(
                products: _products,
                onTap: (product) async {
                  final result = await AppNavigation.goToScreen(
                    context,
                    ProductDetailScreen(product: product),
                  );

                  // Reload products if the product was edited or deleted
                  if (result == true) {
                    _loadProducts();
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
