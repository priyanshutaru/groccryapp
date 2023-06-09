import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groccryapp/constants/constants.dart';
import 'package:groccryapp/firebase_helper/firebase_auth_helper.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Change Password",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          TextFormField(
            controller: newpassword,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: "New Password",
              prefixIcon: const Icon(
                Icons.password_sharp,
              ),
              suffixIcon: CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  )),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          TextFormField(
            controller: confirmpassword,
            obscureText: isShowPassword,
            decoration: const InputDecoration(
              hintText: "Confrim Password",
              prefixIcon: Icon(
                Icons.password_sharp,
              ),
            ),
          ),
          const SizedBox(
            height: 36.0,
          ),
          Container(
            height: 45,
            child: ElevatedButton(
              child: Text("Update"),
              onPressed: () async {
                if (newpassword.text.isEmpty) {
                  toastMessage("New Password is empty");
                } else if (confirmpassword.text.isEmpty) {
                  toastMessage("Confirm Password is empty");
                } else if (confirmpassword.text == newpassword.text) {
                  FirebaseAuthHelper.instance
                      .changePassword(newpassword.text, context);
                } else {
                  toastMessage("Confrim Password is not match");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
