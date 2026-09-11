import 'package:hive/hive.dart';
import '../../data/models/category_model.dart';
import '../constants/hive_boxes.dart';
import 'auth_service.dart';

class CategoryService {
  Box<CategoryModel> get box {
    final userId = AuthService().getCurrentUserId();
    if (userId == null) throw Exception("User not logged in");
    return Hive.box<CategoryModel>("${HiveBoxes.categories}_$userId");
  }

  // Save Categories
  Future<void> saveCategories(CategoryModel category) async {
    await box.put(category.id, category);
  }

  // Get All Categories
  List<CategoryModel> getAllCategories() {
    return box.values.toList();
  }

  // Get Category By Id
  CategoryModel? getCategoryById(String id) {
    try {
      return box.values.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  // Delete Category
  Future<void> deleteCategory(String id) async {
    await box.delete(id);
  }

  // Check Duplicate Category
  bool categoryExists(String name) {
    return box.values.any(
      (category) => category.name.toLowerCase() == name.toLowerCase(),
    );
  }
}
