// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groccryapp/constants/constants.dart';
import 'package:groccryapp/constants/routes.dart';
import 'package:groccryapp/firebase_helper/firebase_auth_helper.dart';
import 'package:groccryapp/screens/auth/signup.dart';
import 'package:groccryapp/screens/home/home.dart';
import 'package:groccryapp/widgets/welcomepage/button.dart';
import 'package:groccryapp/widgets/welcomepage/toptext.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, right: 16, bottom: 16, left: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              WelcomeTitle(
                  title: "Welcome Back!",
                  subtitle: "Enter your password and login here"),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "G-Mail",
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: password,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    child: Icon(
                      isShowPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              WelcomeButton(
                buttontext: "Login",
                onpressed: () async{

                 bool isVaildated = loginVaildation(email.text, password.text);
                  if (isVaildated) {
                    bool isLogined = await FirebaseAuthHelper.instance
                        .login(email.text, password.text, context);
                    if (isLogined) {
                      Routes.instance.pushAndRemoveUntil(
                          widget: const HomePage(), context: context);
                    }
                  }


                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "don't have an account??",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()));
                },
                child: Text(
                  "Register Here",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
