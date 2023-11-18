class AppConfigModel {
  final bool isDarkTheme;
  final bool isNotificationsEnabled;
  final bool isSoundEnabled;
  final List<int> alertThresholds;
  final String language;

  AppConfigModel({
    required this.isDarkTheme,
    required this.isNotificationsEnabled,
    required this.isSoundEnabled,
    required this.alertThresholds,
    required this.language,
  });

  // Factory method to create a default configuration
  factory AppConfigModel.defaults() {
    return AppConfigModel(
      isDarkTheme: false,
      isNotificationsEnabled: true,
      isSoundEnabled: true,
      alertThresholds: [100],
      language: 'English',
    );
  }

  // Method to create a copy of the current configuration with some changes
  AppConfigModel copyWith({
    bool? isDarkTheme,
    bool? isNotificationsEnabled,
    bool? isSoundEnabled,
    List<int>? alertThresholds,
    String? language,
  }) {
    return AppConfigModel(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isNotificationsEnabled:
          isNotificationsEnabled ?? this.isNotificationsEnabled,
      isSoundEnabled: isSoundEnabled ?? this.isSoundEnabled,
      alertThresholds: alertThresholds ?? this.alertThresholds,
      language: language ?? this.language,
    );
  }
}
