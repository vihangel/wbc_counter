import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbc_counter/bloc/local_reports/local_reports_bloc.dart';
import 'package:wbc_counter/home/home_page.dart';
import 'package:wbc_counter/models/saved_report_model.dart';
import 'package:wbc_counter/report/report_page.dart';

class LocalReportPage extends StatelessWidget {
  const LocalReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LocalReportsBloc>().add(ListLocalReportEvent());
    return PopScope(
      onPopInvoked: (value) {
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
          title: const Text('Salvos'),
        ),
        body: BlocBuilder<LocalReportsBloc, LocalReportsState>(
          builder: (context, state) {
            if (state is LoadedLocalReportState) {
              return _buildReportList(state.reports);
            } else if (state is ErrorLocalReportState) {
              return const Center(
                child: Text('Erro ao carregar relatórios'),
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
    if (reports.isEmpty) {
      return const Center(
        child: Text('Ainda não há relatórios salvos'),
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
                      ///total cells
                      report.bloodCells?.reportText ?? '',
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
                subtitle: Text('Idade: ${report.age}'),
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
