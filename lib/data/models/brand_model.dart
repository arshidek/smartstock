import 'package:hive/hive.dart';

part 'brand_model.g.dart'; // ← This will be generated

@HiveType(typeId: 1) // Unique typeId for Brand
class BrandModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? imagePath;

  @HiveField(3)
  String? description;

  @HiveField(4)
  DateTime createdAt;

  BrandModel({
    required this.id,
    required this.name,
    this.imagePath,
    this.description,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
