class WhiteBloodCell {
  final String name;
  final int quantity;
  final String imagePath;

  WhiteBloodCell({
    required this.name,
    required this.quantity,
    required this.imagePath,
  });

  WhiteBloodCell copyWith({
    String? name,
    int? quantity,
    String? imagePath,
  }) {
    return WhiteBloodCell(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
