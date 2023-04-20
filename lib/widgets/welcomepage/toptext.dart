import 'package:flutter/material.dart';

class WelcomeTitle extends StatelessWidget {
  final String title, subtitle;
  const WelcomeTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ],
    );
  }
}
