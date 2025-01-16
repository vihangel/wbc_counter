// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wbc_counter/bloc/cell%20count/cell_count_bloc.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/blood_cells_model.dart';
import 'package:wbc_counter/models/saved_report_model.dart';
import 'package:wbc_counter/pages/home/home_page.dart';
import 'package:wbc_counter/pages/home/mixin/provider_cells.dart';
import 'package:wbc_counter/pages/home/widget/wbc_widget.dart';
import 'package:wbc_counter/pages/report/report_page.dart';

class CellTypeExpansionTileWidget extends StatelessWidget {
  final WBCType cellType;
  final TotalCellsBlood bloodCells;
  final bool isAddMode;

  const CellTypeExpansionTileWidget(
      {super.key,
      required this.cellType,
      required this.bloodCells,
      required this.isAddMode});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        title(context),
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: cells.map((cell) {
            return WBCQuantityWidget(
              name: cell.title,
              quantity: cell.quantity,
              imagePath: cell.imagePath ?? '',
              isAdicionarMode: isAddMode,
              onUpdateQuantity: (newQuantity) {
                context.read<CellCountBloc>().add(WbcQuantitiesChangeEvent(
                    name: cell.name, quantity: newQuantity));
                _checkCellCountAndShowAlert(context, bloodCells.totalWbcCount);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  List<BloodCellModel> get cells {
    switch (cellType) {
      case WBCType.white:
        return bloodCells.wbcQuantities;
      case WBCType.red:
        return bloodCells.rbcQuantities;
      case WBCType.abnormal:
        return bloodCells.abnormalQuantities;
      default:
        return [];
    }
  }

  String title(BuildContext context) {
    switch (cellType) {
      case WBCType.white:
        return S.of(context).whiteCells;
      case WBCType.red:
        return S.of(context).redCells;
      case WBCType.abnormal:
        return S.of(context).abnormalCells;
      default:
        return '';
    }
  }

  Future<void> _checkCellCountAndShowAlert(
      BuildContext context, int totalWbcCount) async {
    int totalQuantity = totalWbcCount + 1;
    final prefs = await SharedPreferences.getInstance();
    final threshold = prefs.getStringList('alertThresholds') ?? [];
    if (threshold.contains((totalQuantity).toString())) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).msg_confirmCalculateCells(totalQuantity)),
            content: Text(S.of(context).sub_msg_confirmCalculateCells),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).continu),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _navigateToReportPage(
                    context,
                  );
                },
                child: Text(S.of(context).calculate,
                    style: const TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    }
  }

  void _navigateToReportPage(BuildContext context) {
    final state = context.read<CellCountBloc>().state;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReportPage(
            report: SaveReportModel(
          bloodCells: (state is CellCountChangeState) ? state.bloodCells : null,
        )),
      ),
    );
  }
}
