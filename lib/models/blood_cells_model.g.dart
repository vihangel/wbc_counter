// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_cells_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodCellModelAdapter extends TypeAdapter<BloodCellModel> {
  @override
  final int typeId = 2;

  @override
  BloodCellModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodCellModel(
      title: fields[1] as String,
      name: fields[0] as String,
      quantity: fields[2] as int,
      imagePath: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BloodCellModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodCellModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
