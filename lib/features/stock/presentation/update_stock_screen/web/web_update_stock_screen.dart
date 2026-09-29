import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/widgets/buttons/app_button.dart';
import '../../../../../core/widgets/cards/app_card_widget.dart';
import '../../../../../data/models/brand_model.dart';
import '../../../../../data/models/category_model.dart';
import '../../../../../data/models/product_model.dart';
import '../../../widgets/note_card.dart';
import '../../../widgets/product_header_card.dart';
import '../../../widgets/stock_update_card.dart';

class WebUpdateStockScreen extends StatelessWidget {
  final ProductModel product;
  final BrandModel? brand;
  final CategoryModel? category;
  final bool isAddStock;
  final int quantity;
  final TextEditingController noteController;
  final Future<void> Function() onEditDate;
  final ValueChanged<bool> onActionChanged;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onUpdateStock;

  const WebUpdateStockScreen({
    super.key,
    required this.product,
    required this.brand,
    required this.category,
    required this.isAddStock,
    required this.quantity,
    required this.noteController,
    required this.onEditDate,
    required this.onActionChanged,
    required this.onQuantityChanged,
    required this.onUpdateStock,
  });

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
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Header
                  AppCardWidget(
                    child: Column(
                      children: [
                        ProductHeaderCard(
                          product: product,
                          brand: brand,
                          category: category,
                          onEditDate: onEditDate,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.size25),

                  StockUpdateCard(
                    isAddStock: isAddStock,
                    quantity: quantity,
                    currentStock: product.stock,
                    onActionChanged: onActionChanged,
                    onQuantityChanged: onQuantityChanged,
                  ),

                  const SizedBox(height: AppSizes.size20),

                  NoteCard(controller: noteController),

                  const SizedBox(height: AppSizes.size15),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.padding16,
                      vertical: AppSizes.size10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 250,
                          child: AppButton(
                            text: "Update Stock",
                            icon: Icons.inventory,
                            backgroundColor: AppColors.blue,
                            textColor: AppColors.white,
                            iconColor: AppColors.white,
                            onPressed: onUpdateStock,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSizes.size15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
