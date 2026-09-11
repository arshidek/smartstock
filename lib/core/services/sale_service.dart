import 'package:hive/hive.dart';
import '../../data/models/sale_model.dart';
import '../constants/hive_boxes.dart';
import 'auth_service.dart';

class SaleService {
  Box<SaleModel> get _box {
    final userId = AuthService().getCurrentUserId();
    if (userId == null) throw Exception("User not logged in");
    return Hive.box<SaleModel>("${HiveBoxes.sales}_$userId");
  }

  // Save Sale
  Future<void> saveSale(SaleModel sale) async {
    await _box.put(sale.id, sale);
  }

  // Get All Sales
  List<SaleModel> getAllSales() {
    return _box.values.toList();
  }

  // Get Sale By ID
  SaleModel? getSaleById(String id) {
    return _box.get(id);
  }

  // Update Sale
  Future<void> updateSale(SaleModel sale) async {
    await _box.put(sale.id, sale);
  }

  // Delete Sale
  Future<void> deleteSale(String id) async {
    await _box.delete(id);
  }

  // Clear All Sales
  Future<void> clearSales() async {
    await _box.clear();
  }
}
