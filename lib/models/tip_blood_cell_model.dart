class TipBloodCellModel {
  final String name;
  final String description;
  final String cover;
  final List<String> identifyTopics;
  final String? exampleImage;
  final List<TipBloodCellModel> subtypes;

  TipBloodCellModel({
    required this.name,
    required this.description,
    required this.cover,
    required this.identifyTopics,
    this.exampleImage,
    this.subtypes = const [],
  });
}
