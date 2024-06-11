part of 'cell_count_bloc.dart';

abstract class CellCountState {
  const CellCountState();
}

class CellCountChangeState extends CellCountState {
  final TotalCellsBlood bloodCells;
  final bool isAddMode;

  const CellCountChangeState({
    required this.bloodCells,
    this.isAddMode = true,
  });

  CellCountChangeState copyWith({
    TotalCellsBlood? bloodCells,
    bool? isAddMode,
  }) {
    return CellCountChangeState(
      bloodCells: bloodCells ?? this.bloodCells,
      isAddMode: isAddMode ?? this.isAddMode,
    );
  }

  factory CellCountChangeState.defaultValue(s) {
    return CellCountChangeState(
      bloodCells: TotalCellsBlood.defaultValue(s),
    );
  }

  String get reportText => bloodCells.reportText;

  int get totalWbcCount => bloodCells.totalWbcCount;
}

class CellCountResetState extends CellCountState {
  const CellCountResetState();
}

class CellCountLoadingState extends CellCountState {
  const CellCountLoadingState();
}

class CellCountDeletedState extends CellCountState {
  const CellCountDeletedState();
}

class CellCountSavedState extends CellCountState {
  const CellCountSavedState();
}
