// Rayan Bou Hassan: 14773067
// Irine Ani: 504800316
// Seongeun Park: 19769021
// Hadi Mustafa: 92547995
// Nwe Thiri May: 16631021
// Mohammad Azim bin Noralfian: 59952421
//samuel Elakhame Oshiobughie: 36723079
// Melbin joy: 60038642
// Karim Moluh Seidou: 37711602
// Kartik Kaushal: 37991316
//Maaz alam shinwari: 40077737
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast/const/const.dart';
import 'package:weather_forecast/widgets/fore_cast_tile_widget.dart';
import 'package:weather_forecast/widgets/info_widget.dart';
import 'package:weather_forecast/widgets/weather_tile_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isCelsiusSelected = true;
  String? weatherIconUrl;
  String? temperature;
  String? location;
  String? date;
  String? day;
  String? time;
  String? windSpeed;
  String? humidity;
  String? cloudiness;
  List<Map<String, String>> forecastData = [];

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  Future<void> checkLocationPermission() async {
    final PermissionStatus status = await Permission.locationWhenInUse.status;
    if (status.isDenied) {
      final PermissionStatus requestedStatus =
          await Permission.locationWhenInUse.request();
      handlePermissionStatus(requestedStatus);
    } else if (status.isGranted) {
      updateWeatherData();
    }
  }

  void handlePermissionStatus(PermissionStatus status) {
    if (status.isGranted) {
      updateWeatherData();
    } else if (status.isDenied) {
    } else if (status.isPermanentlyDenied) {}
  }

  Future<void> updateWeatherData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      await fetchWeatherData(position.latitude, position.longitude);
    } catch (error) {
      print('Error getting location: $error');
    }
  }

  Future<void> fetchWeatherData(double latitude, double longitude) async {
    try {
      String apiKey = 'a11774cc0ecc7486de5b885d1347903a';
      String units = _isCelsiusSelected ? 'metric' : 'imperial';
      String apiUrl =
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=$units';

      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        setState(() {
          weatherIconUrl =
              'https://openweathermap.org/img/wn/${data['weather'][0]['icon']}.png';
          temperature = data['main']['temp'].toStringAsFixed(0) +
              (_isCelsiusSelected ? '°C' : '°F');
          location = data['name'];
          date = DateFormat('d MMMM yyyy').format(DateTime.now());
          day = DateFormat('EEEE').format(DateTime.now());
          time = DateFormat('hh:mm a').format(DateTime.now());
          windSpeed = data['wind']['speed'].toString() + ' km/h';
          humidity = data['main']['humidity'].toString() + '%';
          cloudiness = data['clouds']['all'].toString() + '%';
        });

        await fetchForecastData(latitude, longitude);
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> fetchForecastData(double latitude, double longitude) async {
    try {
      String apiKey = 'a11774cc0ecc7486de5b885d1347903a';
      String units = _isCelsiusSelected ? 'metric' : 'imperial';
      String apiUrl =
          'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=$units';

      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<Map<String, String>> forecastList = [];

        for (var forecast in data['list']) {
          String temp = forecast['main']['temp'].toStringAsFixed(0) +
              (_isCelsiusSelected ? '°C' : '°F');
          String time = DateFormat('HH:mm').format(
              DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000));
          forecastList.add({'temp': temp, 'time': time});
        }

        setState(() {
          forecastData = forecastList;
        });
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.clamp,
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
                const Color(colorBg1).withOpacity(0.9),
                const Color(colorBg2).withOpacity(0.9),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 99,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    weatherIconUrl ?? '',
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: ToggleButtons(
                      isSelected: [_isCelsiusSelected, !_isCelsiusSelected],
                      onPressed: (index) {
                        setState(() {
                          _isCelsiusSelected = index == 0;
                        });
                        updateWeatherData();
                      },
                      color: Colors.white,
                      selectedColor: Colors.white,
                      fillColor: Colors.deepPurple,
                      borderColor: Colors.deepPurple,
                      borderWidth: 2.0,
                      borderRadius: BorderRadius.circular(10.0),
                      constraints: const BoxConstraints.tightFor(
                        width: 25.0,
                        height: 20.0,
                      ),
                      textStyle: const TextStyle(fontSize: 15.0),
                      children: const [
                        Text('C'),
                        Text('F'),
                      ],
                    ),
                  )
                ],
              ),
              WeatherTileWidget(
                context: context,
                title: temperature ?? '',
                titleFontSize: 60.0,
                subTitle: location ?? '',
                date: date ?? '',
                day: day ?? '',
                time: time ?? '',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 35,
                  ),
                  InfoWidget(
                      icon: FontAwesomeIcons.wind, text: 'Wind $windSpeed'),
                  const SizedBox(
                    height: 10,
                    child: VerticalDivider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ),
                  InfoWidget(
                      icon: FontAwesomeIcons.snowflake, text: 'Hum $humidity'),
                  const SizedBox(
                    height: 10,
                    child: VerticalDivider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ),
                  InfoWidget(icon: FontAwesomeIcons.cloud, text: '$cloudiness'),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: forecastData.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ForeCastTileWidget(
                            temp: forecastData[index]['temp'] ?? '',
                            time: forecastData[index]['time'] ?? '',
                            weatherCondition: '',
                          );
                        },
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
