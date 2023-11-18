import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wbc_counter/bloc/theme/theme_bloc.dart';
import 'package:wbc_counter/models/config_model.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  AppConfigModel _appConfig = AppConfigModel.defaults();
  final List<TextEditingController> _thresholdControllers = [];

  Future<void> loadConfiguration() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _appConfig = AppConfigModel(
        isDarkTheme: prefs.getBool('isDarkTheme') ?? false,
        isNotificationsEnabled: prefs.getBool('isNotificationsEnabled') ?? true,
        isSoundEnabled: prefs.getBool('isSoundEnabled') ?? true,
        alertThresholds:
            (prefs.getStringList('alertThresholds') ?? []).map((threshold) {
          _thresholdControllers
              .add(TextEditingController(text: threshold.toString()));
          return int.tryParse(threshold) ?? 0;
        }).toList(),
        language: prefs.getString('language') ?? 'English',
      );
    });
  }

  // Save configuration data to shared preferences
  Future<void> saveConfiguration() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _appConfig.isDarkTheme);
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

  @override
  void initState() {
    super.initState();
    loadConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    // Translate the text
    var title = 'Configuração da WBC';
    var themeMode = 'Tema';
    var notifications = 'Notificações';
    var sound = 'Som';
    var alertThresholds = 'Notificar contagem';
    var addNewAlertThreshold = 'Adicionar novo limiar de alerta';
    var language = 'Idioma';
    var resetConfiguration = 'Redefinir configuração';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: [
          // Theme mode
          ListTile(
            title: Text(themeMode),
            subtitle: Text(_appConfig.isDarkTheme ? 'Escuro' : 'Claro'),
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
          ListTile(
            title: Text(notifications),
            subtitle: Text(
                _appConfig.isNotificationsEnabled ? 'Ativado' : 'Desativado'),
            trailing: Switch(
              value: _appConfig.isNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _appConfig =
                      _appConfig.copyWith(isNotificationsEnabled: value);
                });
                saveConfiguration(); // Save immediately when the theme changes
              },
            ),
          ),
          ListTile(
            title: Text(sound),
            subtitle:
                Text(_appConfig.isSoundEnabled ? 'Ativado' : 'Desativado'),
            trailing: Switch(
              value: _appConfig.isSoundEnabled,
              onChanged: (value) {
                setState(() {
                  _appConfig = _appConfig.copyWith(isSoundEnabled: value);
                });
                saveConfiguration(); // Save immediately when the theme changes
              },
            ),
          ),

          // Alerts
          ExpansionTile(
            title: Text(alertThresholds),
            subtitle: const Text('Alertar quando a contagem de WBC atingir:'),
            children: [
              // List of alert thresholds
              if (_appConfig.alertThresholds.isNotEmpty)
                for (int index = 0;
                    index < _appConfig.alertThresholds.length;
                    index++)
                  ListTile(
                    title: TextField(
                      controller: _thresholdControllers[index],
                      decoration: InputDecoration(
                        hintText: _appConfig.alertThresholds[index].toString(),
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
                title: Text(addNewAlertThreshold),
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
            title: Text(language),
            subtitle: Text(_appConfig.language),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Show a dialog to allow the user to select the app language
            },
          ),

          // Reset configuration button
          ListTile(
            title: Text(resetConfiguration),
            subtitle: const Text(
                'Redefinir todas as configurações para seus padrões'),
            trailing: const Icon(Icons.delete),
            onTap: _resetConfiguration,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controllers to avoid memory leaks
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
