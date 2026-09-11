import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/app_snack_bar.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../data/models/brand_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/sale_item_model.dart';
import '../function/add_product_to_sale_functions.dart';
import '../widgets/sale_product_card.dart';
import 'widgets/product_filter_dropdowns.dart';
import 'widgets/product_list_grid.dart';
import 'widgets/product_quantity_selector.dart';

class AddProductToSaleScreen extends StatefulWidget {
  final List<SaleItemModel> saleItems;

  const AddProductToSaleScreen({super.key, required this.saleItems});

  @override
  State<AddProductToSaleScreen> createState() => _AddProductToSaleScreenState();
}

class _AddProductToSaleScreenState extends State<AddProductToSaleScreen> {
  List<BrandModel> brands = [];
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  List<SaleItemModel> saleItems = [];

  final AddProductToSaleFunctions functions = AddProductToSaleFunctions();

  BrandModel? selectedBrand;
  CategoryModel? selectedCategory;
  ProductModel? selectedProduct;
  int quantity = 1;
  double ratePerUnit = 0;

  @override
  void initState() {
    super.initState();
    saleItems = List.from(widget.saleItems);

    brands = functions.loadBrands();
    categories = functions.loadCategories();
    products = functions.loadProducts();

    if (brands.isNotEmpty) {
      selectedBrand = brands.first;
    }

    if (categories.isNotEmpty) {
      selectedCategory = categories.first;
    }

    _filterProducts();
  }

  void _filterProducts() {
    filteredProducts = functions.filterProducts(
      products: products,
      selectedBrand: selectedBrand,
      selectedCategory: selectedCategory,
    );
  }

  void _onAddToListPressed() {
    if (selectedProduct == null) {
      AppSnackBar.warning(context, "Please select a product.");
      return;
    }
    if (selectedProduct!.stock <= 0) {
      AppSnackBar.warning(context, "${selectedProduct!.name} is Out of Stock.");
      return;
    }

    final index = saleItems.indexWhere(
      (item) => item.productId == selectedProduct!.productId,
    );

    if (index != -1) {
      if (saleItems[index].quantity + quantity > selectedProduct!.stock) {
        AppSnackBar.warning(
          context,
          "Only ${selectedProduct!.stock} items available.",
        );
        return;
      }
      saleItems[index].quantity += quantity;
    } else {
      saleItems.add(
        SaleItemModel(
          productId: selectedProduct!.productId,
          productName: selectedProduct!.name,
          brandName: selectedBrand!.name,
          categoryName: selectedCategory!.name,
          imagePath: selectedProduct!.imagePath,
          purchasePrice: selectedProduct!.purchasePrice,
          sellingPrice: selectedProduct!.sellingPrice,
          quantity: quantity,
          totalPrice: selectedProduct!.sellingPrice * quantity,
          profit:
              (selectedProduct!.sellingPrice - selectedProduct!.purchasePrice) *
              quantity,
        ),
      );
    }

    AppSnackBar.success(context, "${selectedProduct!.name} added to sale.");
    AppNavigation.goBackWithResult(context, saleItems);
  }

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
          quantity = 1;
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: const Text(
          'Add Product ',
          style: TextStyle(
            fontSize: AppSizes.font24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
            size: AppSizes.size30,
          ),
          onPressed: () => AppNavigation.goBack(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.background),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.size10),
              ProductFilterDropdowns(
                selectedBrand: selectedBrand,
                selectedCategory: selectedCategory,
                brands: brands,
                categories: categories,
                onBrandChanged: (value) {
                  setState(() {
                    selectedBrand = value;
                    _filterProducts();
                  });
                },
                onCategoryChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                    _filterProducts();
                  });
                },
              ),
              const SizedBox(height: AppSizes.size20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.padding16),
                child: Text(
                  "Products",
                  style: TextStyle(
                    fontSize: AppSizes.font18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.size10),
              ProductListGrid(
                filteredProducts: filteredProducts,
                buildProductCard: _buildProductCard,
              ),
              ProductQuantitySelector(
                quantity: quantity,
                selectedProduct: selectedProduct,
                onQuantityChanged: (value) {
                  setState(() {
                    quantity = value;
                  });
                },
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding16,
                  vertical: AppSizes.padding10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Price",
                            style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: AppSizes.size8),
                          Text(
                            "₹${totalPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: AppSizes.font26,
                              fontWeight: FontWeight.bold,
                              color: AppColors.success,
                            ),
                          ),
                          const SizedBox(height: AppSizes.size5),
                          Text(
                            "$quantity × ₹${ratePerUnit.toStringAsFixed(2)}",
                            style: const TextStyle(color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSizes.size20),
                    kIsWeb
                        ? SizedBox(
                            width: 180,
                            child: AppButton(
                              text: "Add to List",
                              icon: Icons.add_circle,
                              backgroundColor: AppColors.blue,
                              textColor: AppColors.white,
                              iconColor: AppColors.white,
                              onPressed: _onAddToListPressed,
                            ),
                          )
                        : Expanded(
                            child: AppButton(
                              text: "Add to List",
                              icon: Icons.add_circle,
                              backgroundColor: AppColors.blue,
                              textColor: AppColors.white,
                              iconColor: AppColors.white,
                              onPressed: _onAddToListPressed,
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.size25),
            ],
          ),
        ),
      ),
    );
  }
}
