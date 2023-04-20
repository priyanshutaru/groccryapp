// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groccryapp/constants/constants.dart';
import 'package:groccryapp/constants/routes.dart';
import 'package:groccryapp/firebase_helper/firebase_auth_helper.dart';
import 'package:groccryapp/screens/auth/login.dart';
import 'package:groccryapp/screens/home/home.dart';
import 'package:groccryapp/widgets/welcomepage/button.dart';
import 'package:groccryapp/widgets/welcomepage/toptext.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isShowPassword = true;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
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
                  title: "Sign Up",
                  subtitle: "Welcome, Geeks Creat Your First Account"),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "E-Mail",
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
                controller: phone,
                decoration: InputDecoration(
                  hintText: "Phone",
                  prefixIcon: Icon(
                    Icons.call,
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
                buttontext: "Creat An Account",
                onpressed: () async {
                  bool isVaildated = signUpVaildation(
                      email.text, password.text, name.text, phone.text);
                  if (isVaildated) {
                    bool isLogined = await FirebaseAuthHelper.instance
                        .signUp(name.text, email.text, password.text, context);
                    if (isLogined) {
                      // ignore: use_build_context_synchronously
                      Routes.instance.pushAndRemoveUntil(
                          widget: const LoginPage(), context: context);
                    }
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                " I have already an account.",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  "Login Here",
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
