// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groccryapp/constants/asset_images.dart';
import 'package:groccryapp/constants/routes.dart';
import 'package:groccryapp/screens/auth/login.dart';
import 'package:groccryapp/screens/auth/signup.dart';
import 'package:groccryapp/widgets/welcomepage/button.dart';
import 'package:groccryapp/widgets/welcomepage/toptext.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: kToolbarHeight + 12,
            ),
            WelcomeTitle(
                title: "Welcome", subtitle: "All Your Tech Gadget Here"),
            Center(
              child: Image.asset(AssetsImage.instance.welcomeImage),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Icon(
                    Icons.facebook,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Image.asset(
                    AssetsImage.instance.googleImage,
                    scale: 7,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            WelcomeButton(
              buttontext: 'Sign Up',
              onpressed: () {
                Routes.instance.push(widget: SignUpPage(), context: context);
              },
            ),
            SizedBox(
              height: 30,
            ),
            WelcomeButton(
              buttontext: 'Login',
              onpressed: () {
                Routes.instance
                    .push(widget: const LoginPage(), context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
