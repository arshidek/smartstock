import '../../../core/services/brand_service.dart';
import '../../../core/services/category_service.dart';
import '../../../data/models/product_model.dart';

class ProductValidationHelper {
  final BrandService _brandService = BrandService();
  final CategoryService _categoryService = CategoryService();

  List<ProductModel> filterProducts({
    required List<ProductModel> products,
    String search = "",
    String? stockStatus,
    List<String> selectedBrands = const [],
    List<String> selectedCategories = const [],
  }) {
    return products.where((product) {
      // Search
      final brandName = _brandService.getBrandById(product.brandId)?.name ?? "";

      final categoryName =
          _categoryService.getCategoryById(product.categoryId)?.name ?? "";

      final searchText = search.toLowerCase();

      if (searchText.isNotEmpty &&
          !product.name.toLowerCase().contains(searchText) &&
          !product.productId.toLowerCase().contains(searchText) &&
          !brandName.toLowerCase().contains(searchText) &&
          !categoryName.toLowerCase().contains(searchText)) {
        return false;
      }

      if (selectedBrands.isNotEmpty && !selectedBrands.contains(brandName)) {
        return false;
      }

      if (selectedCategories.isNotEmpty &&
          !selectedCategories.contains(categoryName)) {
        return false;
      }
      // Stock Filter
      if (stockStatus != null) {
        switch (stockStatus) {
          case "In Stock":
            if (product.stock <= 5) return false;
            break;

          case "Low Stock":
            if (product.stock > 5 || product.stock == 0) return false;
            break;

          case "Out of Stock":
            if (product.stock != 0) return false;
            break;
        }
      }

      return true;
    }).toList();
  }
}
