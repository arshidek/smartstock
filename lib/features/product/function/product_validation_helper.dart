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
    String? sort,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    List<ProductModel> filteredList = products.where((product) {
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
      if (stockStatus != null && stockStatus != "All") {
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

      // Date Filter
      if (startDate != null && endDate != null) {
        final productDate = DateTime(
          product.createdAt.year,
          product.createdAt.month,
          product.createdAt.day,
        );
        final start = DateTime(startDate.year, startDate.month, startDate.day);
        final end = DateTime(endDate.year, endDate.month, endDate.day);
        if (productDate.isBefore(start) || productDate.isAfter(end)) {
          return false;
        }
      }

      return true;
    }).toList();

    // Sort
    if (sort != null) {
      switch (sort) {
        case "A - Z":
          filteredList.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
          );
          break;
        case "Z - A":
          filteredList.sort(
            (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()),
          );
          break;
        case "Price: Low to High":
          filteredList.sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice));
          break;
        case "Price: High to Low":
          filteredList.sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice));
          break;
        case "Stock: Low to High":
          filteredList.sort((a, b) => a.stock.compareTo(b.stock));
          break;
        case "Recently Added":
          filteredList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          break;
      }
    }

    return filteredList;
  }
}
