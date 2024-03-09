import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wbc_counter/bloc/cell%20count/cell_count_bloc.dart';
import 'package:wbc_counter/bloc/local_reports/local_reports_bloc.dart';
import 'package:wbc_counter/bloc/theme/theme_bloc.dart';
import 'package:wbc_counter/db_helper/saved_reports_db/hive_helper_reports.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/saved_report_model.dart';
import 'package:wbc_counter/pages/home/home_page.dart';
import 'package:wbc_counter/pages/home/mixin/provider_cells.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Hive.deleteFromDisk();
  await HiveHelper.init();

  await HiveHelper.openBox();

  await Hive.openBox<SaveReportModel>('DB_REPORT');
  await Hive.openBox<TotalCellsBlood>('DB_CELLS');
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString('language') == null) {
    await prefs.setString('language', Platform.localeName);
  }
  lang = prefs.getString('language')!;

  await S.load(Locale.fromSubtags(languageCode: lang));
  runApp(const MyApp());
}

late String lang;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeAppBloc>(create: (context) => ThemeAppBloc()),
        // Add other Blocs as needed

        BlocProvider(create: (context) => CellCountBloc()),
        BlocProvider(create: (context) => LocalReportsBloc()),
      ],
      child: BlocBuilder<ThemeAppBloc, ThemeState>(
        builder: (context, state) {
          final ThemeMode themeMode =
              (state is ThemeChangedState) ? state.themeData : ThemeMode.light;

          return MaterialApp(
            title: 'WBC Counter',
            themeMode: themeMode,
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                background: const Color.fromARGB(
                  255,
                  246,
                  242,
                  252,
                ),
                primary: Colors.deepPurple,
                onPrimary: Colors.white, // <-- this is the change
              ),
              primaryColorDark: Colors.deepPurple,
              primaryColorLight: Colors.deepPurple,
              primaryColor: Colors.deepPurple,
              buttonTheme: const ButtonThemeData(
                buttonColor: Colors.deepPurple, //  <-- dark color
                textTheme: ButtonTextTheme.primary,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 32,
                  ),
                  elevation: 0,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
              dividerColor: Colors.transparent,
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                // isDense: true,
                filled: true,
                // isCollapsed: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                floatingLabelStyle: const TextStyle(
                  color: Colors.deepPurple,
                ),
                fillColor: const Color.fromARGB(255, 250, 250, 250),
                outlineBorder: BorderSide.none,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                    borderSide: BorderSide.none),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(width: 2, color: Colors.red.shade500),
                ),
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorScheme: const ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                background: Color.fromARGB(
                  255,
                  18,
                  18,
                  18,
                ),
              ),
              buttonTheme: const ButtonThemeData(
                buttonColor: Colors.deepPurple, // Dark color for buttons
                textTheme: ButtonTextTheme.primary,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.deepPurple, // Dark color for elevated buttons
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 32,
                  ),
                  elevation: 0,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            //locale: Locale.fromSubtags(languageCode: lang),
            // supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
