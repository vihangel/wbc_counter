import 'package:hive/hive.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/blood_cells_model.dart';

part 'provider_cells.g.dart';

mixin ProviderCells {
  final S s = S();

  List<BloodCellModel> get whiteBloodCell => [
        BloodCellModel(
            name: 'Neutrófilo',
            quantity: 0,
            imagePath: 'neutrofilo.png',
            title: s.neutrophilsTitle),
        BloodCellModel(
            name: 'Basófilo',
            quantity: 0,
            imagePath: 'basofilo.png',
            title: s.basophilsTitle),
        BloodCellModel(
            name: 'Eosinófilo',
            quantity: 0,
            imagePath: 'eosinofilo.png',
            title: s.eosinophilsTitle),
        BloodCellModel(
            name: 'Monócito',
            quantity: 0,
            imagePath: 'monocito.png',
            title: s.monocytesTitle),
        BloodCellModel(
            name: 'Linfócito',
            quantity: 0,
            imagePath: 'linfocito.png',
            title: s.lymphocytesTitle),
      ];

  List<BloodCellModel> get redBloodCell => [
        BloodCellModel(
            name: 'Eritrócito',
            quantity: 0,
            imagePath: 'eritrocito.png',
            title: s.eritrocytesTitle),
        BloodCellModel(
            name: 'Plaquetas',
            quantity: 0,
            imagePath: 'plaquetas.png',
            title: s.plateletsTitle),
      ];

  List<BloodCellModel> get abnormalBloodCells => [
        BloodCellModel(
            name: 'Blastos',
            quantity: 0,
            imagePath: 'blastos.png',
            title: s.blastTitle),
        BloodCellModel(
            name: 'Metamielócitos',
            quantity: 0,
            imagePath: 'metamielocitos.png',
            title: s.matamielocitosTitle),
        BloodCellModel(
            name: 'Mielócitos',
            quantity: 0,
            imagePath: 'mielocitos.png',
            title: s.mielocitosTitle),
        BloodCellModel(
            name: 'Promielócitos',
            quantity: 0,
            imagePath: 'promielocitos.png',
            title: s.promielocitosTitle),
        BloodCellModel(
            name: 'Reticulócitos',
            quantity: 0,
            imagePath: 'reticulocitos.png',
            title: s.reticulocitosTitle),
        BloodCellModel(
            name: 'Hipersegmentados',
            quantity: 0,
            imagePath: 'hipersegmentados.png',
            title: s.hipersegmentadosTitle),
        BloodCellModel(
            name: 'Pilosas',
            quantity: 0,
            imagePath: 'pilosas.png',
            title: s.pilosasTitle),
      ];
}

@HiveType(typeId: 1)
class TotalCellsBlood extends HiveObject {
  @HiveField(0)
  Map<String, int> wbcQuantities;
  @HiveField(1)
  Map<String, int> rbcQuantities;
  @HiveField(2)
  Map<String, int> abnormalQuantities;
  @HiveField(3)
  Map<String, int> userCells;

  TotalCellsBlood(
      {required this.wbcQuantities,
      required this.rbcQuantities,
      required this.abnormalQuantities,
      required this.userCells});

  int get totalWbcCount => allCells.values.reduce((a, b) => a + b);

  TotalCellsBlood.defaultValue()
      : wbcQuantities = const {
          'Neutrófilo': 0,
          'Basófilo': 0,
          'Eosinófilo': 0,
          'Monócito': 0,
          'Linfócito': 0,
        },
        rbcQuantities = const {
          'Eritrócito': 0,
          'Plaquetas': 0,
        },
        abnormalQuantities = const {
          'Blastos': 0,
          'Metamielócitos': 0,
          'Mielócitos': 0,
          'Promielócitos': 0,
          'Reticulócitos': 0,
          'Hipersegmentados': 0,
          'Pilosas': 0,
        },
        userCells = const {};

  copyWith({
    Map<String, int>? wbcQuantities,
    Map<String, int>? rbcQuantities,
    Map<String, int>? abnormalQuantities,
    Map<String, int>? userCells,
  }) {
    return TotalCellsBlood(
      wbcQuantities: wbcQuantities ?? this.wbcQuantities,
      rbcQuantities: rbcQuantities ?? this.rbcQuantities,
      abnormalQuantities: abnormalQuantities ?? this.abnormalQuantities,
      userCells: userCells ?? this.userCells,
    );
  }

  String get reportText => allCells
      .map((key, value) => MapEntry(key, value))
      .values
      .reduce((a, b) => a + b)
      .toString();

  Map<String, int> get allCells => {
        ...wbcQuantities,
        ...rbcQuantities,
        ...abnormalQuantities,
        ...userCells,
      };
}
