import 'package:hive/hive.dart';
import '../../data/models/brand_model.dart';
import '../constants/hive_boxes.dart';

import 'auth_service.dart';

class BrandService {
  Box<BrandModel> get box {
    final userId = AuthService().getCurrentUserId();
    if (userId == null) throw Exception("User not logged in");
    return Hive.box<BrandModel>("${HiveBoxes.brands}_$userId");
  }

  // Save Brand
  Future<void> saveBrand(BrandModel brand) async {
    await box.put(brand.id, brand);
  }

  // Get All Brands
  List<BrandModel> getAllBrands() {
    return box.values.toList();
  }

  // Get Brand By Id
  BrandModel? getBrandById(String id) {
    try {
      return box.values.firstWhere((brand) => brand.id == id);
    } catch (e) {
      return null;
    }
  }

  // Delete Brand
  Future<void> deleteBrand(String id) async {
    await box.delete(id);
  }

  // Check Duplicate Brand
  bool brandExists(String name, {String? excludeId}) {
    return box.values.any((brand) {
      final sameName =
          brand.name.trim().toLowerCase() == name.trim().toLowerCase();

      final isDifferentBrand = brand.id != excludeId;

      return sameName && isDifferentBrand;
    });
  }
}
