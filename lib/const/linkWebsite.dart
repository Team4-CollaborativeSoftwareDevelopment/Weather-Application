import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyClickableIcon extends StatelessWidget {
  final String websiteUrl;

  const MyClickableIcon({required this.websiteUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launch(websiteUrl);
      },
      child: FaIcon(FontAwesomeIcons.circleInfo, color: Colors.white),
    );
  }
}
