import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbc_counter/db_helper/saved_reports_db/hive_helper_reports.dart';
import 'package:wbc_counter/models/saved_report_model.dart';

part 'local_reports_event.dart';
part 'local_reports_state.dart';

class LocalReportsBloc extends Bloc<LocalReportsEvent, LocalReportsState> {
  LocalReportsBloc() : super(InitialLocalReportState()) {
    on<ListLocalReportEvent>(
        (event, emit) async => await _mapListToState(event, emit));
  }

  Future<void> _mapListToState(ListLocalReportEvent event, emit) async {
    emit(LoadingLocalReportState());
    final List<SaveReportModel> reports = await HiveHelper.getReports();
    emit(LoadedLocalReportState(reports: reports));
  }
}
