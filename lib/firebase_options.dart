import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {

      return const FirebaseOptions(
          apiKey: "AIzaSyA1DBDbZr1AvgjPkJ2cvhPDruL14OI0nuo",
          authDomain: "practice-e4d6c.firebaseapp.com",
          projectId: "practice-e4d6c",
          storageBucket: "practice-e4d6c.firebasestorage.app",
          messagingSenderId: "624059679438",
          appId: "1:624059679438:web:c105592c57a3430519069f"
      );
    }
}