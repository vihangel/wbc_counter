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
      wbcQuantities: (fields[0] as List).cast<BloodCellModel>(),
      rbcQuantities: (fields[1] as List).cast<BloodCellModel>(),
      abnormalQuantities: (fields[2] as List).cast<BloodCellModel>(),
      userCells: (fields[3] as List).cast<BloodCellModel>(),
      shapeCells: (fields[4] as List).cast<BloodCellModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TotalCellsBlood obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.wbcQuantities)
      ..writeByte(1)
      ..write(obj.rbcQuantities)
      ..writeByte(2)
      ..write(obj.abnormalQuantities)
      ..writeByte(3)
      ..write(obj.userCells)
      ..writeByte(4)
      ..write(obj.shapeCells);
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
