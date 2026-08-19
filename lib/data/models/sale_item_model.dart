import 'package:hive/hive.dart';

part 'sale_item_model.g.dart';

@HiveType(typeId: 5)
class SaleItemModel extends HiveObject {
  @HiveField(0)
  String productId;

  @HiveField(1)
  String productName;

  @HiveField(2)
  String brandName;

  @HiveField(3)
  String categoryName;

  @HiveField(4)
  String imagePath;

  @HiveField(5)
  double purchasePrice;

  @HiveField(6)
  double sellingPrice;

  @HiveField(7)
  int quantity;

  @HiveField(8)
  double totalPrice;

  @HiveField(9)
  double profit;

  SaleItemModel({
    required this.productId,
    required this.productName,
    required this.brandName,
    required this.categoryName,
    required this.imagePath,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.quantity,
    required this.totalPrice,
    required this.profit,
  });
}
