part of 'cell_count_bloc.dart';

abstract class CellCountEvent {}

class WbcQuantitiesChangeEvent extends CellCountEvent {
  final String name;
  final int quantity;

  WbcQuantitiesChangeEvent({
    required this.name,
    required this.quantity,
  });
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

class AddImageEvent extends CellCountEvent {
  final ReportImageModel image;
  AddImageEvent(this.image);
}

class RemoveImageEvent extends CellCountEvent {
  final int index;
  RemoveImageEvent(this.index);
}

class UpdateImageDataEvent extends CellCountEvent {
  final int index;
  final String field;
  final String value;
  UpdateImageDataEvent(this.index, this.field, this.value);
}
