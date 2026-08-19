import 'package:hive/hive.dart';
import 'sale_item_model.dart';

part 'sale_model.g.dart';

@HiveType(typeId: 4)
class SaleModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String invoiceNo;

  @HiveField(2)
  DateTime saleDate;

  @HiveField(3)
  List<SaleItemModel> items;

  @HiveField(4)
  double subTotal;

  @HiveField(5)
  double discount;

  @HiveField(6)
  double grandTotal;

  @HiveField(7)
  String paymentMethod;

  @HiveField(8)
  String customerName;

  @HiveField(9)
  String customerPhone;

  @HiveField(10)
  String customerEmail;

  @HiveField(11)
  String customerAddress;

  @HiveField(12)
  String note;

  @HiveField(13)
  int totalQuantity;

  @HiveField(14)
  double totalProfit;

  SaleModel({
    required this.id,
    required this.invoiceNo,
    required this.saleDate,
    required this.items,
    required this.subTotal,
    required this.discount,
    required this.grandTotal,
    required this.paymentMethod,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.customerAddress,
    required this.note,
    required this.totalQuantity,
    required this.totalProfit,
  });
}
