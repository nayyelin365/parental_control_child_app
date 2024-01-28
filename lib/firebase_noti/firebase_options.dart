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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2cGWErwW6l53BvR951N9BpCQuUAeS5zg',
    appId: '1:1020012488945:android:361be6813ca7f2aab8a150',
    messagingSenderId: '1020012488945',
    projectId: 'parental-control-app-55894',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0miTMkcjKvwWForn1mW48-Gh8w7wWYn4',
    appId: '1:1069953876642:ios:11f072b48c93b3cf08cdfb',
    messagingSenderId: '1069953876642',
    projectId: 'yoga-master-myanmar',
    // databaseURL: 'https://dhamma-952a1.firebaseio.com',
    // storageBucket: 'yoga-master-notification.appspot.com',
    // iosClientId:
    //     '395218378161-gmavtfdl4ur7c69cb11dai8qcu34vpmr.apps.googleusercontent.com',
    // androidClientId:
    //     "395218378161-cv1qb93nsjne01p9m8d721grjnclv08g.apps.googleusercontent.com",
    iosBundleId: 'com.htut.yogamaster',
  );
}