import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wbc_counter/bloc/theme/theme_bloc.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/config_model.dart';
import 'package:wbc_counter/pages/config/widget/dialog_language_picker.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  ConfigPageState createState() => ConfigPageState();
}

class ConfigPageState extends State<ConfigPage> {
  AppConfigModel _appConfig = AppConfigModel.defaults();
  final List<TextEditingController> _thresholdControllers = [];
  bool loading = false;

  Future<void> loadConfiguration() async {
    loading = true;
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _appConfig = AppConfigModel(
        isVibrationEnabled: prefs.getBool('isVibrationEnabled') ?? true,
        isDarkTheme: prefs.getBool('isDarkTheme') ?? false,
        isNotificationsEnabled: prefs.getBool('isNotificationsEnabled') ?? true,
        isSoundEnabled: prefs.getBool('isSoundEnabled') ?? true,
        alertThresholds:
            (prefs.getStringList('alertThresholds') ?? []).map((threshold) {
          _thresholdControllers
              .add(TextEditingController(text: threshold.toString()));
          return int.tryParse(threshold) ?? 0;
        }).toList(),
        language: prefs.getString('language') ?? Platform.localeName,
      );
      loading = false;
    });
  }

  // Save configuration data to shared preferences
  Future<void> saveConfiguration() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _appConfig.isDarkTheme);
    await prefs.setBool('isVibrationEnabled', _appConfig.isVibrationEnabled);
    await prefs.setBool(
        'isNotificationsEnabled', _appConfig.isNotificationsEnabled);
    await prefs.setBool('isSoundEnabled', _appConfig.isSoundEnabled);
    await prefs.setStringList(
        'alertThresholds',
        _appConfig.alertThresholds
            .map((threshold) => threshold.toString())
            .toList());
    await prefs.setString('language', _appConfig.language);
  }

  final S s = S();
  List<LanguageOption> get languageOptions => [
        LanguageOption('us', s.english, 'assets/flags/us.svg'),
        LanguageOption('br', s.portuguese, 'assets/flags/br.svg'),
        LanguageOption('es', s.spanish, 'assets/flags/es.svg'),
        LanguageOption('fr', s.french, 'assets/flags/fr.svg'),
        LanguageOption('it', s.italian, 'assets/flags/it.svg'),
        LanguageOption('tl', s.tagalog, 'assets/flags/tl.svg'),
        LanguageOption('hi', s.hindi, 'assets/flags/hi.svg'),
        LanguageOption('th', s.thai, 'assets/flags/th.svg'),
        LanguageOption('ar', s.arabic, 'assets/flags/ar.svg'),
        LanguageOption('de', s.german, 'assets/flags/de.svg'),
      ];

  @override
  void initState() {
    super.initState();
    loadConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).configWbc),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: [
            // Theme mode
            ListTile(
              title: Text(S.of(context).mode),
              subtitle: Text(!_appConfig.isDarkTheme
                  ? S.of(context).light
                  : S.of(context).dark),
              trailing: Switch(
                value: _appConfig.isDarkTheme,
                onChanged: (value) {
                  setState(() {
                    _appConfig = _appConfig.copyWith(isDarkTheme: value);
                  });
                  context.read<ThemeAppBloc>().add(ToggleThemeEvent());
                  saveConfiguration(); // Save immediately when the theme changes
                },
              ),
            ),

            // Notifications and sound
            // ListTile(
            //   title: Text(notifications),
            //   subtitle: Text(
            //       _appConfig.isNotificationsEnabled ? 'Ativado' : 'Desativado'),
            //   trailing: Switch(
            //     value: _appConfig.isNotificationsEnabled,
            //     onChanged: (value) {
            //       setState(() {
            //         _appConfig =
            //             _appConfig.copyWith(isNotificationsEnabled: value);
            //       });
            //       saveConfiguration(); // Save immediately when the theme changes
            //     },
            //   ),
            // ),
            ListTile(
              title: Text(S.of(context).sound),
              subtitle: Text(_appConfig.isSoundEnabled
                  ? S.of(context).enabled
                  : S.of(context).disabled),
              trailing: Switch(
                value: _appConfig.isSoundEnabled,
                onChanged: (value) {
                  setState(() {
                    _appConfig = _appConfig.copyWith(isSoundEnabled: value);
                  });
                  saveConfiguration();
                },
              ),
            ),
            ListTile(
              title: Text(S.of(context).vibration),
              subtitle: Text(_appConfig.isVibrationEnabled
                  ? S.of(context).enabled
                  : S.of(context).disabled),
              trailing: Switch(
                value: _appConfig.isVibrationEnabled,
                onChanged: (value) {
                  setState(() {
                    _appConfig = _appConfig.copyWith(isVibrationEnabled: value);
                  });
                  saveConfiguration(); // Save immediately when the theme changes
                },
              ),
            ),

            // Alerts
            ExpansionTile(
              title: Text(S.of(context).alertThresholds),
              subtitle: Text(S.of(context).alertToCount),
              children: [
                // List of alert thresholds
                if (_appConfig.alertThresholds.isNotEmpty && !loading)
                  for (int index = 0;
                      index < _appConfig.alertThresholds.length;
                      index++)
                    ListTile(
                      title: TextField(
                        controller: _thresholdControllers[index],
                        decoration: InputDecoration(
                          hintText:
                              _appConfig.alertThresholds[index].toString(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _appConfig.alertThresholds[index] =
                                int.tryParse(value) ?? 0;
                          });
                          saveConfiguration();
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _appConfig.alertThresholds.removeAt(index);
                            _thresholdControllers.removeAt(index);
                          });
                          saveConfiguration(); // Save immediately when the theme changes
                        },
                      ),
                    ),

                // Add new alert threshold button
                ListTile(
                  title: Text(S.of(context).addNewAlertThreshold),
                  trailing: const Icon(Icons.add),
                  onTap: () {
                    // Add a new alert threshold to the list of alert thresholds
                    setState(() {
                      _appConfig.alertThresholds.add(0);
                      _thresholdControllers.add(TextEditingController());
                    });
                  },
                ),
              ],
            ), // Language
            ListTile(
              title: Text(S.of(context).language),
              leading: SvgPicture.asset(
                  'assets/flags/${(_appConfig.language.length > 2 ? (_appConfig.language).substring(3, 5).toLowerCase() : _appConfig.language)}.svg',
                  width: 30,
                  height: 20),
              subtitle: Text(_appConfig.language),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                _showDialogPickerCountry();
              },
            ),

            // Reset configuration button
            ListTile(
              title: Text(S.of(context).resetConfiguration),
              subtitle: const Text(''),
              trailing: const Icon(Icons.delete),
              onTap: _resetConfiguration,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDialogPickerCountry() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).selectLanguage),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: languageOptions.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: SvgPicture.asset(languageOptions[index].flagAsset,
                      width: 30, height: 20),
                  title: Text(languageOptions[index].languageName),
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(
                        'language', languageOptions[index].languageCode);

                    await S.load(Locale.fromSubtags(
                        languageCode: languageOptions[index].languageCode));
                    setState(() {
                      _appConfig = _appConfig.copyWith(
                          language: languageOptions[index].languageCode);
                    });
                    await saveConfiguration();

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
    /*    DialogPicker(
      languageOptions: languageOptions,
      onSelectLanguage: (selectedLanguageCode) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('language', selectedLanguageCode);

        setState(() {
          _appConfig = _appConfig.copyWith(language: selectedLanguageCode);
        });

        S.load(Locale(selectedLanguageCode));
        saveConfiguration();
      },
    ); */
  }

  @override
  void dispose() {
    for (var controller in _thresholdControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _resetConfiguration() {
    setState(() {
      _appConfig = AppConfigModel.defaults();
      _thresholdControllers.clear();
      for (int threshold in _appConfig.alertThresholds) {
        _thresholdControllers
            .add(TextEditingController(text: threshold.toString()));
      }
    });
    saveConfiguration();
  }
}
