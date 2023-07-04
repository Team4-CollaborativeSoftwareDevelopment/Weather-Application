import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_forecast/const/const.dart';
import 'package:weather_forecast/screens/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color(colorBg1)));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const Index(),
    );
  }
}
