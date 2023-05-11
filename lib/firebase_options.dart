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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBA16EyYAi1LQIehXLb3W0hPnwOdCEHmDA',
    appId: '1:839925013952:web:647da7aefdda6250363c25',
    messagingSenderId: '839925013952',
    projectId: 'minhacontabilidade-app',
    authDomain: 'minhacontabilidade-app.firebaseapp.com',
    storageBucket: 'minhacontabilidade-app.appspot.com',
    measurementId: 'G-384VMKT19J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_57DA4xSesjye8LftJRowo43gwq5_63U',
    appId: '1:839925013952:android:4d75ce3be9cc2975363c25',
    messagingSenderId: '839925013952',
    projectId: 'minhacontabilidade-app',
    storageBucket: 'minhacontabilidade-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB9PICPPCcGvAqGLn_O0Nt86K5T7gODfsw',
    appId: '1:839925013952:ios:2c156cd7afe285f0363c25',
    messagingSenderId: '839925013952',
    projectId: 'minhacontabilidade-app',
    storageBucket: 'minhacontabilidade-app.appspot.com',
    iosClientId: '839925013952-elc5gjet3sbhj9pqbu9oasu9thb6febq.apps.googleusercontent.com',
    iosBundleId: 'com.MinhaContabilidadeApp.app',
  );
}