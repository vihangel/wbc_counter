// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wbc_counter/bloc/cell%20count/cell_count_bloc.dart';
import 'package:wbc_counter/bloc/theme/theme_bloc.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/blood_cells_model.dart';
import 'package:wbc_counter/models/saved_report_model.dart';
import 'package:wbc_counter/pages/home/widget/app_bar_widget.dart';
import 'package:wbc_counter/pages/home/widget/drawer_widget.dart';
import 'package:wbc_counter/pages/home/widget/wbc_widget.dart';
import 'package:wbc_counter/pages/report/report_page.dart';

enum WBCType {
  white,
  red,
  abnormal,
  user,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void toggleMode(bool toggleMode) {
    context
        .read<CellCountBloc>()
        .add(IsAddModeChangeEvent(isAddMode: toggleMode));
  }

  void updateQuantity(String wbcName, int newQuantity, WBCType wbc) {
    context
        .read<CellCountBloc>()
        .add(WbcQuantitiesChangeEvent(name: wbcName, quantity: newQuantity));
  }

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    loadConfigs();
  }

  Future<void> loadConfigs() async {
    prefs = await SharedPreferences.getInstance();
    S.load(
        Locale.fromSubtags(languageCode: prefs.getString('language') ?? 'en'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(scaffoldKey: _scaffoldKey),
      drawer: DrawerWidget(
          refresh: () => setState(() {
                context.read<CellCountBloc>().add(CellCountResetEvent());
              })),
      body: SafeArea(
        child: BlocBuilder<CellCountBloc, CellCountState>(
          builder: (context, state) {
            if (state is CellCountChangeState) {
              final totalWbcCount =
                  state.bloodCells.totalWbcCount; // Total count from the model
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTotalCountRow(context, totalWbcCount),
                      _buildModeToggleRow(context,
                          isAdicionarMode: state.isAddMode),
                      const SizedBox(height: 36),
                      _buildCellTypeExpansionTile(
                          context, state, WBCType.white),
                      _buildCellTypeExpansionTile(context, state, WBCType.red),
                      _buildCellTypeExpansionTile(
                          context, state, WBCType.abnormal),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: _buildCalculateButton(context),
    );
  }

  Widget _buildTotalCountRow(BuildContext context, int totalWbcCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${S.of(context).total}: $totalWbcCount',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
            onPressed: () => _clearAllValues(
                  totalWbcCount,
                ),
            child: Text(
              S.of(context).clearAll,
            )),
      ],
    );
  }

  Widget _buildModeToggleRow(BuildContext context,
      {bool isAdicionarMode = true}) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '${S.of(context).mode}:',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: !isAdicionarMode ? Colors.white : null,
            ),
            onPressed: () => toggleMode(true),
            child: Text(S.of(context).add,
                style: TextStyle(
                    color: isAdicionarMode
                        ? context.read<ThemeAppBloc>().theme == ThemeMode.light
                            ? Colors.white
                            : const Color.fromARGB(255, 42, 42, 42)
                        : null)),
          ),
          const SizedBox(
            width: 16.0,
          ),

          ///Remove button

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isAdicionarMode ? Colors.white : null,
            ),
            onPressed: () => toggleMode(false),
            child: Text(S.of(context).remove,
                style: TextStyle(
                    color: !isAdicionarMode
                        ? context.read<ThemeAppBloc>().theme == ThemeMode.light
                            ? Colors.white
                            : const Color.fromARGB(255, 42, 42, 42)
                        : null)),
          ),

          // IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.undo_rounded,
          //       color: Colors.deepPurple,
          //     ))
        ],
      ),
    ]);
  }

  Widget _buildCellTypeExpansionTile(
      BuildContext context, CellCountChangeState state, WBCType cellType) {
    // Filter cells based on the cellType parameter
    List<BloodCellModel> cells = [];
    String title = '';
    switch (cellType) {
      case WBCType.white:
        title = S.of(context).whiteCells;
        cells = state.bloodCells.wbcQuantities;
        break;
      case WBCType.red:
        title = S.of(context).redCells;
        cells = state.bloodCells.rbcQuantities;
        break;
      case WBCType.abnormal:
        title = S.of(context).abnormalCells;
        cells = state.bloodCells.abnormalQuantities;
        break;
      default:
        break;
    }

    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        title,
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
              isAdicionarMode: state.isAddMode,
              onUpdateQuantity: (newQuantity) {
                context.read<CellCountBloc>().add(WbcQuantitiesChangeEvent(
                    name: cell.name, quantity: newQuantity));
                _checkCellCountAndShowAlert(state.bloodCells.totalWbcCount);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCalculateButton(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _navigateToReportPage(context),
          child: Text(S.of(context).calculate,
              style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  void _checkCellCountAndShowAlert(totalWbcCount) {
    int totalQuantity = totalWbcCount + 1;
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

  void _clearAllValues(int wbcQuantities) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).clearValues),
          content: Text(S.of(context).msg_confirmClearAllValues),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).cancel),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CellCountBloc>().add(CellCountResetEvent());
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).confirm,
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
