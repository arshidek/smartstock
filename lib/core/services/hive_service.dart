import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/brand_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/sale_item_model.dart';
import '../../data/models/sale_model.dart';
import '../../data/models/user_model.dart';
import '../constants/hive_boxes.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();

    /// register Adapter
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(BrandModelAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(SaleItemModelAdapter());
    Hive.registerAdapter(SaleModelAdapter());

    /// box Open
    await Hive.openBox<UserModel>(HiveBoxes.users);
    await Hive.openBox(HiveBoxes.settings);
  }

  Future<void> openUserBoxes(String userId) async {
    await Hive.openBox<BrandModel>("${HiveBoxes.brands}_$userId");
    await Hive.openBox<CategoryModel>("${HiveBoxes.categories}_$userId");
    await Hive.openBox<ProductModel>("${HiveBoxes.products}_$userId");
    await Hive.openBox<SaleModel>("${HiveBoxes.sales}_$userId");
    await Hive.openBox<SaleItemModel>("${HiveBoxes.sales}Items_$userId");
  }

  Future<void> closeUserBoxes(String userId) async {
    if (Hive.isBoxOpen("${HiveBoxes.brands}_$userId")) {
      await Hive.box<BrandModel>("${HiveBoxes.brands}_$userId").close();
    }
    if (Hive.isBoxOpen("${HiveBoxes.categories}_$userId")) {
      await Hive.box<CategoryModel>("${HiveBoxes.categories}_$userId").close();
    }
    if (Hive.isBoxOpen("${HiveBoxes.products}_$userId")) {
      await Hive.box<ProductModel>("${HiveBoxes.products}_$userId").close();
    }
    if (Hive.isBoxOpen("${HiveBoxes.sales}_$userId")) {
      await Hive.box<SaleModel>("${HiveBoxes.sales}_$userId").close();
    }
    if (Hive.isBoxOpen("${HiveBoxes.sales}Items_$userId")) {
      await Hive.box<SaleItemModel>("${HiveBoxes.sales}Items_$userId").close();
    }
  }
}
