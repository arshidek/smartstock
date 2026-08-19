import '../../../core/services/brand_service.dart';
import '../../../core/services/category_service.dart';
import '../../../core/services/product_service.dart';
import '../../../data/models/brand_model.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';

class AddProductToSaleFunctions {
  final BrandService _brandService = BrandService();
  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();

  List<BrandModel> loadBrands() {
    return _brandService.getAllBrands();
  }

  List<CategoryModel> loadCategories() {
    return _categoryService.getAllCategories();
  }

  List<ProductModel> loadProducts() {
    return _productService.getAllProducts();
  }

  List<ProductModel> filterProducts({
    required List<ProductModel> products,
    required BrandModel? selectedBrand,
    required CategoryModel? selectedCategory,
  }) {
    return products.where((product) {
      return product.brandId == selectedBrand?.id &&
          product.categoryId == selectedCategory?.id;
    }).toList();
  }

  int getMaxSaleQuantity({
    required ProductModel product,
    int minimumStock = 5,
  }) {
    return product.stock - minimumStock;
  }

  double calculateTotalPrice({
    required double ratePerUnit,
    required int quantity,
  }) {
    return ratePerUnit * quantity;
  }
}
