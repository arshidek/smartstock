// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 3;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as String,
      productId: fields[1] as String,
      name: fields[2] as String,
      brandId: fields[3] as String,
      categoryId: fields[4] as String,
      purchasePrice: fields[5] as double,
      sellingPrice: fields[6] as double,
      stock: fields[7] as int,
      barcode: fields[8] as String,
      description: fields[9] as String,
      imagePath: fields[10] as String,
      createdBy: fields[12] as String,
      imagePaths: (fields[14] as List?)?.cast<String>(),
      createdAt: fields[11] as DateTime?,
      isActive: fields[13] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.brandId)
      ..writeByte(4)
      ..write(obj.categoryId)
      ..writeByte(5)
      ..write(obj.purchasePrice)
      ..writeByte(6)
      ..write(obj.sellingPrice)
      ..writeByte(7)
      ..write(obj.stock)
      ..writeByte(8)
      ..write(obj.barcode)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(10)
      ..write(obj.imagePath)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.createdBy)
      ..writeByte(13)
      ..write(obj.isActive)
      ..writeByte(14)
      ..write(obj.imagePaths);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
