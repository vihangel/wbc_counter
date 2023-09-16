import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  // Theme mode
  bool _isDarkTheme = false;

  // Notifications and sound
  bool _isNotificationsEnabled = true;
  bool _isSoundEnabled = true;
  List<int> _alertThresholds = [];
  List<TextEditingController> _thresholdControllers = [];

  // Language
  String _language = 'English';

  Future<void> loadConfiguration() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
      _isNotificationsEnabled = prefs.getBool('isNotificationsEnabled') ?? true;
      _isSoundEnabled = prefs.getBool('isSoundEnabled') ?? true;
      _alertThresholds =
          (prefs.getStringList('alertThresholds') ?? []).map((threshold) {
        _thresholdControllers
            .add(TextEditingController(text: threshold.toString()));
        return int.tryParse(threshold) ?? 0;
      }).toList();
      _language = prefs.getString('language') ?? 'English';
    });
  }

  // Save configuration data to shared preferences
  Future<void> saveConfiguration() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', _isDarkTheme);
    await prefs.setBool('isNotificationsEnabled', _isNotificationsEnabled);
    await prefs.setBool('isSoundEnabled', _isSoundEnabled);
    await prefs.setStringList('alertThresholds',
        _alertThresholds.map((threshold) => threshold.toString()).toList());
    await prefs.setString('language', _language);
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
            subtitle: Text(_isDarkTheme ? 'Escuro' : 'Claro'),
            trailing: Switch(
              value: _isDarkTheme,
              onChanged: (value) {
                setState(() {
                  _isDarkTheme = value;
                });
                saveConfiguration(); // Save immediately when the theme changes
              },
            ),
          ),

          // Notifications and sound
          ListTile(
            title: Text(notifications),
            subtitle: Text(_isNotificationsEnabled ? 'Ativado' : 'Desativado'),
            trailing: Switch(
              value: _isNotificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _isNotificationsEnabled = value;
                });
                saveConfiguration(); // Save immediately when the theme changes
              },
            ),
          ),
          ListTile(
            title: Text(sound),
            subtitle: Text(_isSoundEnabled ? 'Ativado' : 'Desativado'),
            trailing: Switch(
              value: _isSoundEnabled,
              onChanged: (value) {
                setState(() {
                  _isSoundEnabled = value;
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
              if (_alertThresholds.isNotEmpty)
                for (int index = 0; index < _alertThresholds.length; index++)
                  ListTile(
                    title: TextField(
                      controller: _thresholdControllers[index],
                      decoration: InputDecoration(
                        hintText: _alertThresholds[index].toString(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _alertThresholds[index] = int.tryParse(value) ?? 0;
                        });
                        saveConfiguration();
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _alertThresholds.removeAt(index);
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
                    _alertThresholds.add(0);
                    _thresholdControllers.add(TextEditingController());
                  });
                },
              ),
            ],
          ), // Language
          ListTile(
            title: Text(language),
            subtitle: Text(_language),
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
    // saveConfiguration();
    super.dispose();
  }

  void _resetConfiguration() {
    setState(() {
      _isDarkTheme = false;
      _isNotificationsEnabled = true;
      _isSoundEnabled = true;
      _alertThresholds = List.from([100]);
      _thresholdControllers.clear();
      for (int threshold in _alertThresholds) {
        _thresholdControllers
            .add(TextEditingController(text: threshold.toString()));
      }
      _language = 'English';
    });
    saveConfiguration();
  }
}
