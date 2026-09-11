import 'package:flutter/material.dart';
import '../widgets/barcode_scanner_dialog.dart';
import '../../../app/app_navigation.dart';
import '../../../core/services/brand_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/services/product_service.dart';
import '../../../core/utils/image_picker_helper.dart';
import '../../../data/models/product_model.dart';
import '../../stock/presentation/update_stock_screen.dart';
import '../function/product_function.dart';
import '../widgets/edit_product_app_bar.dart';
import 'edit_product_body.dart';
import 'edit_product_state.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;
  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final ProductFunction _productFunction = ProductFunction();
  late final EditProductState _state;

  @override
  void initState() {
    super.initState();
    _state = EditProductState(
      brandService: BrandService(),
      categoryService: CategoryService(),
      productService: ProductService(),
    );
    _state.loadProduct(widget.product);
    _state.brands = _state.brandService.getAllBrands();
    _state.categories = _state.categoryService.getAllCategories();
  }

  Future<void> _pickImages() async {
    final images = await ImagePickerHelper.pickMultiImages();

    if (images.isNotEmpty) {
      setState(() {
        _state.images.addAll(images);
        _state.imageError = null;
      });
    }
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  Future<void> _scanBarcode() async {
    final String? res = await showDialog<String>(
      context: context,
      builder: (context) => const BarcodeScannerDialog(),
    );
    if (res != null) {
      setState(() {
        _state.barcodeController.text = res;
      });
    }
  }

  Future<void> _handleUpdateStock() async {
    final result = await AppNavigation.goToScreen(
      context,
      UpdateStockScreen(product: widget.product),
    );

    if (result == true) {
      _state.loadProduct(widget.product);
      setState(() {});
    }
  }

  Future<void> _handleUpdateProduct() async {
    await _productFunction.updateProduct(
      context: context,
      formKey: _state.formKey,
      product: widget.product,
      productNameController: _state.productNameController,
      purchasePriceController: _state.purchasePriceController,
      sellingPriceController: _state.sellingPriceController,
      stockController: _state.stockController,
      barcodeController: _state.barcodeController,
      descriptionController: _state.descriptionController,
      brandId: _state.selectedBrandId,
      categoryId: _state.selectedCategoryId,
      images: _state.images,
      status: _state.status,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EditProductAppBar(),
      body: EditProductBody(
        formKey: _state.formKey,
        images: _state.images,
        imageError: _state.imageError,
        productNameController: _state.productNameController,
        onPickImages: _pickImages,
        onRemoveImage: (index) {
          setState(() {
            _state.images.removeAt(index);
          });
        },
        purchasePriceController: _state.purchasePriceController,
        sellingPriceController: _state.sellingPriceController,
        stockController: _state.stockController,
        barcodeController: _state.barcodeController,
        descriptionController: _state.descriptionController,
        brands: _state.brands,
        categories: _state.categories,
        selectedBrandId: _state.selectedBrandId,
        selectedCategoryId: _state.selectedCategoryId,
        onBrandChanged: (value) =>
            setState(() => _state.selectedBrandId = value),
        onCategoryChanged: (value) =>
            setState(() => _state.selectedCategoryId = value),
        onScanBarcode: _scanBarcode,
        onUpdateProduct: _handleUpdateProduct,
        onUpdateStock: _handleUpdateStock,
      ),
    );
  }
}
