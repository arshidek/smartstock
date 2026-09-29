import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/services/brand_service.dart';
import '../../../../core/services/category_service.dart';
import '../../../../data/models/brand_model.dart';
import '../../../../data/models/category_model.dart';
import '../../../../data/models/product_model.dart';
import '../../../../core/widgets/filters/app_date_picker_bottom_sheet.dart';
import '../../functions/stock_functions.dart';
import 'mobile/mobile_update_stock_screen.dart';
import 'web/web_update_stock_screen.dart';

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
  int quantity = 0;
  int newStock = 0;

  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    quantity = widget.product.stock;
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

  Future<void> _handleEditDate() async {
    final picked = await showAppDatePicker(
      context: context,
      initialDate: widget.product.createdAt,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        widget.product.createdAt = picked;
      });
    }
  }

  void _handleUpdateStock() async {
    await _stockFunction.updateStock(
      context: context,
      product: widget.product,
      isAddStock: isAddStock,
      quantity: quantity,
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return WebUpdateStockScreen(
        product: widget.product,
        brand: _brand,
        category: _category,
        isAddStock: isAddStock,
        quantity: quantity,
        noteController: _noteController,
        onEditDate: _handleEditDate,
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
        onUpdateStock: _handleUpdateStock,
      );
    }

    return MobileUpdateStockScreen(
      product: widget.product,
      brand: _brand,
      category: _category,
      isAddStock: isAddStock,
      quantity: quantity,
      noteController: _noteController,
      onEditDate: _handleEditDate,
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
      onUpdateStock: _handleUpdateStock,
    );
  }
}
