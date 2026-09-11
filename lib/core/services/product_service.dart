import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/product_model.dart';
import '../constants/hive_boxes.dart';
import 'auth_service.dart';

class ProductService {
  Box<ProductModel> get _box {
    final userId = AuthService().getCurrentUserId();
    if (userId == null) throw Exception("User not logged in");
    return Hive.box<ProductModel>("${HiveBoxes.products}_$userId");
  }

  ValueListenable<Box<ProductModel>> get listenable => _box.listenable();

  // Add Product
  Future<void> addProduct(ProductModel product) async {
    await _box.put(product.id, product);
  }

  // Get All Products
  List<ProductModel> getAllProducts() {
    return _box.values.toList();
  }

  // Get Product By Id
  ProductModel? getProductById(String id) {
    return _box.get(id);
  }

  // Update Product
  Future<void> updateProduct(ProductModel product) async {
    await product.save();
  }

  // Delete Product
  Future<void> deleteProduct(String id) async {
    await _box.delete(id);
  }

  // Clear All Products
  Future<void> clearProducts() async {
    await _box.clear();
  }


  // Product Already Exists
  bool productExists(String productName) {
    return _box.values.any(
      (product) =>
          product.name.trim().toLowerCase() == productName.trim().toLowerCase(),
    );
  }

  // Barcode Already Exists
  bool barcodeExists(String barcode) {
    return _box.values.any(
      (product) =>
          product.barcode.trim().toLowerCase() == barcode.trim().toLowerCase(),
    );
  }


  // Brand Already Used
  bool isBrandUsed(String brandId) {
    return _box.values.any((product) => product.brandId == brandId);
  }

  // Get Products By Brand
  List<ProductModel> getProductsByBrand(String brandId) {
    debugPrint("=================================");
    debugPrint("Selected Brand ID : $brandId");

    for (final product in _box.values) {
      debugPrint("----------------------------");
      debugPrint("Product Name : ${product.name}");
      debugPrint("Product BrandId : ${product.brandId}");
    }

    final products = _box.values
        .where((product) => product.brandId == brandId)
        .toList();

    debugPrint("Products Found : ${products.length}");
    debugPrint("=================================");

    return products;
  }

  // Brand Product Count
  int getBrandProductCount(String brandId) {
    return getProductsByBrand(brandId).length;
  }

  // Brand Total Inventory Value
  double getBrandTotalValue(String brandId) {
    return getProductsByBrand(brandId).fold(
      0.0,
      (total, product) => total + (product.sellingPrice * product.stock),
    );
  }


  // Category Already Used
  bool isCategoryUsed(String categoryId) {
    return _box.values.any((product) => product.categoryId == categoryId);
  }

  // Get Products By Category
  List<ProductModel> getProductsByCategory(String categoryId) {
    return _box.values
        .where((product) => product.categoryId == categoryId)
        .toList();
  }

  // Category Product Count
  int getCategoryProductCount(String categoryId) {
    return getProductsByCategory(categoryId).length;
  }

  // Category Total Inventory Value
  double getCategoryTotalValue(String categoryId) {
    return getProductsByCategory(categoryId).fold(
      0.0,
      (total, product) => total + (product.sellingPrice * product.stock),
    );
  }

  ProductModel? getProductByProductId(String productId) {
    try {
      return _box.values.firstWhere(
        (product) => product.productId == productId,
      );
    } catch (e) {
      return null;
    }
  }
}
