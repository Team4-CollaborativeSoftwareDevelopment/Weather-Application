import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_forecast/const/const.dart';

class ForeCastTileWidget extends StatelessWidget {
  String? temp;
  String? time;
  String? weatherCondition;

  ForeCastTileWidget(
      {Key? key,
      required this.temp,
      required this.time,
      required this.weatherCondition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String weatherIcon = getWeatherIcon(weatherCondition);

    return Card(
      elevation: 8,
      color: Color(colorBg3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                temp ?? '',
                style: const TextStyle(color: Colors.white),
              ),
              CachedNetworkImage(
                imageUrl: 'http://openweathermap.org/img/wn/$weatherIcon.png',
                height: 50,
                width: 50,
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, err) => const Icon(
                  Icons.image,
                  color: Colors.white,
                ),
              ),
              Text(
                time ?? '',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getWeatherIcon(String? weatherCondition) {
    if (weatherCondition == 'Clear') {
      return '01d';
    } else if (weatherCondition == 'Clouds') {
      return '02d';
    } else if (weatherCondition == 'Rain') {
      return '10d';
    } else {
      return '01d';
    }
  }
}
