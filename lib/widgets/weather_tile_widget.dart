import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'info_widget.dart';

class WeatherTileWidget extends StatelessWidget {
  BuildContext? context;
  String? title;
  double? titleFontSize;
  String? subTitle;
  String? date;
  String? day;
  String? time;

  WeatherTileWidget(
      {super.key,
      this.context,
      this.title,
      this.titleFontSize,
      this.subTitle,
      this.date,
      this.day,
      this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 35),
            child: Text(
              title ?? '',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 100,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 35),
            child: Text(
              subTitle ?? '',
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 60,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 35),
            child: Text(
              date ?? '',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 35),
                child: Text(
                  day ?? '',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(right: 160),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                      time ?? '',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ))
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 90,
        ),
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 35.0, right: 10.0),
              child: SizedBox(
                width: 180,
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
            ),
            FaIcon(FontAwesomeIcons.circleInfo, color: Colors.white),
          ],
        ),
      ],
    );
  }
}
