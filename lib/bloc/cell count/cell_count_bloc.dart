import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbc_counter/db_helper/saved_reports_db/hive_helper_reports.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/saved_report_model.dart';
import 'package:wbc_counter/pages/home/mixin/provider_cells.dart';

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
    // Ensure we are working with the correct state
    if (state is CellCountChangeState) {
      final currentState = state as CellCountChangeState;
      // Use the currentState.bloodCells to generate the report
      final TotalCellsBlood bloodCells = currentState.bloodCells;

      // Create the report text or data structure
      String reportText = bloodCells.reportText;

      // Here you could save the report to a database, send it to a server, or simply log it
      // For demonstration, let's just log it
      if (kDebugMode) {
        print(reportText);
      }

      // Optionally, after generating the report, you may want to update the state
      // For instance, if you want to clear the counts after generating the report
      // emit(CellCountResetState());
      // or if you want to keep the state as is, just notify that report generation is done
      // emit(CellCountReportGeneratedState()); // This would be a new state to indicate report has been generated
    }
  }

  void _mapDeleteToState(
      CellCountDeleteEvent event, Emitter<CellCountState> emit) async {
    await HiveHelper.deleteReport(event.id);
    emit(const CellCountDeletedState());
    emit(CellCountChangeState.defaultValue(S()));
  }
}
