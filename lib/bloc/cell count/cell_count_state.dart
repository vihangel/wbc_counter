part of 'cell_count_bloc.dart';

abstract class CellCountState {
  const CellCountState();
}

class CellCountChangeState extends CellCountState {
  final TotalCellsBlood bloodCells;
  final bool isAddMode;
  final List<ReportImageModel> images;

  const CellCountChangeState({
    required this.bloodCells,
    this.isAddMode = true,
    this.images = const [],
  });

  CellCountChangeState copyWith({
    TotalCellsBlood? bloodCells,
    bool? isAddMode,
    List<ReportImageModel>? images,
  }) {
    return CellCountChangeState(
      bloodCells: bloodCells ?? this.bloodCells,
      isAddMode: isAddMode ?? this.isAddMode,
      images: images ?? this.images,
    );
  }

  factory CellCountChangeState.defaultValue(S s) {
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
