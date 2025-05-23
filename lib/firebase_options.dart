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
    apiKey: 'AIzaSyCYcq9rQOt93Th41HxdTaET1QUhap6rVUM',
    appId: '1:251263842815:web:4aab2db2a8bdbd7ba60fca',
    messagingSenderId: '251263842815',
    projectId: 'glamguide-232c7',
    authDomain: 'glamguide-232c7.firebaseapp.com',
    storageBucket: 'glamguide-232c7.firebasestorage.app',
    measurementId: 'G-82L0BC6VV9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBThBiUBHXRBbFlcSEVSA7qhkX6IyQer9k',
    appId: '1:251263842815:android:615314352f2a6b20a60fca',
    messagingSenderId: '251263842815',
    projectId: 'glamguide-232c7',
    storageBucket: 'glamguide-232c7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNjKyTexYItBV6FGznjEyLazqv8FSOjjo',
    appId: '1:251263842815:ios:6189cad66f258017a60fca',
    messagingSenderId: '251263842815',
    projectId: 'glamguide-232c7',
    storageBucket: 'glamguide-232c7.firebasestorage.app',
    iosBundleId: 'com.example.glamguide',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDNjKyTexYItBV6FGznjEyLazqv8FSOjjo',
    appId: '1:251263842815:ios:6189cad66f258017a60fca',
    messagingSenderId: '251263842815',
    projectId: 'glamguide-232c7',
    storageBucket: 'glamguide-232c7.firebasestorage.app',
    iosBundleId: 'com.example.glamguide',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCYcq9rQOt93Th41HxdTaET1QUhap6rVUM',
    appId: '1:251263842815:web:db807681995d9cada60fca',
    messagingSenderId: '251263842815',
    projectId: 'glamguide-232c7',
    authDomain: 'glamguide-232c7.firebaseapp.com',
    storageBucket: 'glamguide-232c7.firebasestorage.app',
    measurementId: 'G-RXTJF2MC54',
  );
}
