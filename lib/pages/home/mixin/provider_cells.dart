import 'package:hive/hive.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/blood_cells_model.dart';

part 'provider_cells.g.dart';

@HiveType(typeId: 1)
class TotalCellsBlood extends HiveObject {
  @HiveField(0)
  List<BloodCellModel> wbcQuantities;
  @HiveField(1)
  List<BloodCellModel> rbcQuantities;
  @HiveField(2)
  List<BloodCellModel> abnormalQuantities;
  @HiveField(3)
  List<BloodCellModel> userCells;

  TotalCellsBlood(
      {required this.wbcQuantities,
      required this.rbcQuantities,
      required this.abnormalQuantities,
      required this.userCells});

  int get totalWbcCount => allCells.fold(
      0, (previousValue, element) => previousValue + element.quantity);

  TotalCellsBlood.defaultValue(S s)
      : wbcQuantities = [
          BloodCellModel(
              name: 'Linfócitos',
              quantity: 0,
              imagePath: 'linfocito.png',
              title: s.lymphocytesTitle),
          BloodCellModel(
              name: 'Neutrófilos',
              quantity: 0,
              imagePath: 'neutrofilo.png',
              title: s.neutrophilsTitle),
          BloodCellModel(
              name: 'Eosinófilos',
              quantity: 0,
              imagePath: 'eosinofilo.png',
              title: s.eosinophilsTitle),
          BloodCellModel(
              name: 'Basófilos',
              quantity: 0,
              imagePath: 'basofilo.png',
              title: s.basophilsTitle),
          BloodCellModel(
              name: 'Monocitos',
              quantity: 0,
              imagePath: 'monocito.png',
              title: s.monocytesTitle),
        ],
        rbcQuantities = [
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
        ],
        abnormalQuantities = [
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
        ],
        userCells = [];

  TotalCellsBlood copyWith({
    List<BloodCellModel>? wbcQuantities,
    List<BloodCellModel>? rbcQuantities,
    List<BloodCellModel>? abnormalQuantities,
    List<BloodCellModel>? userCells,
  }) {
    return TotalCellsBlood(
      wbcQuantities: wbcQuantities ?? this.wbcQuantities,
      rbcQuantities: rbcQuantities ?? this.rbcQuantities,
      abnormalQuantities: abnormalQuantities ?? this.abnormalQuantities,
      userCells: userCells ?? this.userCells,
    );
  }

  String get reportText =>
      allCells.map((e) => '${e.title}: ${e.quantity}').toList().join('\n');

  List<BloodCellModel> get allCells =>
      [...wbcQuantities, ...rbcQuantities, ...abnormalQuantities, ...userCells];

  void updateCellQuantity(String name, int newQuantity) {
    List<BloodCellModel> updateList(List<BloodCellModel> list) {
      int index = list.indexWhere((cell) => cell.name == name);
      if (index != -1) {
        var cell = list[index];
        list[index] = cell.copyWith(quantity: newQuantity);
      }
      return list;
    }

    wbcQuantities = updateList(wbcQuantities);
    rbcQuantities = updateList(rbcQuantities);
    abnormalQuantities = updateList(abnormalQuantities);
    userCells = updateList(userCells);
  }
}
