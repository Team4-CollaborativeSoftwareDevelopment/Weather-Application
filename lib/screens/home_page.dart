import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_forecast/const/const.dart';
import 'package:weather_forecast/widgets/fore_cast_tile_widget.dart';
import 'package:weather_forecast/widgets/info_widget.dart';
import 'package:weather_forecast/widgets/weather_tile_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isCelsiusSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            tileMode: TileMode.clamp,
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [Color(colorBg1), Color(colorBg2)],
          )),
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
                  CachedNetworkImage(
                    imageUrl: 'https://openweathermap.org/img/wn/11d@4x.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            const CircularProgressIndicator(),
                    errorWidget: (context, url, err) => const Icon(
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
                      ))
                ],
              ),
              WeatherTileWidget(
                  context: context,
                  title: '28°C',
                  titleFontSize: 60.0,
                  subTitle: 'Douala, Cameroon',
                  date: '5th May 2023',
                  day: 'Friday',
                  time: '10:40 AM'),
              // const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 35,),
                    InfoWidget(icon: FontAwesomeIcons.wind, text: 'Wind 10 km/h'),
                    const SizedBox(
                      height: 10,
                      child: VerticalDivider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                    InfoWidget(icon: FontAwesomeIcons.snowflake, text: 'Hum 54%'),
                    const SizedBox(
                      height: 10,
                      child: VerticalDivider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                    InfoWidget(icon: FontAwesomeIcons.cloud, text: '0.2%'),
                    const Spacer(),
                  ],
                ),

              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ForeCastTileWidget(temp: '28°C', time: '15:00'),
                    ForeCastTileWidget(temp: '28°C', time: '15:00'),
                    ForeCastTileWidget(temp: '28°C', time: '15:00'),
                    ForeCastTileWidget(temp: '28°C', time: '15:00'),
                    ForeCastTileWidget(temp: '28°C', time: '15:00'),
                    ForeCastTileWidget(temp: '28°C', time: '15:00'),
                    ForeCastTileWidget(temp: '28°C', time: '15:00'),
                    ForeCastTileWidget(temp: '28°C', time: '15:00'),
                    ForeCastTileWidget(temp: '28°C', time: '15:00'),
                  ],
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
