import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:groccryapp/constants/theme.dart';
import 'package:groccryapp/firebase_helper/firebase_auth_helper.dart';
import 'package:groccryapp/firebase_helper/firebase_option.dart';
import 'package:groccryapp/provider/app_provider.dart';
import 'package:groccryapp/screens/custom_bottombar/custom_bottombar.dart';
import 'package:groccryapp/screens/home/home.dart';
import 'package:groccryapp/screens/welcome/welcome.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
  "pk_test_51MWx8OAVMyklfe3CsjEzA1CiiY0XBTlHYbZ8jQlGtVFIwQi4aNeGv8J1HUw4rgSavMTLzTwgn0XRlwoTVRFXyu2h00mRUeWmAf";
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
    
  );
  runApp(const MyApp());//bhbjbj
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Groccery App',
        theme: themeData,
        home: StreamBuilder(
            stream: FirebaseAuthHelper.instance.getAuthChange,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return  CustomBottomBar();
              }
              return  WelcomePage();
            },
          ),
      ),
    );
  }
}
