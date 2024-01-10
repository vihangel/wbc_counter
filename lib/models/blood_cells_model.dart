class BloodCellModel {
  final String name;
  final int quantity;
  final String imagePath;

  BloodCellModel({
    required this.name,
    required this.quantity,
    required this.imagePath,
  });

  BloodCellModel copyWith({
    String? name,
    int? quantity,
    String? imagePath,
  }) {
    return BloodCellModel(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
