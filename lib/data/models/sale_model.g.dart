// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaleModelAdapter extends TypeAdapter<SaleModel> {
  @override
  final int typeId = 4;

  @override
  SaleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaleModel(
      id: fields[0] as String,
      invoiceNo: fields[1] as String,
      saleDate: fields[2] as DateTime,
      items: (fields[3] as List).cast<SaleItemModel>(),
      subTotal: fields[4] as double,
      discount: fields[5] as double,
      grandTotal: fields[6] as double,
      paymentMethod: fields[7] as String,
      customerName: fields[8] as String,
      customerPhone: fields[9] as String,
      customerEmail: fields[10] as String,
      customerAddress: fields[11] as String,
      note: fields[12] as String,
      totalQuantity: fields[13] as int,
      totalProfit: fields[14] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SaleModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.invoiceNo)
      ..writeByte(2)
      ..write(obj.saleDate)
      ..writeByte(3)
      ..write(obj.items)
      ..writeByte(4)
      ..write(obj.subTotal)
      ..writeByte(5)
      ..write(obj.discount)
      ..writeByte(6)
      ..write(obj.grandTotal)
      ..writeByte(7)
      ..write(obj.paymentMethod)
      ..writeByte(8)
      ..write(obj.customerName)
      ..writeByte(9)
      ..write(obj.customerPhone)
      ..writeByte(10)
      ..write(obj.customerEmail)
      ..writeByte(11)
      ..write(obj.customerAddress)
      ..writeByte(12)
      ..write(obj.note)
      ..writeByte(13)
      ..write(obj.totalQuantity)
      ..writeByte(14)
      ..write(obj.totalProfit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
