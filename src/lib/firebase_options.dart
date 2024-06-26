// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCNIChUVwGXJGYeAHbCfTTUZZlHAu6kiZw',
    appId: '1:64589821414:web:5c4f6f6f79c19dccbed227',
    messagingSenderId: '64589821414',
    projectId: 'wealthwatch-3bdc5',
    authDomain: 'wealthwatch-3bdc5.firebaseapp.com',
    storageBucket: 'wealthwatch-3bdc5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrELUxX1fR7QGhh36oW_w60BCH5fMY5BM',
    appId: '1:64589821414:android:895f15a7b15cfa43bed227',
    messagingSenderId: '64589821414',
    projectId: 'wealthwatch-3bdc5',
    storageBucket: 'wealthwatch-3bdc5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOQtvE23UKA_HNhq1CyjWkraapHjBRKRY',
    appId: '1:64589821414:ios:5e66a5707010990bbed227',
    messagingSenderId: '64589821414',
    projectId: 'wealthwatch-3bdc5',
    storageBucket: 'wealthwatch-3bdc5.appspot.com',
    iosBundleId: 'com.example.wealthwatch',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBOQtvE23UKA_HNhq1CyjWkraapHjBRKRY',
    appId: '1:64589821414:ios:5e66a5707010990bbed227',
    messagingSenderId: '64589821414',
    projectId: 'wealthwatch-3bdc5',
    storageBucket: 'wealthwatch-3bdc5.appspot.com',
    iosBundleId: 'com.example.wealthwatch',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCNIChUVwGXJGYeAHbCfTTUZZlHAu6kiZw',
    appId: '1:64589821414:web:d4e14fe4492ae4f1bed227',
    messagingSenderId: '64589821414',
    projectId: 'wealthwatch-3bdc5',
    authDomain: 'wealthwatch-3bdc5.firebaseapp.com',
    storageBucket: 'wealthwatch-3bdc5.appspot.com',
  );

}