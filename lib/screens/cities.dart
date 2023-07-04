import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../const/const.dart';
import '../widgets/Wcard.dart';

class Cities extends StatefulWidget {
  const Cities({Key? key}) : super(key: key);

  @override
  _CitiesState createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  String userInput = '';
  List<WeatherData> cities = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
                width: 20,
              ),
              const Text(
                'Manage Cities',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 40,
                    width: 240,
                    // Adjust the width as desired
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.grey.shade400),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter Location',
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          setState(() {
                            userInput = text;
                          });
                        },
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: Colors.purple.shade300,
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.white,
                      onPressed: () {
                        fetchWeatherData(userInput);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                // Wrap the result cards with Expanded
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final weather = cities[index];
                    return Row(
                      children: [
                        Expanded(
                          child: Wcard(
                            date: weather.date,
                            city: weather.city,
                            temperature: weather.temperature,
                            humidity: weather.humidity,
                            cloudiness: weather.cloudiness,
                            windSpeed: weather.windSpeed,
                            hourlyForecast: [],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: weather.hourlyForecast?.length ?? 0,
                              itemBuilder: (context, index) {
                                final hourlyForecast =
                                    weather.hourlyForecast![index];
                                return HourlyForecastCard(
                                  time: hourlyForecast.time,
                                  temperature: hourlyForecast.temperature,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchWeatherData(String city) async {
    const apiKey = 'a11774cc0ecc7486de5b885d1347903a';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final weatherData = jsonDecode(response.body);
      final temperatureInKelvin = weatherData['main']['temp'];
      final temperatureInCelsius =
          (temperatureInKelvin - 273.15).toInt().toString();
      final currentDateTime =
          DateFormat('dd MMM yyyy HH:mm').format(DateTime.now());
      final hourlyForecastData = await fetchHourlyForecast(city);

      final weather = WeatherData(
        date: currentDateTime,
        city: city,
        temperature: temperatureInCelsius,
        humidity: weatherData['main']['humidity'].toString(),
        cloudiness: weatherData['clouds']['all'].toString(),
        windSpeed: weatherData['wind']['speed'].toString(),
        hourlyForecast: hourlyForecastData,
      );

      setState(() {
        cities.add(weather);
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<List<HourlyForecast>> fetchHourlyForecast(String city) async {
    const apiKey = 'a11774cc0ecc7486de5b885d1347903a';
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final forecastData = jsonDecode(response.body)['list'];

      final hourlyForecastList = forecastData.map<HourlyForecast>((item) {
        final time = DateFormat('HH:mm').format(DateTime.parse(item['dt_txt']));
        final temperatureInKelvin = item['main']['temp'];
        final temperatureInCelsius =
            (temperatureInKelvin - 273.15).toInt().toString();

        return HourlyForecast(time: time, temperature: temperatureInCelsius);
      }).toList();

      return hourlyForecastList;
    } else {
      print('Error: ${response.statusCode}');
      return [];
    }
  }
}

class WeatherData {
  final String date;
  final String city;
  final String temperature;
  final String humidity;
  final String cloudiness;
  final String windSpeed;
  final List<HourlyForecast>? hourlyForecast;

  WeatherData({
    required this.date,
    required this.city,
    required this.temperature,
    required this.humidity,
    required this.cloudiness,
    required this.windSpeed,
    this.hourlyForecast,
  });
}

class HourlyForecast {
  final String time;
  final String temperature;

  HourlyForecast({
    required this.time,
    required this.temperature,
  });
}

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final String temperature;

  const HourlyForecastCard({
    required this.time,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepPurple.shade200,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$temperature°C',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
