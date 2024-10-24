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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0cyahs1uR-9f_6YlEhEZEezOw7ywmdF8',
    appId: '1:750850442129:android:35952e037e2921e144d030',
    messagingSenderId: '750850442129',
    projectId: 'siya-bank-cdcaa',
    storageBucket: 'siya-bank-cdcaa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBh3TC4vMhqnW6gjgiJm_l84UqE6IpVXww',
    appId: '1:750850442129:ios:365e24437bf099f344d030',
    messagingSenderId: '750850442129',
    projectId: 'siya-bank-cdcaa',
    storageBucket: 'siya-bank-cdcaa.appspot.com',
    iosClientId: '750850442129-8nsnec9p2d6fuvv6mp47mi513ffat5au.apps.googleusercontent.com',
    iosBundleId: 'com.siyabank.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCuvhmYHGwYkpenMMDVye6TxoXQWrJjKCk',
    appId: '1:750850442129:web:16c5d6f1944524ac44d030',
    messagingSenderId: '750850442129',
    projectId: 'siya-bank-cdcaa',
    authDomain: 'siya-bank-cdcaa.firebaseapp.com',
    storageBucket: 'siya-bank-cdcaa.appspot.com',
    measurementId: 'G-T8HD7CK4F4',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBh3TC4vMhqnW6gjgiJm_l84UqE6IpVXww',
    appId: '1:750850442129:ios:df31044bc1337d8d44d030',
    messagingSenderId: '750850442129',
    projectId: 'siya-bank-cdcaa',
    storageBucket: 'siya-bank-cdcaa.appspot.com',
    iosClientId: '750850442129-52ddq1tmsnbf8p3dmfs1jvltl20rm2cm.apps.googleusercontent.com',
    iosBundleId: 'com.siyabank.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCuvhmYHGwYkpenMMDVye6TxoXQWrJjKCk',
    appId: '1:750850442129:web:2f37da8bc7b1ed6f44d030',
    messagingSenderId: '750850442129',
    projectId: 'siya-bank-cdcaa',
    authDomain: 'siya-bank-cdcaa.firebaseapp.com',
    storageBucket: 'siya-bank-cdcaa.appspot.com',
    measurementId: 'G-JDP4GNT34V',
  );

}