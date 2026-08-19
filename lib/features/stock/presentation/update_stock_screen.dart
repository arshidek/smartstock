import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/features/stock/functions/%20stock_functions.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/services/brand_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/cards/app_card_widget.dart';
import '../../../data/models/brand_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';
import '../widgets/note_card.dart';
import '../widgets/product_header_card.dart';
import '../widgets/stock_update_card.dart';

class UpdateStockScreen extends StatefulWidget {
  final ProductModel product;
  const UpdateStockScreen({super.key, required this.product});

  @override
  State<UpdateStockScreen> createState() => _UpdateStockScreenState();
}

class _UpdateStockScreenState extends State<UpdateStockScreen> {
  final BrandService _brandService = BrandService();
  final CategoryService _categoryService = CategoryService();
  final StockFunction _stockFunction = StockFunction();

  CategoryModel? _category;
  BrandModel? _brand;

  bool isAddStock = true;
  int quantity = 5;
  int newStock = 0;

  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newStock = widget.product.stock;
    _brand = _brandService.getBrandById(widget.product.brandId);
    _category = _categoryService.getCategoryById(widget.product.categoryId);
  }

  void _updatePreview() {
    _stockFunction.updatePreview(
      isAddStock: isAddStock,
      currentStock: widget.product.stock,
      quantity: quantity,
      onChanged: (value) {
        setState(() {
          newStock = value;
        });
      },
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black, size: 30),
          onPressed: () => AppNavigation.goBack(context),
        ),
        title: const Text(
          'Update Stock',
          style: TextStyle(
            color: AppColors.black,
            fontSize: AppSizes.font24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.background),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Header
              AppCardWidget(
                child: Column(
                  children: [
                    ProductHeaderCard(
                      product: widget.product,
                      brand: _brand,
                      category: _category,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.size25),

              StockUpdateCard(
                isAddStock: isAddStock,
                quantity: quantity,
                onActionChanged: (value) {
                  setState(() {
                    isAddStock = value;
                  });
                  _updatePreview();
                },
                onQuantityChanged: (value) {
                  setState(() {
                    quantity = value;
                  });
                  _updatePreview();
                },
              ),

              SizedBox(height: AppSizes.size20),

              NoteCard(controller: _noteController),

              const SizedBox(height: AppSizes.size15),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.padding16,
                  vertical: AppSizes.size10,
                ),
                child: AppButton(
                  text: "Update Stock",
                  icon: Icons.inventory,
                  backgroundColor: AppColors.blue,
                  textColor: AppColors.white,
                  iconColor: AppColors.white,
                  onPressed: () async {
                    await _stockFunction.updateStock(
                      context: context,
                      product: widget.product,
                      isAddStock: isAddStock,
                      quantity: quantity,
                    );
                  },
                ),
              ),

              const SizedBox(height: AppSizes.size15),
            ],
          ),
        ),
      ),
    );
  }
}
