import 'dart:io';
import 'dart:ui';

class AppConfigModel {
  final bool isDarkTheme;
  final bool isNotificationsEnabled;
  final bool isVibrationEnabled;
  final bool isSoundEnabled;
  final List<int> alertThresholds;
  final String language;

  AppConfigModel({
    required this.isDarkTheme,
    required this.isNotificationsEnabled,
    required this.isVibrationEnabled,
    required this.isSoundEnabled,
    required this.alertThresholds,
    required this.language,
  });

  // Factory method to create a default configuration
  factory AppConfigModel.defaults() {
    return AppConfigModel(
      isDarkTheme: false,
      isVibrationEnabled: true,
      isNotificationsEnabled: true,
      isSoundEnabled: true,
      alertThresholds: [100],
      language: Locale(Platform.localeName).languageCode,
    );
  }

  // Method to create a copy of the current configuration with some changes
  AppConfigModel copyWith({
    bool? isDarkTheme,
    bool? isNotificationsEnabled,
    bool? isVibrationEnabled,
    bool? isSoundEnabled,
    List<int>? alertThresholds,
    String? language,
  }) {
    return AppConfigModel(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isNotificationsEnabled:
          isNotificationsEnabled ?? this.isNotificationsEnabled,
      isVibrationEnabled: isVibrationEnabled ?? this.isVibrationEnabled,
      isSoundEnabled: isSoundEnabled ?? this.isSoundEnabled,
      alertThresholds: alertThresholds ?? this.alertThresholds,
      language: language ?? this.language,
    );
  }
}
