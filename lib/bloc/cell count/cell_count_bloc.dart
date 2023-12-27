import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbc_counter/models/white_blood_cells_model.dart';

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
  }

  void _mapUpdateCellCountToState(WbcQuantitiesChangeEvent event, emit) async {
    final Map<String, int> wbcQuantities = event.wbcQuantities;
    final int totalWbcCount = wbcQuantities.values.reduce((a, b) => a + b);
    final List<WhiteBloodCell> whiteBloodCells = event.whiteBloodCells
        .map((wbc) => wbc.copyWith(quantity: wbcQuantities[wbc.name] ?? 0))
        .toList();
    emit((state as CellCountChangeState).copyWith(
        wbcQuantities: wbcQuantities,
        totalWbcCount: totalWbcCount,
        whiteBloodCells: whiteBloodCells));
  }

  void _mapUpdateIsAddModeToState(IsAddModeChangeEvent event, emit) async {
    emit((state as CellCountChangeState).copyWith(isAddMode: event.isAddMode));
  }

  void _mapResetToState(CellCountResetEvent event, emit) async {
    emit(CellCountChangeState.defaultValue());
  }

  void _mapSaveToState(CellCountSaveEvent event, emit) async {}

  void _mapReportToState(CellCountReportEvent event, emit) async {}
}
