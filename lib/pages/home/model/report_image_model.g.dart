// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_image_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReportImageModelAdapter extends TypeAdapter<ReportImageModel> {
  @override
  final int typeId = 3;

  @override
  ReportImageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReportImageModel(
      imagePath: fields[0] as String,
      name: fields[1] as String,
      coordinates: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ReportImageModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.coordinates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportImageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
