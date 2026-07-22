import 'dart:io';

/// Centralized Ad Unit IDs for Google Mobile Ads.
///
/// Banner IDs are platform-specific (Android / iOS).
class AdConstants {
  AdConstants._();

  /// AdMob App ID (also declared in AndroidManifest.xml)
  static const String appId = 'ca-app-pub-8949237085831318~7993683898';

  /// Banner Ad Unit IDs
  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-8949237085831318/5653890190'
      : 'ca-app-pub-8949237085831318/3188047951';
}
