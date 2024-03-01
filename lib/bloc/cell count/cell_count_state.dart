part of 'cell_count_bloc.dart';

abstract class CellCountState {
  CellCountState();
}

class CellCountChangeState extends CellCountState {
  Map<String, int> wbcQuantities;
  Map<String, int> rbcQuantities;
  Map<String, int> abnormalQuantities;
  Map<String, int> userCells;
  final bool isAddMode;

  CellCountChangeState(
      {required this.wbcQuantities,
      required this.rbcQuantities,
      required this.abnormalQuantities,
      required this.userCells,
      required this.isAddMode});

  CellCountChangeState copyWith(
      {Map<String, int>? wbcQuantities,
      Map<String, int>? rbcQuantities,
      Map<String, int>? abnormalQuantities,
      Map<String, int>? userCells,
      bool? isAddMode}) {
    return CellCountChangeState(
        wbcQuantities: wbcQuantities ?? this.wbcQuantities,
        rbcQuantities: rbcQuantities ?? this.rbcQuantities,
        abnormalQuantities: abnormalQuantities ?? this.abnormalQuantities,
        userCells: userCells ?? this.userCells,
        isAddMode: isAddMode ?? this.isAddMode);
  }

  CellCountChangeState.defaultValue()
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
        isAddMode = true,
        userCells = const {};

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

  Map<String, int> mapByType(WBCType type) {
    switch (type) {
      case WBCType.white:
        return wbcQuantities;
      case WBCType.red:
        return rbcQuantities;
      case WBCType.abnormal:
        return abnormalQuantities;
      case WBCType.user:
        return userCells;
      default:
        return {};
    }
  }

  int get totalWbcCount => allCells.values.reduce((a, b) => a + b);
}

class CellCountResetState extends CellCountState {}

class CellCountLoadingState extends CellCountState {}

class CellCountDeletedState extends CellCountState {}

class CellCountSavedState extends CellCountState {}
