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
    apiKey: 'AIzaSyCUCnsSa_peW4Zn3uBIXh1C1UZyyCumnPI',
    appId: '1:1022137539958:web:7ad0c099d217689d2d6e57',
    messagingSenderId: '1022137539958',
    projectId: 'policeapp-3b94c',
    authDomain: 'policeapp-3b94c.firebaseapp.com',
    storageBucket: 'policeapp-3b94c.appspot.com',
    measurementId: 'G-QVMK9NMCNP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCecPchatjTwUPVOoEstqpjdFXvYu_C_Ss',
    appId: '1:1022137539958:android:fff693beae6a65c02d6e57',
    messagingSenderId: '1022137539958',
    projectId: 'policeapp-3b94c',
    storageBucket: 'policeapp-3b94c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvsh8h-U-gIsijIf8C-E2oEQe8aHROBMw',
    appId: '1:1022137539958:ios:c7e494cc9b1694cf2d6e57',
    messagingSenderId: '1022137539958',
    projectId: 'policeapp-3b94c',
    storageBucket: 'policeapp-3b94c.appspot.com',
    androidClientId: '1022137539958-lqc7tvb9ru8jdgmo0fucd5928c1aonqj.apps.googleusercontent.com',
    iosClientId: '1022137539958-ge595qoolpm5f07v3t1m790orrercclb.apps.googleusercontent.com',
    iosBundleId: 'com.example.policeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvsh8h-U-gIsijIf8C-E2oEQe8aHROBMw',
    appId: '1:1022137539958:ios:908ab137ce3e35ab2d6e57',
    messagingSenderId: '1022137539958',
    projectId: 'policeapp-3b94c',
    storageBucket: 'policeapp-3b94c.appspot.com',
    androidClientId: '1022137539958-lqc7tvb9ru8jdgmo0fucd5928c1aonqj.apps.googleusercontent.com',
    iosClientId: '1022137539958-m8uigqcumkrm4s9tpqc64imfmbnejd69.apps.googleusercontent.com',
    iosBundleId: 'com.example.policeApp.RunnerTests',
  );
}
