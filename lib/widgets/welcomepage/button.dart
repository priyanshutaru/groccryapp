import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  final void Function()? onpressed;
  final String buttontext;
  const WelcomeButton({super.key,this.onpressed,required this.buttontext});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onpressed,
        child: Text(buttontext),
      ),
    );
  }
}
