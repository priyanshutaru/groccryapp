import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:283466351178:ios:11f94d8546d09dc5939cb3',
        apiKey: 'AIzaSyDZMrO_9KcpEJc8yMiIL4oYEi9a5gFOzHI',
        projectId: 'e-commerce-6455a',
        messagingSenderId: '283466351178	',
        iosBundleId: 'com.example.youtubeEcommerce',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:41688973104:android:bf4a0d145f8444d3bb52f5',
        apiKey: 'AIzaSyAzjKg215SXJgPOY3ppMN3sdEuuFWJ7EQ0',
        projectId: 'ecom-b36e8',
        messagingSenderId: '41688973104',
      );
    }
  }
}