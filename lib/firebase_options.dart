// Configuracao do projeto Firebase antitela-51de2 (Android + Web).
// Para iOS rode `flutterfire configure`.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
            'Plataforma nao configurada. Rode `flutterfire configure`.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBmJiout02SWJ-w1NpYkVX7JDwmjh1Tk8s',
    appId: '1:113453046028:web:1511ec65146fdec328d129',
    messagingSenderId: '113453046028',
    projectId: 'antitela-51de2',
    authDomain: 'antitela-51de2.firebaseapp.com',
    storageBucket: 'antitela-51de2.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLrvGlhjECZiBiP1EmjF7kbKxDGQAyDNQ',
    appId: '1:113453046028:android:df3162fb9264c06428d129',
    messagingSenderId: '113453046028',
    projectId: 'antitela-51de2',
    storageBucket: 'antitela-51de2.firebasestorage.app',
  );
}
