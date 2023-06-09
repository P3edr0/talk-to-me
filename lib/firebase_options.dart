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

  static FirebaseOptions web = const FirebaseOptions(
    apiKey: 'AIzaSyAoAEpxnxgq0f1mGXy6o7K23T7ioqRa-l4',
    appId: '1:456120066267:web:8e2fbf110118e98822ecfe',
    messagingSenderId: '456120066267',
    projectId: 'talk-to-me-1a0dd',
    authDomain: 'talk-to-me-1a0dd.firebaseapp.com',
    storageBucket: 'talk-to-me-1a0dd.appspot.com',
    measurementId: 'G-Q3MKX59BH1',
  );

  static FirebaseOptions android = const FirebaseOptions(
    apiKey: 'AIzaSyCWSD5iPLTSLsVjD_AuVjONTPOa97F-p9Y',
    appId: '1:456120066267:android:f95b010a52af194b22ecfe',
    messagingSenderId: '456120066267',
    projectId: 'talk-to-me-1a0dd',
    storageBucket: 'talk-to-me-1a0dd.appspot.com',
  );

  static FirebaseOptions ios = const FirebaseOptions(
    apiKey: 'AIzaSyCggt5qmfPlsSgPf8Ko_4HrS_Uun3jSgj8',
    appId: '1:456120066267:ios:1e79f22cb73b3bed22ecfe',
    messagingSenderId: '456120066267',
    projectId: 'talk-to-me-1a0dd',
    storageBucket: 'talk-to-me-1a0dd.appspot.com',
    iosClientId:
        '456120066267-abgsfisuuipbd75jph1kb14bdn0ig2i0.apps.googleusercontent.com',
    iosBundleId: 'com.example.talkToMe',
  );
}
