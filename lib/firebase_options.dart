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
    apiKey: 'AIzaSyDeFjbpIcml1zSqZ7M18HW9xA_k4uaXrBo',
    appId: '1:196749980311:web:fc135020a1ac1e8b65efd2',
    messagingSenderId: '196749980311',
    projectId: 'iris-app-7b2b6',
    authDomain: 'iris-app-7b2b6.firebaseapp.com',
    storageBucket: 'iris-app-7b2b6.appspot.com',
    measurementId: 'G-MCNLG44VRT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1K_ByGiFLnT-Cb_b1lM5mAYLKOFz7kT0',
    appId: '1:196749980311:android:43cce3bc9cf2e0b765efd2',
    messagingSenderId: '196749980311',
    projectId: 'iris-app-7b2b6',
    storageBucket: 'iris-app-7b2b6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDg_9UvJtl09yQe0yNkDpaJXzNpZHOz458',
    appId: '1:196749980311:ios:53466eef41c84d0865efd2',
    messagingSenderId: '196749980311',
    projectId: 'iris-app-7b2b6',
    storageBucket: 'iris-app-7b2b6.appspot.com',
    iosBundleId: 'com.example.irisApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDg_9UvJtl09yQe0yNkDpaJXzNpZHOz458',
    appId: '1:196749980311:ios:92fd960a7024f11965efd2',
    messagingSenderId: '196749980311',
    projectId: 'iris-app-7b2b6',
    storageBucket: 'iris-app-7b2b6.appspot.com',
    iosBundleId: 'com.example.irisApp.RunnerTests',
  );
}
