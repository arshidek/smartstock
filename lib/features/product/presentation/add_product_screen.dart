import 'package:flutter/material.dart';
import '../widgets/add_product_app_bar.dart';
import '../widgets/barcode_scanner_dialog.dart';
import '../../../core/services/brand_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/services/user_service.dart';
import '../../../core/utils/image_picker_helper.dart';
import '../function/product_function.dart';
import 'add_product_body.dart';
import 'add_product_state.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late final AddProductState _state;

  @override
  void initState() {
    super.initState();
    _state = AddProductState(
      brandService: BrandService(),
      categoryService: CategoryService(),
      userService: UserService(),
      productFunction: ProductFunction(),
    );
    _initializeScreen();
  }

  void _initializeScreen() {
    _loadCurrentUser();
    _generateProductId();
    _loadBrands();
    _loadCategories();
    _setupTextFieldListeners();
  }

  void _loadCurrentUser() {
    _state.currentUser = _state.userService.getCurrentUser();
  }

  void _generateProductId() {
    _state.productId = "P${DateTime.now().millisecondsSinceEpoch}";
  }

  void _loadBrands() {
    _state.brands = _state.brandService.getAllBrands();

    if (_state.brands.isNotEmpty) {
      _state.selectedBrandId = _state.brands.first.id;
    }
  }

  void _loadCategories() {
    _state.categories = _state.categoryService.getAllCategories();

    if (_state.categories.isNotEmpty) {
      _state.selectedCategoryId = _state.categories.first.id;
    }
  }

  void _setupTextFieldListeners() {
    _state.productNameController.addListener(_clearProductError);
    _state.barcodeController.addListener(_clearBarcodeError);
  }

  void _clearProductError() {
    if (_state.productError != null) {
      setState(() {
        _state.productError = null;
      });
    }
  }

  void _clearBarcodeError() {
    if (_state.barcodeError != null) {
      setState(() {
        _state.barcodeError = null;
      });
    }
  }

  @override
  void dispose() {
    _state.productNameController.removeListener(_clearProductError);
    _state.barcodeController.removeListener(_clearBarcodeError);
    _state.dispose();
    super.dispose();
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

  Future<void> _scanBarcode() async {
    final String? res = await showDialog<String>(
      context: context,
      builder: (context) => const BarcodeScannerDialog(),
    );
    if (res != null) {
      setState(() {
        _state.barcodeController.text = res;
        _state.barcodeError = null;
      });
    }
  }

  Future<void> _handleSaveProduct() async {
    if (_state.images.isEmpty) {
      setState(() {
        _state.imageError = "Please select at least one product image";
      });
      return;
    }

    setState(() {
      _state.productError = null;
      _state.barcodeError = null;
    });

    final result = await _state.productFunction.saveProduct(
      context: context,
      formKey: _state.formKey,
      productNameController: _state.productNameController,
      purchasePriceController: _state.purchasePriceController,
      sellingPriceController: _state.sellingPriceController,
      stockController: _state.stockController,
      barcodeController: _state.barcodeController,
      descriptionController: _state.descriptionController,
      brandId: _state.selectedBrandId,
      categoryId: _state.selectedCategoryId,
      images: _state.images,
      createdBy: _state.currentUser?.username ?? "Unknown",
      status: true,
    );

    setState(() {
      _state.productError = null;
      _state.barcodeError = null;

      switch (result) {
        case ProductSaveResult.duplicateProduct:
          _state.productError = "Product already exists";
          break;

        case ProductSaveResult.duplicateBarcode:
          _state.barcodeError = "Barcode already exists";
          break;

        case ProductSaveResult.invalidForm:
        case ProductSaveResult.success:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AddProductAppBar(),
      body: AddProductBody(
        formKey: _state.formKey,
        images: _state.images,
        imageError: _state.imageError,
        productError: _state.productError,
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
        barcodeError: _state.barcodeError,
        brands: _state.brands,
        categories: _state.categories,
        selectedBrandId: _state.selectedBrandId,
        selectedCategoryId: _state.selectedCategoryId,
        onBrandChanged: (value) =>
            setState(() => _state.selectedBrandId = value),
        onCategoryChanged: (value) =>
            setState(() => _state.selectedCategoryId = value),
        onScanBarcode: _scanBarcode,
        onSave: _handleSaveProduct,
      ),
    );
  }
}
