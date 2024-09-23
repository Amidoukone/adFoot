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
    apiKey: 'AIzaSyDovQSaIKR8x_ZF1O-8Fe6v4b2MgdQyzo0',
    appId: '1:909944075766:web:773b6d8cae5630da5e03d7',
    messagingSenderId: '909944075766',
    projectId: 'ad-foot',
    authDomain: 'ad-foot.firebaseapp.com',
    storageBucket: 'ad-foot.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCLLwTp3slt8uhTUhRkQWkhG_HENXsdiD4',
    appId: '1:909944075766:android:b569d608b49a9ee35e03d7',
    messagingSenderId: '909944075766',
    projectId: 'ad-foot',
    storageBucket: 'ad-foot.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA42ZEzkBZcJKPTduaKSqNeycT-kxm84VI',
    appId: '1:909944075766:ios:c301fafdddd069295e03d7',
    messagingSenderId: '909944075766',
    projectId: 'ad-foot',
    storageBucket: 'ad-foot.appspot.com',
    iosBundleId: 'com.example.adFoot',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA42ZEzkBZcJKPTduaKSqNeycT-kxm84VI',
    appId: '1:909944075766:ios:c301fafdddd069295e03d7',
    messagingSenderId: '909944075766',
    projectId: 'ad-foot',
    storageBucket: 'ad-foot.appspot.com',
    iosBundleId: 'com.example.adFoot',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDovQSaIKR8x_ZF1O-8Fe6v4b2MgdQyzo0',
    appId: '1:909944075766:web:d150a987597c62495e03d7',
    messagingSenderId: '909944075766',
    projectId: 'ad-foot',
    authDomain: 'ad-foot.firebaseapp.com',
    storageBucket: 'ad-foot.appspot.com',
  );
}