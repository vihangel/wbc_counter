import 'package:hive/hive.dart';
import 'package:wbc_counter/pages/home/mixin/provider_cells.dart';

part 'saved_report_model.g.dart';

@HiveType(typeId: 0)
class SaveReportModel extends HiveObject {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final String? type;

  @HiveField(2)
  final String? referenceValues;

  @HiveField(3)
  final int? age;

  @HiveField(4)
  final TotalCellsBlood? bloodCells;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final String? id;

  @HiveField(7)
  String? observation;

  SaveReportModel({
    this.name,
    this.type,
    this.referenceValues,
    this.age,
    required this.bloodCells,
    this.observation,
    this.id,
  }) : createdAt = DateTime.now();

  SaveReportModel copyWith({
    String? name,
    String? type,
    String? referenceValues,
    int? age,
    TotalCellsBlood? bloodCells,
    String? observation,
    String? id,
  }) {
    return SaveReportModel(
      name: name ?? this.name,
      type: type ?? this.type,
      referenceValues: referenceValues ?? this.referenceValues,
      age: age ?? this.age,
      bloodCells: bloodCells ?? this.bloodCells,
      observation: observation ?? this.observation,
      id: id ?? this.id,
    );
  }
}
