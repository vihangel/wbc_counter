part of 'cell_count_bloc.dart';

abstract class CellCountEvent {}

class WbcQuantitiesChangeEvent extends CellCountEvent {
  final Map<String, int> wbcQuantities;
  final List<WhiteBloodCell> whiteBloodCells;
  final int totalWbcCount;

  WbcQuantitiesChangeEvent(
      {required this.wbcQuantities,
      required this.whiteBloodCells,
      required this.totalWbcCount});
}

class IsAddModeChangeEvent extends CellCountEvent {
  final bool isAddMode;

  IsAddModeChangeEvent({required this.isAddMode});
}

class CellCountResetEvent extends CellCountEvent {}

class CellCountSaveEvent extends CellCountEvent {
  final SaveReportModel report;

  CellCountSaveEvent({required this.report});
}

class CellCountReportEvent extends CellCountEvent {}

class CellCountDeleteEvent extends CellCountEvent {
  final String id;

  CellCountDeleteEvent({required this.id});
}
