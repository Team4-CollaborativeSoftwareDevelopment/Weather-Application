import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoWidget extends StatelessWidget {
  IconData? icon;
  String? text;

  InfoWidget({super.key, this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(icon, color: Colors.white),
        const SizedBox(
          width: 5,
        ),
        Text(
          text ?? '',
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
