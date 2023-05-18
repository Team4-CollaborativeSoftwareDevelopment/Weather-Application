import 'package:flutter/material.dart';

import '../const/const.dart';


class Wcard extends StatelessWidget {
  Wcard({
    Key? key,
    required this.city,
    required this.temperature,
    required this.date,
  }) : super(key: key);

  final String city;
  final String temperature;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(colorBg1), Color(colorBg2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: 300,
        height: 100,// Adjust the width as desired
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Date: $date',
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                ),
              ],
            ),
            Text(
              '$temperature °C',
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}