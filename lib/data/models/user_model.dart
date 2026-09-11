import 'package:hive/hive.dart';

part '../adapters/user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String email;

  @HiveField(3)
  String phone;

  @HiveField(4)
  String shopName;

  @HiveField(5)
  String password;

  @HiveField(6)
  String? profileImagePath;

  @HiveField(7)
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.shopName,
    required this.password,
    this.profileImagePath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
