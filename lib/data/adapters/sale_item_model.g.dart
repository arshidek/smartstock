// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/sale_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaleItemModelAdapter extends TypeAdapter<SaleItemModel> {
  @override
  final int typeId = 5;

  @override
  SaleItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaleItemModel(
      productId: fields[0] as String,
      productName: fields[1] as String,
      brandName: fields[2] as String,
      categoryName: fields[3] as String,
      imagePath: fields[4] as String,
      purchasePrice: fields[5] as double,
      sellingPrice: fields[6] as double,
      quantity: fields[7] as int,
      totalPrice: fields[8] as double,
      profit: fields[9] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SaleItemModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.brandName)
      ..writeByte(3)
      ..write(obj.categoryName)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.purchasePrice)
      ..writeByte(6)
      ..write(obj.sellingPrice)
      ..writeByte(7)
      ..write(obj.quantity)
      ..writeByte(8)
      ..write(obj.totalPrice)
      ..writeByte(9)
      ..write(obj.profit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
