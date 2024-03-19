// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCU9t27iKkYtTJdmqlx1t2X9nxJiyP-unA',
    appId: '1:996164351991:web:af52480beb8ab15b03e0f2',
    messagingSenderId: '996164351991',
    projectId: 'leucogram-wbc',
    authDomain: 'leucogram-wbc.firebaseapp.com',
    storageBucket: 'leucogram-wbc.appspot.com',
    measurementId: 'G-623WM2LHVD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCutzyXgBIEoYg7byWmiw6fFgDKHZIIWn4',
    appId: '1:996164351991:android:4389b207857a425603e0f2',
    messagingSenderId: '996164351991',
    projectId: 'leucogram-wbc',
    storageBucket: 'leucogram-wbc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCh6ZiAxmyjO5h1V6RhsXEMzn7kImhZX_Q',
    appId: '1:996164351991:ios:3a2fb4756cf2adb403e0f2',
    messagingSenderId: '996164351991',
    projectId: 'leucogram-wbc',
    storageBucket: 'leucogram-wbc.appspot.com',
    iosBundleId: 'com.example.wbcCounter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCh6ZiAxmyjO5h1V6RhsXEMzn7kImhZX_Q',
    appId: '1:996164351991:ios:981ea70d10edc1b403e0f2',
    messagingSenderId: '996164351991',
    projectId: 'leucogram-wbc',
    storageBucket: 'leucogram-wbc.appspot.com',
    iosBundleId: 'com.example.wbcCounter.RunnerTests',
  );
}
