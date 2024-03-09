// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wbc_counter/bloc/cell%20count/cell_count_bloc.dart';
import 'package:wbc_counter/bloc/theme/theme_bloc.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/saved_report_model.dart';
import 'package:wbc_counter/pages/home/mixin/provider_cells.dart';
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

class _HomePageState extends State<HomePage> with ProviderCells {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isAdicionarMode = true;

  void toggleMode(bool toggleMode) {
    setState(() {
      isAdicionarMode = toggleMode;
    });
  }

  void updateQuantity(String wbcName, int newQuantity, WBCType wbc) {
    context.read<CellCountBloc>().add(WbcQuantitiesChangeEvent(
        name: wbcName, quantity: newQuantity, wbcType: wbc));
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
      appBar: AppBarWidget(
        scaffoldKey: _scaffoldKey,
      ),
      drawer: DrawerWidget(
        refresh: () => setState(() {}),
      ),
      body: SafeArea(
        child: BlocBuilder(
            bloc: context.read<CellCountBloc>(),
            builder: (context, state) {
              if (state is CellCountChangeState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${S.of(context).total}: ${state.totalWbcCount}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                                onPressed: () => _clearAllValues(
                                      state.totalWbcCount,
                                    ),
                                child: Text(
                                  S.of(context).clearAll,
                                )),
                          ],
                        ),
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
                                backgroundColor:
                                    !isAdicionarMode ? Colors.white : null,
                              ),
                              onPressed: () => toggleMode(true),
                              child: Text(S.of(context).add,
                                  style: TextStyle(
                                      color: isAdicionarMode
                                          ? context
                                                      .read<ThemeAppBloc>()
                                                      .theme ==
                                                  ThemeMode.light
                                              ? Colors.white
                                              : const Color.fromARGB(
                                                  255, 42, 42, 42)
                                          : null)),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),

                            ///Remove button

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isAdicionarMode ? Colors.white : null,
                              ),
                              onPressed: () => toggleMode(false),
                              child: Text(S.of(context).remove,
                                  style: TextStyle(
                                      color: !isAdicionarMode
                                          ? context
                                                      .read<ThemeAppBloc>()
                                                      .theme ==
                                                  ThemeMode.light
                                              ? Colors.white
                                              : const Color.fromARGB(
                                                  255, 42, 42, 42)
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
                        const SizedBox(height: 36),
                        ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            S.of(context).whiteCells,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            Wrap(
                              spacing: 16.0,
                              runSpacing: 16.0,
                              runAlignment: WrapAlignment.center,
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: whiteBloodCell.map((wbc) {
                                return WBCQuantityWidget(
                                  name: wbc.title,
                                  quantity: state.wbcQuantities[wbc.name]!,
                                  imagePath: wbc.imagePath,
                                  isAdicionarMode: isAdicionarMode,
                                  onUpdateQuantity: (newQuantity) {
                                    _checkCellCountAndShowAlert(
                                        state.totalWbcCount + 1);
                                    updateQuantity(
                                        wbc.name, newQuantity, WBCType.white);
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        ExpansionTile(
                            title: Text(
                              S.of(context).redCells,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              Wrap(
                                spacing: 16.0,
                                runSpacing: 16.0,
                                runAlignment: WrapAlignment.center,
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: redBloodCell.map((rbc) {
                                  return WBCQuantityWidget(
                                    name: rbc.title,
                                    quantity: state.rbcQuantities[rbc.name]!,
                                    imagePath: rbc.imagePath,
                                    isAdicionarMode: isAdicionarMode,
                                    onUpdateQuantity: (newQuantity) {
                                      updateQuantity(
                                          rbc.name, newQuantity, WBCType.red);
                                    },
                                  );
                                }).toList(),
                              ),
                            ]),
                        ExpansionTile(
                            title: Text(
                              S.of(context).abnormalCells,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              Wrap(
                                spacing: 16.0,
                                runSpacing: 16.0,
                                runAlignment: WrapAlignment.center,
                                alignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: abnormalBloodCells.map((abc) {
                                  return WBCQuantityWidget(
                                    name: abc.title,
                                    quantity:
                                        state.abnormalQuantities[abc.name]!,
                                    imagePath: abc.imagePath,
                                    isAdicionarMode: isAdicionarMode,
                                    onUpdateQuantity: (newQuantity) {
                                      updateQuantity(abc.name, newQuantity,
                                          WBCType.abnormal);
                                    },
                                  );
                                }).toList(),
                              ),
                            ]),
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _navigateToReportPage(context);
            },
            child: Text(S.of(context).calculate,
                style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  void _checkCellCountAndShowAlert(totalWbcCount) {
    int totalQuantity = totalWbcCount;
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
          bloodCells: (state is CellCountChangeState)
              ? TotalCellsBlood(
                  wbcQuantities: state.wbcQuantities,
                  rbcQuantities: state.rbcQuantities,
                  abnormalQuantities: state.abnormalQuantities,
                  userCells: state.userCells,
                )
              : null,
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
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(S.of(context).cancel),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CellCountBloc>().add(CellCountResetEvent());
                Navigator.of(context).pop(); // Close the dialog
                setState(() {});
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
