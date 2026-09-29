import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/core/constants/app_colors.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import 'package:smartstock_inventory/core/services/product_service.dart';
import 'package:smartstock_inventory/core/widgets/cards/app_card_widget.dart';
import 'package:smartstock_inventory/data/models/brand_model.dart';
import 'package:smartstock_inventory/data/models/product_model.dart';
import 'package:smartstock_inventory/features/product/presentation/product_detail/product_detail_screen.dart';
import 'package:smartstock_inventory/features/brand/function/brand_functions.dart';
import 'package:smartstock_inventory/features/brand/widgets/brand_summary_cards.dart';
import 'package:smartstock_inventory/features/brand/widgets/brand_description_section.dart';
import 'package:smartstock_inventory/features/brand/widgets/brand_details_app_bar.dart';
import 'package:smartstock_inventory/features/brand/widgets/brand_products_section.dart';

class MobileBrandDetailsScreen extends StatefulWidget {
  final BrandModel brand;
  const MobileBrandDetailsScreen({super.key, required this.brand});

  @override
  State<MobileBrandDetailsScreen> createState() => _MobileBrandDetailsScreenState();
}

class _MobileBrandDetailsScreenState extends State<MobileBrandDetailsScreen> {
  final BrandFunctions _brandFunctions = BrandFunctions();
  final ProductService _productService = ProductService();
  List<ProductModel> _products = [];
  bool _isReadMoreExpanded = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    _products = _productService.getProductsByBrand(widget.brand.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrandDetailsAppBar(
        brand: widget.brand,
        brandFunctions: _brandFunctions,
        onRefresh: () => setState(() => _loadProducts()),
      ),
      body: Container(
        width: double.infinity, height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.background),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.size10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BrandDescriptionSection(
                      brand: widget.brand,
                      isReadMoreExpanded: _isReadMoreExpanded,
                      onReadMore: () => setState(() => _isReadMoreExpanded = !_isReadMoreExpanded),
                    ),
                    const SizedBox(height: AppSizes.size20),
                    BrandSummaryCards(
                      brandName: widget.brand.name,
                      productsCount: _products.length,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.size50),
              BrandProductsSection(
                products: _products,
                onTap: (product) async {
                  final result = await AppNavigation.goToScreen(context, ProductDetailScreen(product: product));
                  if (result == true) setState(() => _loadProducts());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
