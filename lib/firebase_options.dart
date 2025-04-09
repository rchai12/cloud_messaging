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
    apiKey: 'AIzaSyBfBc0H-Qjxb1_BzR-lQKS2SN0x1k5Pr8s',
    appId: '1:777373976161:web:6dc1fcd2eb06de9ad9cc20',
    messagingSenderId: '777373976161',
    projectId: 'profile-app-eeb4b',
    authDomain: 'profile-app-eeb4b.firebaseapp.com',
    storageBucket: 'profile-app-eeb4b.firebasestorage.app',
    measurementId: 'G-EWFWY8XC2H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAlr1EoOsbJmxZLjiHEgetI_d9_u6lY1C4',
    appId: '1:777373976161:android:0e9efe5c1a7a997bd9cc20',
    messagingSenderId: '777373976161',
    projectId: 'profile-app-eeb4b',
    storageBucket: 'profile-app-eeb4b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4UFkxiCTVijHXQXyiPdK7DX1TUQOHrWQ',
    appId: '1:777373976161:ios:ad432aab9d8fd556d9cc20',
    messagingSenderId: '777373976161',
    projectId: 'profile-app-eeb4b',
    storageBucket: 'profile-app-eeb4b.firebasestorage.app',
    iosBundleId: 'com.example.activity14',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4UFkxiCTVijHXQXyiPdK7DX1TUQOHrWQ',
    appId: '1:777373976161:ios:ad432aab9d8fd556d9cc20',
    messagingSenderId: '777373976161',
    projectId: 'profile-app-eeb4b',
    storageBucket: 'profile-app-eeb4b.firebasestorage.app',
    iosBundleId: 'com.example.activity14',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBfBc0H-Qjxb1_BzR-lQKS2SN0x1k5Pr8s',
    appId: '1:777373976161:web:1e6bc5c41329e15fd9cc20',
    messagingSenderId: '777373976161',
    projectId: 'profile-app-eeb4b',
    authDomain: 'profile-app-eeb4b.firebaseapp.com',
    storageBucket: 'profile-app-eeb4b.firebasestorage.app',
    measurementId: 'G-NNXJMBSJ2S',
  );

}