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
  @HiveField(4)
  List<BloodCellModel> shapeCells;

  TotalCellsBlood(
      {required this.wbcQuantities,
      required this.rbcQuantities,
      required this.abnormalQuantities,
      required this.userCells,
      required this.shapeCells});

  int get totalWbcCount => [
        ...wbcQuantities,
        ...abnormalQuantities,
        ...userCells,
      ].fold(0, (previousValue, element) => previousValue + element.quantity);

  TotalCellsBlood.defaultValue(S s)
      : wbcQuantities = [
          BloodCellModel(
            name: 'Linfócitos',
            quantity: 0,
            imagePath: 'linfocito.png',
            title: s.lymphocytesTitle,
          ),
          BloodCellModel(
            name: 'Bastonete',
            quantity: 0,
            imagePath: 'bastonete.png',
            title: s.bastoneteTitle,
          ),
          BloodCellModel(
            name: 'Neutrófilos',
            quantity: 0,
            imagePath: 'neutrofilo.png',
            title: s.neutrophilsTitle,
          ),
          BloodCellModel(
            name: 'Eosinófilos',
            quantity: 0,
            imagePath: 'eosinofilo.png',
            title: s.eosinophilsTitle,
          ),
          BloodCellModel(
            name: 'Basófilos',
            quantity: 0,
            imagePath: 'basofilo.png',
            title: s.basophilsTitle,
          ),
          BloodCellModel(
            name: 'Monocitos',
            quantity: 0,
            imagePath: 'monocito.png',
            title: s.monocytesTitle,
          ),
        ],
        rbcQuantities = [
          BloodCellModel(
            name: 'Eritrócito',
            quantity: 0,
            imagePath: 'eritrocito.png',
            title: s.eritrocytesTitle,
          ),
          BloodCellModel(
            name: 'Plaquetas',
            quantity: 0,
            imagePath: 'plaquetas.png',
            title: s.plateletsTitle,
          ),
          BloodCellModel(
            name: 'Reticulócitos',
            quantity: 0,
            imagePath: 'reticulocitos.png',
            title: s.reticulocitosTitle,
          ),
        ],
        abnormalQuantities = [
          BloodCellModel(
            name: 'Mieloblastos',
            quantity: 0,
            imagePath: 'mieloblastos.png',
            title: s.myeloblastTitle,
          ),
          BloodCellModel(
            name: 'Promielócitos',
            quantity: 0,
            imagePath: 'promielocitos.png',
            title: s.promielocitosTitle,
          ),
          BloodCellModel(
            name: 'Mielócitos',
            quantity: 0,
            imagePath: 'mielocitos.png',
            title: s.mielocitosTitle,
          ),
          BloodCellModel(
            name: 'Metamielócitos',
            quantity: 0,
            imagePath: 'metamielocitos.png',
            title: s.matamielocitosTitle,
          ),
          BloodCellModel(
            name: 'Blastos',
            quantity: 0,
            imagePath: 'blastos.png',
            title: s.blastTitle,
          ),
          BloodCellModel(
            name: 'Hipersegmentados',
            quantity: 0,
            imagePath: 'hipersegmentados.png',
            title: s.hipersegmentadosTitle,
          ),
          BloodCellModel(
            name: 'Pilosas',
            quantity: 0,
            imagePath: 'pilosas.png',
            title: s.pilosasTitle,
          ),
        ],
        shapeCells = [
          BloodCellModel(
            name: 'Eritroblastos',
            quantity: 0,
            imagePath: 'eritroblastos.png',
            title: s.eritroblastosTitle,
          ),
          BloodCellModel(
            name: 'Acantócitos',
            quantity: 0,
            imagePath: 'acantocitos.png',
            title: s.acantocitosTitle,
          ),
          BloodCellModel(
            name: 'Equinócitos',
            quantity: 0,
            imagePath: 'equinocitos.png',
            title: s.equinocitosTitle,
          ),
          BloodCellModel(
            name: 'Eliptócitos',
            quantity: 0,
            imagePath: 'eliptocitos.png',
            title: s.eliptocitosTitle,
          ),
          BloodCellModel(
            name: 'Foices',
            quantity: 0,
            imagePath: 'foices.png',
            title: s.foicesTitle,
          ),
          BloodCellModel(
            name: 'Estomatócitos',
            quantity: 0,
            imagePath: 'estomatocitos.png',
            title: s.estomatocitosTitle,
          ),
          BloodCellModel(
            name: 'Em alvo',
            quantity: 0,
            imagePath: 'alvo.png',
            title: s.alvoTitle,
          ),
          BloodCellModel(
            name: 'Lágrima',
            quantity: 0,
            imagePath: 'lagrima.png',
            title: s.lagrimaTitle,
          ),
          BloodCellModel(
            name: 'Esferócitos',
            quantity: 0,
            imagePath: 'esferocitos.png',
            title: s.esferocitosTitle,
          ),
          BloodCellModel(
            name: 'Contraídas',
            quantity: 0,
            imagePath: 'contraidas.png',
            title: s.contraidasTitle,
          ),
          BloodCellModel(
            name: 'Mordidas',
            quantity: 0,
            imagePath: 'mordida.png',
            title: s.mordidasTitle,
          ),
          BloodCellModel(
            name: 'Em bolha',
            quantity: 0,
            imagePath: 'bolha.png',
            title: s.bolhaTitle,
          ),
          BloodCellModel(
            name: 'Ponteado basófilo',
            quantity: 0,
            imagePath: 'ponteado_basofilo.png',
            title: s.ponteadoTitle,
          ),
          BloodCellModel(
            name: 'Corpúsculo de Howell-Jolly',
            quantity: 0,
            imagePath: 'howell.png',
            title: s.howellTitle,
          ),
          BloodCellModel(
            name: 'Cristais de hemoglobina',
            quantity: 0,
            imagePath: 'cristaish.png',
            title: s.cristaishTitle,
          ),
          BloodCellModel(
            name: 'Micro-organismos intraeritrocitários',
            quantity: 0,
            imagePath: 'moi.png',
            title: s.moiTitle,
          ),
        ],
        userCells = [];

  TotalCellsBlood copyWith({
    List<BloodCellModel>? wbcQuantities,
    List<BloodCellModel>? rbcQuantities,
    List<BloodCellModel>? abnormalQuantities,
    List<BloodCellModel>? userCells,
    List<BloodCellModel>? shapeCells,
  }) {
    return TotalCellsBlood(
      wbcQuantities: wbcQuantities ?? this.wbcQuantities,
      rbcQuantities: rbcQuantities ?? this.rbcQuantities,
      abnormalQuantities: abnormalQuantities ?? this.abnormalQuantities,
      userCells: userCells ?? this.userCells,
      shapeCells: shapeCells ?? this.shapeCells,
    );
  }

  String get reportText =>
      allCells.map((e) => '${e.title}: ${e.quantity}').toList().join('\n');

  List<BloodCellModel> get allCells => [
        ...wbcQuantities,
        ...rbcQuantities,
        ...abnormalQuantities,
        ...userCells,
        ...shapeCells
      ];

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
    shapeCells = updateList(shapeCells);
  }
}
