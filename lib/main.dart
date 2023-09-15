import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wbc_counter/db_helper/saved_reports_db/hive_helper_reports.dart';
import 'package:wbc_counter/home/home_page.dart';
import 'package:wbc_counter/models/saved_report_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  await HiveHelper.openBox();

  await Hive.openBox<SaveReportModel>(
      'DB_REPORT'); // Replace 'reports' with your preferred box name

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WBC Counter',
      theme: ThemeData(
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
          isDense: true,
          filled: true,
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: const TextStyle(
            color: Colors.deepPurple,
          ),
          fillColor: Color.fromARGB(255, 250, 250, 250),
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
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
