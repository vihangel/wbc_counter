class BloodCellModel {
  final String name;
  final String title;
  final int quantity;
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
