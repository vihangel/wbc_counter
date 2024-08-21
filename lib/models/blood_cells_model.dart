import 'package:hive/hive.dart';

part 'blood_cells_model.g.dart';

@HiveType(typeId: 2)
class BloodCellModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int quantity;
  @HiveField(3)
  final String? imagePath;

  BloodCellModel({
    required this.title,
    required this.name,
    required this.quantity,
    this.imagePath,
  });

  BloodCellModel copyWith({
    String? name,
    int? quantity,
    String? imagePath,
    String? title,
  }) {
    return BloodCellModel(
      title: title ?? this.title,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
