import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbc_counter/db_helper/saved_reports_db/hive_helper_reports.dart';
import 'package:wbc_counter/models/saved_report_model.dart';
import 'package:wbc_counter/pages/home/home_page.dart';
import 'package:wbc_counter/pages/home/mixin/provider_cells.dart';

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

  final TotalCellsBlood wbcQuantities = TotalCellsBlood.defaultValue();

  void _mapUpdateCellCountToState(WbcQuantitiesChangeEvent event, emit) async {
    // Create a new modifiable map from the original unmodifiable map
    Map<String, int> originalMap =
        (state as CellCountChangeState).mapByType(event.wbcType);
    Map<String, int> newMap = Map.from(originalMap);

    // Now you can modify the newMap as it is no longer unmodifiable
    newMap[event.name] = event.quantity;

    switch (event.wbcType) {
      case WBCType.white:
        emit((state as CellCountChangeState).copyWith(
          wbcQuantities: newMap,
        ));
        break;
      case WBCType.red:
        emit((state as CellCountChangeState).copyWith(
          rbcQuantities: newMap,
        ));
        break;
      case WBCType.abnormal:
        emit((state as CellCountChangeState).copyWith(
          abnormalQuantities: newMap,
        ));
        break;
      case WBCType.user:
      default:
        emit((state as CellCountChangeState).copyWith(
          userCells: newMap,
        ));
        break;
    }
  }

  void _mapUpdateIsAddModeToState(IsAddModeChangeEvent event, emit) async {
    emit((state as CellCountChangeState).copyWith(isAddMode: event.isAddMode));
  }

  void _mapResetToState(CellCountResetEvent event, emit) {
    emit(CellCountResetState());
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
