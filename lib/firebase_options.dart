import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyA7euTPE7RRRAiwRmR-PBNDtsevHgk1a7I',
    appId: '1:640592917316:web:c334f55de87a5a05fa1d11',
    messagingSenderId: '640592917316',
    projectId: 'fir-app-2251172529',
    authDomain: 'fir-app-2251172529.firebaseapp.com',
    databaseURL: 'https://fir-app-2251172529.firebaseio.com',
    storageBucket: 'fir-app-2251172529.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqV0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0',
    appId: '1:123456789:android:abcdef123456',
    messagingSenderId: '123456789',
    projectId: 'clinic-management-2251172547',
    databaseURL: 'https://clinic-management-2251172547.firebaseio.com',
    storageBucket: 'clinic-management-2251172547.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqV0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0',
    appId: '1:123456789:ios:abcdef123456',
    messagingSenderId: '123456789',
    projectId: 'clinic-management-2251172547',
    databaseURL: 'https://clinic-management-2251172547.firebaseio.com',
    storageBucket: 'clinic-management-2251172547.appspot.com',
    iosBundleId: 'com.example.flutterApp2251172547',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqV0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0Z0',
    appId: '1:123456789:ios:abcdef123456',
    messagingSenderId: '123456789',
    projectId: 'clinic-management-2251172547',
    databaseURL: 'https://clinic-management-2251172547.firebaseio.com',
    storageBucket: 'clinic-management-2251172547.appspot.com',
    iosBundleId: 'com.example.flutterApp2251172547',
  );
}
