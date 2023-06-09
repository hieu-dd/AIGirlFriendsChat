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
    apiKey: 'AIzaSyA0IBo7vkjOus1ZCUMyC95rUmMyDP0k0ho',
    appId: '1:570743299411:android:92687bd9951954ac4a15a6',
    messagingSenderId: '570743299411',
    projectId: 'ai-chatbot-5f565',
    storageBucket: 'ai-chatbot-5f565.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXhE3e5WaejOx6gpBPPGazo3G28o5gSuU',
    appId: '1:570743299411:ios:80a7211f95ab84484a15a6',
    messagingSenderId: '570743299411',
    projectId: 'ai-chatbot-5f565',
    storageBucket: 'ai-chatbot-5f565.appspot.com',
    androidClientId: '570743299411-2jl044189ggb0t2d41nvhsq8vscopa2v.apps.googleusercontent.com',
    iosClientId: '570743299411-cldokoqobetk1os1n55vflsapsnr29il.apps.googleusercontent.com',
    iosBundleId: 'com.d2brothers.aigirls.aiGirlFriends',
  );
}
