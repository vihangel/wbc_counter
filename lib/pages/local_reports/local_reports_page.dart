import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbc_counter/bloc/local_reports/local_reports_bloc.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/saved_report_model.dart';
import 'package:wbc_counter/pages/home/home_page.dart';
import 'package:wbc_counter/pages/report/report_page.dart';

class LocalReportPage extends StatelessWidget {
  const LocalReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LocalReportsBloc>().add(ListLocalReportEvent());
    return PopScope(
      onPopInvokedWithResult: (value, result) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).savedReports),
        ),
        body: BlocBuilder<LocalReportsBloc, LocalReportsState>(
          builder: (context, state) {
            if (state is LoadedLocalReportState) {
              return _buildReportList(state.reports);
            } else if (state is ErrorLocalReportState) {
              return Center(
                child: Text(S.of(context).errorLoadingReports),
              );
            } else if (state is LoadingLocalReportState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Container(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildReportList(List<SaveReportModel> reports) {
    final S s = S();
    if (reports.isEmpty) {
      return Center(
        child: Text(s.noReportsSaved),
      );
    } else {
      return ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          return GestureDetector(
            onTap: () {
              _openReportDetails(report, context);
            },
            child: Card(
              elevation: 0,
              surfaceTintColor: Colors.white,
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      report.bloodCells!.totalWbcCount.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                title: Text(report.name ?? ''),
                subtitle: Text('${s.age}: ${report.age}'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      );
    }
  }

  void _openReportDetails(SaveReportModel report, context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReportPage(
          report: report,
          isReadOnly: true,
        ),
      ),
    );
  }
}
