import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbc_counter/db_helper/saved_reports_db/hive_helper_reports.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/saved_report_model.dart';
import 'package:wbc_counter/pages/home/model/report_image_model.dart';
import 'package:wbc_counter/pages/home/model/total_cells_blood_model.dart';

part 'cell_count_event.dart';
part 'cell_count_state.dart';

class CellCountBloc extends Bloc<CellCountEvent, CellCountState> {
  CellCountBloc() : super(CellCountChangeState.defaultValue(S())) {
    on<WbcQuantitiesChangeEvent>(_mapUpdateCellCountToState);
    on<IsAddModeChangeEvent>(_mapUpdateIsAddModeToState);
    on<CellCountResetEvent>(_mapResetToState);
    on<CellCountSaveEvent>(_mapSaveToState);
    on<CellCountReportEvent>(_mapReportToState);
    on<CellCountDeleteEvent>(_mapDeleteToState);
    on<AddImageEvent>(_onAddImage);
    on<RemoveImageEvent>(_onRemoveImage);
    on<UpdateImageDataEvent>(_onUpdateImageData);
  }

  void _mapUpdateCellCountToState(
      WbcQuantitiesChangeEvent event, Emitter<CellCountState> emit) {
    // Update specific cell's quantity in the TotalCellsBlood instance
    final TotalCellsBlood updatedBloodCells =
        (state as CellCountChangeState).bloodCells.copyWith();

    updatedBloodCells.updateCellQuantity(event.name, event.quantity);

    emit((state as CellCountChangeState)
        .copyWith(bloodCells: updatedBloodCells));
  }

  void _mapUpdateIsAddModeToState(
      IsAddModeChangeEvent event, Emitter<CellCountState> emit) {
    emit((state as CellCountChangeState).copyWith(isAddMode: event.isAddMode));
  }

  void _mapResetToState(
      CellCountResetEvent event, Emitter<CellCountState> emit) {
    emit(const CellCountResetState());
    emit(CellCountChangeState.defaultValue(S()));
  }

  void _mapSaveToState(
      CellCountSaveEvent event, Emitter<CellCountState> emit) async {
    await HiveHelper.addReport(event.report);
    emit(const CellCountSavedState());
    emit(CellCountChangeState.defaultValue(S()));
  }

  void _mapReportToState(
      CellCountReportEvent event, Emitter<CellCountState> emit) async {
    if (state is CellCountChangeState) {
      final currentState = state as CellCountChangeState;

      final TotalCellsBlood bloodCells = currentState.bloodCells;

      String reportText = bloodCells.reportText;

      if (kDebugMode) {
        print(reportText);
      }
    }
  }

  void _onAddImage(AddImageEvent event, Emitter<CellCountState> emit) {
    final currentState = state as CellCountChangeState;
    emit(currentState.copyWith(
        images: List.from(currentState.images)..add(event.image)));
  }

  void _onRemoveImage(RemoveImageEvent event, Emitter<CellCountState> emit) {
    final currentState = state as CellCountChangeState;
    final List<ReportImageModel> updatedImages = List.from(currentState.images)
      ..removeAt(event.index);
    emit(currentState.copyWith(images: updatedImages));
  }

  void _onUpdateImageData(
      UpdateImageDataEvent event, Emitter<CellCountState> emit) {
    final currentState = state as CellCountChangeState;
    final List<ReportImageModel> updatedImages = List.from(currentState.images);
    final ReportImageModel updatedImage = updatedImages[event.index].copyWith(
      name:
          event.field == 'name' ? event.value : updatedImages[event.index].name,
      coordinates: event.field == 'coordinates'
          ? event.value
          : updatedImages[event.index].coordinates,
    );

    updatedImages[event.index] = updatedImage;
    emit(currentState.copyWith(images: updatedImages));
  }

  void _mapDeleteToState(
      CellCountDeleteEvent event, Emitter<CellCountState> emit) async {
    await HiveHelper.deleteReport(event.id);
    emit(const CellCountDeletedState());
    emit(CellCountChangeState.defaultValue(S()));
  }
}
