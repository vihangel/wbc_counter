part of 'cell_count_bloc.dart';

abstract class CellCountState {
  CellCountState();
}

class CellCountChangeState extends CellCountState {
  final Map<String, int> wbcQuantities;
  final int totalWbcCount;
  final List<WhiteBloodCell> whiteBloodCells;

  final bool isAddMode;

  CellCountChangeState(
      {required this.wbcQuantities,
      required this.totalWbcCount,
      required this.whiteBloodCells,
      required this.isAddMode});

  CellCountChangeState copyWith(
      {Map<String, int>? wbcQuantities,
      int? totalWbcCount,
      List<WhiteBloodCell>? whiteBloodCells,
      bool? isAddMode}) {
    return CellCountChangeState(
        wbcQuantities: wbcQuantities ?? this.wbcQuantities,
        totalWbcCount: totalWbcCount ?? this.totalWbcCount,
        whiteBloodCells: whiteBloodCells ?? this.whiteBloodCells,
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
        whiteBloodCells: [
          WhiteBloodCell(
              name: 'Neutrófilo', quantity: 0, imagePath: 'neutrofilo.png'),
          WhiteBloodCell(
              name: 'Basófilo', quantity: 0, imagePath: 'basofilo.png'),
          WhiteBloodCell(
              name: 'Eosinófilo', quantity: 0, imagePath: 'eosinofilo.png'),
          WhiteBloodCell(
              name: 'Monócito', quantity: 0, imagePath: 'monocito.png'),
          WhiteBloodCell(
              name: 'Linfócito', quantity: 0, imagePath: 'linfocito.png'),
        ],
        isAddMode: true);
  }
}

class CellCountResetState extends CellCountState {}

class CellCountLoadingState extends CellCountState {}

class CellCountDeletedState extends CellCountState {}

class CellCountSavedState extends CellCountState {}
