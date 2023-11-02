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
    apiKey: 'AIzaSyA-zBzJn-2Wkq7t1_EeEJfSq3PQQ8oMZ88',
    appId: '1:69253569246:web:9eb58b38c940fe1c79804f',
    messagingSenderId: '69253569246',
    projectId: 'flutter-afterschool-a4162',
    authDomain: 'flutter-afterschool-a4162.firebaseapp.com',
    storageBucket: 'flutter-afterschool-a4162.appspot.com',
    measurementId: 'G-GQYWLD2JPP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBAKKgBDT46wsvVuEM9zT34x-FWGcFbE1E',
    appId: '1:69253569246:android:91add40d4ccb9ae479804f',
    messagingSenderId: '69253569246',
    projectId: 'flutter-afterschool-a4162',
    storageBucket: 'flutter-afterschool-a4162.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6wzG2rPNdsnKz1b7-8GjxTcldmetnb1U',
    appId: '1:69253569246:ios:d61b75fa5fd38ea379804f',
    messagingSenderId: '69253569246',
    projectId: 'flutter-afterschool-a4162',
    storageBucket: 'flutter-afterschool-a4162.appspot.com',
    iosBundleId: 'com.example.flutterCafeAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD6wzG2rPNdsnKz1b7-8GjxTcldmetnb1U',
    appId: '1:69253569246:ios:2c0aacd868eed28079804f',
    messagingSenderId: '69253569246',
    projectId: 'flutter-afterschool-a4162',
    storageBucket: 'flutter-afterschool-a4162.appspot.com',
    iosBundleId: 'com.example.flutterCafeAdmin.RunnerTests',
  );
}