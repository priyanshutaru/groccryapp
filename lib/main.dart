import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groccryapp/constants/theme.dart';
import 'package:groccryapp/firebase_helper/firebase_auth_helper.dart';
import 'package:groccryapp/firebase_helper/firebase_option.dart';
import 'package:groccryapp/screens/home/home.dart';
import 'package:groccryapp/screens/welcome/welcome.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
    
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Groccery App',
      theme: themeData,
      home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return  HomePage();
            }
            return  WelcomePage();
          },
        ),
    );
  }
}
