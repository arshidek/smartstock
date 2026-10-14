import 'package:flutter/material.dart';
import '../../../../data/models/sale_item_model.dart';
import '../../widgets/sale_product_card.dart';
import 'add_product_to_sale_screen_state_mixin.dart';
import '../../../../core/responsive/responsive.dart';
import 'mobile/mobile_add_product_to_sale_screen.dart';
import 'web/web_add_product_to_sale_screen.dart';

class AddProductToSaleScreen extends StatefulWidget {
  final List<SaleItemModel> saleItems;

  const AddProductToSaleScreen({super.key, required this.saleItems});

  @override
  State<AddProductToSaleScreen> createState() => _AddProductToSaleScreenState();
}

class _AddProductToSaleScreenState extends State<AddProductToSaleScreen>
    with AddProductToSaleScreenStateMixin {
  Widget _buildProductCard(int index) {
    final product = filteredProducts[index];
    final brand = brands.firstWhere((b) => b.id == product.brandId);
    final category = categories.firstWhere((c) => c.id == product.categoryId);

    return SaleProductCard(
      imagePath: product.imagePath,
      name: product.name,
      productId: product.productId,
      brand: brand.name,
      category: category.name,
      stock: "${product.stock} Units",
      status: product.stock == 0
          ? "Out of Stock"
          : product.stock <= 5
          ? "Low Stock"
          : "In Stock",
      price: "₹${product.sellingPrice}",
      isSelected: selectedProduct?.id == product.id,
      onTap: () {
        setState(() {
          selectedProduct = product;
          ratePerUnit = product.sellingPrice;
          quantity = 0;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = functions.calculateTotalPrice(
      ratePerUnit: ratePerUnit,
      quantity: quantity,
    );

    return Responsive.isMobile(context)
        ? MobileAddProductToSaleScreen(
            selectedBrand: selectedBrand,
            selectedCategory: selectedCategory,
            brands: brands,
            categories: categories,
            onBrandChanged: (value) {
              setState(() {
                selectedBrand = value;
                filterProducts();
              });
            },
            onCategoryChanged: (value) {
              setState(() {
                selectedCategory = value;
                filterProducts();
              });
            },
            filteredProducts: filteredProducts,
            quantity: quantity,
            selectedProduct: selectedProduct,
            totalPrice: totalPrice,
            ratePerUnit: ratePerUnit,
            buildProductCard: _buildProductCard,
            onQuantityChanged: (value) {
              setState(() {
                quantity = value;
              });
            },
            onAddToListPressed: onAddToListPressed,
            searchController: searchController,
            onSearchChanged: (value) {
              setState(() {
                filterProducts();
              });
            },
            filterCount: filterCount,
            activeFilters: activeFilters,
            applyFilters: applyFilters,
          )
        : WebAddProductToSaleScreen(
            selectedBrand: selectedBrand,
            selectedCategory: selectedCategory,
            brands: brands,
            categories: categories,
            onBrandChanged: (value) {
              setState(() {
                selectedBrand = value;
                filterProducts();
              });
            },
            onCategoryChanged: (value) {
              setState(() {
                selectedCategory = value;
                filterProducts();
              });
            },
            filteredProducts: filteredProducts,
            quantity: quantity,
            selectedProduct: selectedProduct,
            totalPrice: totalPrice,
            ratePerUnit: ratePerUnit,
            buildProductCard: _buildProductCard,
            onQuantityChanged: (value) {
              setState(() {
                quantity = value;
              });
            },
            onAddToListPressed: onAddToListPressed,
            searchController: searchController,
            onSearchChanged: (value) {
              setState(() {
                filterProducts();
              });
            },
            filterCount: filterCount,
            activeFilters: activeFilters,
            applyFilters: applyFilters,
          );
  }
}
