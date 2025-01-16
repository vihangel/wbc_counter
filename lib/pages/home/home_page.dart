// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wbc_counter/bloc/cell%20count/cell_count_bloc.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/saved_report_model.dart';
import 'package:wbc_counter/pages/home/widget/app_bar_widget.dart';
import 'package:wbc_counter/pages/home/widget/cell_type_expansion_tile_widget.dart';
import 'package:wbc_counter/pages/home/widget/characteristic_blood_abnormalities_widget.dart';
import 'package:wbc_counter/pages/home/widget/drawer_widget.dart';
import 'package:wbc_counter/pages/home/widget/mode_toggle_row_widget.dart';
import 'package:wbc_counter/pages/home/widget/total_count_row_widget.dart';
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
  BannerAd? _bannerAd;
  bool _isBannerAdLoaded = false;

  void updateQuantity(String wbcName, int newQuantity, WBCType wbc) {
    context
        .read<CellCountBloc>()
        .add(WbcQuantitiesChangeEvent(name: wbcName, quantity: newQuantity));
  }

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    loadBannerAd();
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
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CellCountBloc, CellCountState>(
                builder: (context, state) {
                  if (state is CellCountChangeState) {
                    final totalWbcCount = state.bloodCells.totalWbcCount;
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Uri uri = Uri.parse(
                                    "https://ufsj.edu.br/portal2-repositorio/File/laact/Atlas%20Hematologia%20Clinica%20220920.pdf");
                                launchUrl(uri);
                              },
                              child: Text(
                                S.of(context).explainCount,
                                style: TextStyle(
                                  color: Colors.red.shade400,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            TotalCountRowWidget(totalWbcCount),
                            ModeToggleRowWidget(
                                isAdicionarMode: state.isAddMode),
                            const SizedBox(height: 36),
                            CellTypeExpansionTileWidget(
                              bloodCells: state.bloodCells,
                              isAddMode: state.isAddMode,
                              cellType: WBCType.white,
                            ),
                            CellTypeExpansionTileWidget(
                              bloodCells: state.bloodCells,
                              isAddMode: state.isAddMode,
                              cellType: WBCType.abnormal,
                            ),
                            CellTypeExpansionTileWidget(
                              bloodCells: state.bloodCells,
                              isAddMode: state.isAddMode,
                              cellType: WBCType.red,
                            ),
                            CharacteristicBloodAbnormalitiesWidget()
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildCalculateButton(context),
    );
  }

  Widget _buildCalculateButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _navigateToReportPage(context),
            child: Text(S.of(context).calculate,
                style: const TextStyle(color: Colors.white)),
          ),
        ),
        if (_isBannerAdLoaded)
          SizedBox(
            height: _bannerAd!.size.height.toDouble(),
            width: _bannerAd!.size.width.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          ),
      ],
    );
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

  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-8949237085831318/5653890190'
          : 'ca-app-pub-8949237085831318/3188047951',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          debugPrint('Ad failed to load: $error');
        },
      ),
    )..load();
  }
}
