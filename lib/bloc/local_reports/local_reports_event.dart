part of 'local_reports_bloc.dart';

abstract class LocalReportsEvent {}

class ListLocalReportEvent extends LocalReportsEvent {}

class RefreshLocalReportEvent extends LocalReportsEvent {}
