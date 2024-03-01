// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_cells.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TotalCellsBloodAdapter extends TypeAdapter<TotalCellsBlood> {
  @override
  final int typeId = 1;

  @override
  TotalCellsBlood read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TotalCellsBlood(
      wbcQuantities: (fields[0] as Map).cast<String, int>(),
      rbcQuantities: (fields[1] as Map).cast<String, int>(),
      abnormalQuantities: (fields[2] as Map).cast<String, int>(),
      userCells: (fields[3] as Map).cast<String, int>(),
    );
  }

  @override
  void write(BinaryWriter writer, TotalCellsBlood obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.wbcQuantities)
      ..writeByte(1)
      ..write(obj.rbcQuantities)
      ..writeByte(2)
      ..write(obj.abnormalQuantities)
      ..writeByte(3)
      ..write(obj.userCells);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalCellsBloodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
