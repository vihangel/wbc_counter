part of 'cell_count_bloc.dart';

abstract class CellCountState {
  CellCountState();
}

class CellCountChangeState extends CellCountState {
  final Map<String, int> wbcQuantities;
  final int totalWbcCount;
  final List<BloodCellModel> BloodCellModels;

  final bool isAddMode;

  CellCountChangeState(
      {required this.wbcQuantities,
      required this.totalWbcCount,
      required this.BloodCellModels,
      required this.isAddMode});

  CellCountChangeState copyWith(
      {Map<String, int>? wbcQuantities,
      int? totalWbcCount,
      List<BloodCellModel>? BloodCellModels,
      bool? isAddMode}) {
    return CellCountChangeState(
        wbcQuantities: wbcQuantities ?? this.wbcQuantities,
        totalWbcCount: totalWbcCount ?? this.totalWbcCount,
        BloodCellModels: BloodCellModels ?? this.BloodCellModels,
        isAddMode: isAddMode ?? this.isAddMode);
  }

  static CellCountChangeState defaultValue() {
    return CellCountChangeState(
        wbcQuantities: const {
          'Neutrófilo': 0,
          'Basófilo': 0,
          'Eosinófilo': 0,
          'Monócito': 0,
          'Linfócito': 0,
        },
        totalWbcCount: 0,
        BloodCellModels: [
          BloodCellModel(
              name: 'Neutrófilo', quantity: 0, imagePath: 'neutrofilo.png'),
          BloodCellModel(
              name: 'Basófilo', quantity: 0, imagePath: 'basofilo.png'),
          BloodCellModel(
              name: 'Eosinófilo', quantity: 0, imagePath: 'eosinofilo.png'),
          BloodCellModel(
              name: 'Monócito', quantity: 0, imagePath: 'monocito.png'),
          BloodCellModel(
              name: 'Linfócito', quantity: 0, imagePath: 'linfocito.png'),
        ],
        isAddMode: true);
  }
}

class CellCountResetState extends CellCountState {}

class CellCountLoadingState extends CellCountState {}

class CellCountDeletedState extends CellCountState {}

class CellCountSavedState extends CellCountState {}
