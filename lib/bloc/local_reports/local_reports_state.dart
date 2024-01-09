part of 'local_reports_bloc.dart';

abstract class LocalReportsState {}

class InitialLocalReportState extends LocalReportsState {
  InitialLocalReportState();
}

class LoadingLocalReportState extends LocalReportsState {}

class LoadedLocalReportState extends LocalReportsState {
  final List<SaveReportModel> reports;

  LoadedLocalReportState({required this.reports});
}

class ErrorLocalReportState extends LocalReportsState {
  final String message;

  ErrorLocalReportState({required this.message});
}
