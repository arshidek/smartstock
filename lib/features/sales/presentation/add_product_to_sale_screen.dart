import 'package:flutter/material.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/buttons/app_outline_button.dart';
import '../../../core/widgets/cards/app_card_widget.dart';
import '../../../core/widgets/dropdowns/app_custom_dropdown.dart';
import '../../../data/models/brand_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/sale_item_model.dart';
import '../function/add_product_to_sale_functions.dart';
import '../widgets/sale_product_card.dart';

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
  int minimumStock = 5;
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

    filteredProducts = functions.filterProducts(
      products: products,
      selectedBrand: selectedBrand,
      selectedCategory: selectedCategory,
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
            fontSize: AppSizes.size25,
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

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding16,
                  vertical: AppSizes.size10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AppCustomDropdown.dropdown<BrandModel>(
                        label: "Brand *",
                        icon: Icons.workspace_premium_outlined,
                        value: selectedBrand,
                        items: brands.map((brand) {
                          return DropdownMenuItem<BrandModel>(
                            value: brand,
                            child: Text(brand.name),
                          );
                        }).toList(),
                        onChanged: (BrandModel? value) {
                          setState(() {
                            selectedBrand = value;
                            filteredProducts = functions.filterProducts(
                              products: products,
                              selectedBrand: selectedBrand,
                              selectedCategory: selectedCategory,
                            );

                            setState(() {});
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: AppSizes.size12),

                    Expanded(
                      child: AppCustomDropdown.dropdown<CategoryModel>(
                        label: "Category *",
                        icon: Icons.local_offer_outlined,
                        value: selectedCategory,
                        items: categories.map((category) {
                          return DropdownMenuItem<CategoryModel>(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(),
                        onChanged: (CategoryModel? value) {
                          setState(() {
                            selectedCategory = value;
                            filteredProducts = functions.filterProducts(
                              products: products,
                              selectedBrand: selectedBrand,
                              selectedCategory: selectedCategory,
                            );

                            setState(() {});
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Product Selection
              const SizedBox(height: 20),

              const Text(
                "Products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),
              filteredProducts.isEmpty
                  ? Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadius16,
                        ),
                        border: Border.all(color: AppColors.lightGrey),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.widgets_outlined,
                            size: 60,
                            color: AppColors.grey,
                          ),
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
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];

                        final brand = brands.firstWhere(
                          (b) => b.id == product.brandId,
                        );

                        final category = categories.firstWhere(
                          (c) => c.id == product.categoryId,
                        );

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
                      },
                    ),

              // Quantity
              AppCardWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quantity
                    const Text.rich(
                      TextSpan(
                        text: 'Quantity ',
                        children: [
                          TextSpan(
                            text: "*",
                            style: TextStyle(color: AppColors.error),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: AppSizes.font18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: AppColors.blue,
                            size: AppSizes.size32,
                          ),
                        ),

                        const SizedBox(width: AppSizes.size15),

                        Container(
                          width: AppSizes.size100,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.size15,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadius12,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "$quantity",
                                style: const TextStyle(
                                  fontSize: AppSizes.font30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Units",
                                style: TextStyle(fontSize: AppSizes.font16),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: AppSizes.size15),

                        IconButton(
                          onPressed: () {
                            if (selectedProduct == null) return;

                            int maxSaleQuantity =
                                selectedProduct!.stock - minimumStock;

                            if (maxSaleQuantity <= 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "This product must keep at least 5 units in stock.",
                                  ),
                                ),
                              );
                              return;
                            }

                            if (quantity < maxSaleQuantity) {
                              setState(() {
                                quantity++;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Only $maxSaleQuantity units can be sold.",
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: AppColors.blue,
                            size: AppSizes.size32,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.size20),

                    Text(
                      selectedProduct == null
                          ? "Available: 0 units"
                          : "Available: ${selectedProduct!.stock} units",
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Quick Add
                    const Text(
                      'Quick Add',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: AppSizes.size10,
                      runSpacing: AppSizes.size10,
                      children: [1, 5, 10, 25].map((q) {
                        return AppOutlineButton(
                          text: "$q",
                          icon: Icons.add,
                          width: AppSizes.size60,
                          height: AppSizes.size40,
                          fontSize: AppSizes.font18,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (selectedProduct == null) return;

                            int maxSaleQuantity = functions.getMaxSaleQuantity(
                              product: selectedProduct!,
                              minimumStock: minimumStock,
                            );

                            if (maxSaleQuantity <= 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "This product must keep at least 5 units in stock.",
                                  ),
                                ),
                              );
                              return;
                            }

                            setState(() {
                              if (quantity + q <= maxSaleQuantity) {
                                quantity += q;
                              } else {
                                quantity = maxSaleQuantity;
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Rate Per Unit
                    Divider(),

                    Row(
                      children: [
                        /// Total Price
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

                              const SizedBox(height: 8),

                              Text(
                                "₹${totalPrice.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.success,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "$quantity × ₹${ratePerUnit.toStringAsFixed(2)}",
                                style: const TextStyle(color: AppColors.grey),
                              ),
                            ],
                          ),
                        ),

                        /// Rate Per Unit
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Rate Per Unit",
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "₹${ratePerUnit.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.success,
                                ),
                              ),

                              const SizedBox(height: 4),

                              const Text(
                                "Auto Filled",
                                style: TextStyle(color: AppColors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Stock Alert
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.amber),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        selectedProduct == null
                            ? "Please select a product."
                            : "Stock Alert\nYou can sell only ${selectedProduct!.stock - minimumStock} units.\n($minimumStock units will remain in stock.)",
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Add to List Button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding16,
                  vertical: AppSizes.size10,
                ),
                child: AppButton(
                  text: "Add to List",
                  icon: Icons.add_shopping_cart,
                  backgroundColor: const Color(0xFF4A2BFF),
                  textColor: Colors.white,
                  iconColor: Colors.white,

                  onPressed: () {
                    // Check product selected
                    if (selectedProduct == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a product."),
                          backgroundColor: Colors.orange,
                        ),
                      );
                      return;
                    }

                    // Check stock
                    if (selectedProduct!.stock <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${selectedProduct!.name} is Out of Stock.",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Find if product already exists in sale list
                    final index = saleItems.indexWhere(
                      (item) => item.productId == selectedProduct!.productId,
                    );

                    // Product already exists
                    if (index != -1) {
                      // Check stock limit
                      if (saleItems[index].quantity + quantity >
                          selectedProduct!.stock) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Only ${selectedProduct!.stock} items available.",
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      saleItems[index].quantity += quantity;
                    }
                    // Product not in list
                    else {
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
                              (selectedProduct!.sellingPrice -
                                  selectedProduct!.purchasePrice) *
                              quantity,
                        ),
                      );
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${selectedProduct!.name} added to sale.",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );

                    AppNavigation.goBackWithResult(context, saleItems);
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
