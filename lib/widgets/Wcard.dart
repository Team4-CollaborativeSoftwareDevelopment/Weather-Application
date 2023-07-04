import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../const/const.dart';
import '../screens/cities.dart';
import 'info_widget.dart';

class Wcard extends StatelessWidget {
  final String date;
  final String city;
  final String temperature;
  final String humidity;
  final String cloudiness;
  final String windSpeed;
  final List<HourlyForecast> hourlyForecast;

  const Wcard({
    required this.date,
    required this.city,
    required this.temperature,
    required this.humidity,
    required this.cloudiness,
    required this.windSpeed,
    required this.hourlyForecast,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.purple.shade200,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              city,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              temperature,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Humidity: $humidity',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Text(
              'Cloudiness: $cloudiness',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Text(
              'Wind Speed: $windSpeed',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
