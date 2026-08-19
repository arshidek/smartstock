import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 3)
class ProductModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String productId;

  @HiveField(2)
  String name;

  @HiveField(3)
  String brandId;

  @HiveField(4)
  String categoryId;

  @HiveField(5)
  double purchasePrice;

  @HiveField(6)
  double sellingPrice;

  @HiveField(7)
  int stock;

  @HiveField(8)
  String barcode;

  @HiveField(9)
  String description;

  @HiveField(10)
  String imagePath;

  @HiveField(11)
  DateTime createdAt;

  @HiveField(12)
  String createdBy;

  @HiveField(13)
  bool isActive;

  // Added to support multi-images for products
  @HiveField(14)
  List<String>? imagePaths;

  ProductModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.brandId,
    required this.categoryId,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.stock,
    required this.barcode,
    required this.description,
    required this.imagePath,
    required this.createdBy,
    this.imagePaths, // Added for multi-images
    DateTime? createdAt,
    this.isActive = true,
  }) : createdAt = createdAt ?? DateTime.now();

  // Added to combine old single imagePath with new imagePaths
  List<String> get allImages {
    if (imagePaths != null && imagePaths!.isNotEmpty) {
      return imagePaths!;
    }
    if (imagePath.isNotEmpty) {
      return [imagePath];
    }
    return [];
  }

  String get stockStatus {
    if (stock <= 0) return "Out of Stock";
    if (stock <= 5) return "Low Stock";
    return "In Stock";
  }

  Color get stockColor {
    if (stock <= 0) return Colors.red;
    if (stock <= 5) return Colors.orange;
    return Colors.green;
  }
}
