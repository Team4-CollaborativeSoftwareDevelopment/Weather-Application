import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_forecast/const/const.dart';

class WeatherForecastScreen extends StatefulWidget {
  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  String apiKey = 'a11774cc0ecc7486de5b885d1347903a';
  List<WeatherData> _forecastData = [];

  @override
  void initState() {
    super.initState();
    _fetchForecastData();
  }

  Future<void> _fetchForecastData() async {
    String url =
        'https://api.openweathermap.org/data/2.5/forecast?q=Dubai&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> forecastList = jsonData['list'];
        List<WeatherData> forecastData = [];

        Map<DateTime, List<WeatherData>> groupedData = {};
        for (var item in forecastList) {
          final weatherData = WeatherData.fromJson(item);
          final DateTime dateOnly = DateTime(weatherData.dateTime.year,
              weatherData.dateTime.month, weatherData.dateTime.day);

          groupedData[dateOnly] ??= [];
          groupedData[dateOnly]!.add(weatherData);
        }

        groupedData.forEach((date, dataList) {
          final selectedData = dataList.first;
          forecastData.add(selectedData);
        });

        setState(() {
          _forecastData = forecastData;
        });
      } else {
        print('Failed to fetch forecast data. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching forecast data: $error');
    }
  }

  double convertKelvinToCelsius(double temperatureKelvin) {
    return temperatureKelvin - 273.15;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('5-Day Forecast'),
        centerTitle: true,
        elevation: 4.0,
        backgroundColor: Colors.purple.shade300,
      ),
      body: _buildForecastList(),
    );
  }

  Widget _buildForecastList() {
    if (_forecastData.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: _forecastData.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildWeatherCard(_forecastData[index]);
        },
      );
    }
  }

  Widget _buildWeatherCard(WeatherData weatherData) {
    final day = weatherData.dateTime.day;
    final month = weatherData.dateTime.month;
    final temperature =
        '${convertKelvinToCelsius(weatherData.temperature).toStringAsFixed(0)}°C';
    final weatherCondition = weatherData.weatherCondition;
    final weatherIcon = weatherData.weatherIcon;

    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$day/$month',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  temperature,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  weatherCondition,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            Image.network(
              'http://openweathermap.org/img/wn/$weatherIcon.png',
              width: 50,
              height: 50,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherData {
  final DateTime dateTime;
  final double temperature;
  final String weatherCondition;
  final String weatherIcon;

  WeatherData({
    required this.dateTime,
    required this.temperature,
    required this.weatherCondition,
    required this.weatherIcon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true)
            .toLocal();
    final temperature = json['main']['temp'].toDouble();
    final weatherCondition = json['weather'][0]['main'];
    final weatherIcon = json['weather'][0]['icon'];

    return WeatherData(
      dateTime: dateTime,
      temperature: temperature,
      weatherCondition: weatherCondition,
      weatherIcon: weatherIcon,
    );
  }
}
