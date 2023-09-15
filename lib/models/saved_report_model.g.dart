// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_report_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveReportModelAdapter extends TypeAdapter<SaveReportModel> {
  @override
  final int typeId = 0;

  @override
  SaveReportModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveReportModel(
      name: fields[0] as String,
      type: fields[1] as String,
      referenceValues: fields[2] as String,
      age: fields[3] as int,
      bloodCells: (fields[4] as Map).cast<String, int>(),
      observation: fields[7] as String?,
      id: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SaveReportModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.referenceValues)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.bloodCells)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.observation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveReportModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
