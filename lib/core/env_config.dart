/// Configuration loaded from environment variables at build time.
///
/// Pass values at build time using:
/// ```
/// flutter run --dart-define=ROBOFLOW_API_KEY=your_key
/// flutter build apk --dart-define=ROBOFLOW_API_KEY=your_key
/// ```
class EnvConfig {
  static const String roboflowApiKey = String.fromEnvironment(
    'ROBOFLOW_API_KEY',
    defaultValue: '',
  );

  static const String roboflowBaseUrl = String.fromEnvironment(
    'ROBOFLOW_BASE_URL',
    defaultValue:
        'https://detect.roboflow.com/blood-cell-detection_new-small-dataset/8',
  );
}
