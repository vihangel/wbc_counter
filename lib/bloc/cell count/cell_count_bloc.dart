import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbc_counter/db_helper/saved_reports_db/hive_helper_reports.dart';
import 'package:wbc_counter/models/blood_cells_model.dart';
import 'package:wbc_counter/models/saved_report_model.dart';

part 'cell_count_event.dart';
part 'cell_count_state.dart';

class CellCountBloc extends Bloc<CellCountEvent, CellCountState> {
  CellCountBloc() : super(CellCountChangeState.defaultValue()) {
    on<WbcQuantitiesChangeEvent>(
        (event, emit) => _mapUpdateCellCountToState(event, emit));
    on<IsAddModeChangeEvent>(
        (event, emit) => _mapUpdateIsAddModeToState(event, emit));
    on<CellCountResetEvent>((event, emit) => _mapResetToState(event, emit));
    on<CellCountSaveEvent>((event, emit) => _mapSaveToState(event, emit));
    on<CellCountReportEvent>((event, emit) => _mapReportToState(event, emit));
    on<CellCountDeleteEvent>((event, emit) => _mapDeleteToState(event, emit));
  }

  void _mapUpdateCellCountToState(WbcQuantitiesChangeEvent event, emit) async {
    final Map<String, int> wbcQuantities = event.wbcQuantities;
    final int totalWbcCount = wbcQuantities.values.reduce((a, b) => a + b);
    final List<BloodCellModel> BloodCellModels = event.BloodCellModels.map(
        (wbc) => wbc.copyWith(quantity: wbcQuantities[wbc.name] ?? 0)).toList();
    emit((state as CellCountChangeState).copyWith(
        wbcQuantities: wbcQuantities,
        totalWbcCount: totalWbcCount,
        BloodCellModels: BloodCellModels));
  }

  void _mapUpdateIsAddModeToState(IsAddModeChangeEvent event, emit) async {
    emit((state as CellCountChangeState).copyWith(isAddMode: event.isAddMode));
  }

  void _mapResetToState(CellCountResetEvent event, emit) async {
    emit(CellCountChangeState.defaultValue());
  }

  void _mapSaveToState(CellCountSaveEvent event, emit) async {
    /// emit(CellCountLoadingState()); /// Is too fast

    await HiveHelper.addReport(event.report);
    emit(CellCountSavedState());
    emit(CellCountChangeState.defaultValue());
  }

  void _mapReportToState(CellCountReportEvent event, emit) async {}

  void _mapDeleteToState(CellCountDeleteEvent event, emit) async {
    ///  emit(CellCountLoadingState());  /// Is too fast
    await HiveHelper.deleteReport(event.id);
    emit(CellCountDeletedState());
    emit(CellCountChangeState.defaultValue());
  }
}
