import 'package:flutter/material.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/resources/palette.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherType extends StatelessWidget {
  final String weatherType;
  const WeatherType({Key? key, required this.weatherType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Row(
        children: [
          Icon(
            WeatherIcons.night_partly_cloudy,
            color: Palette.white,
            size: 40,
          ),
          HBox(15),
          Text(
            weatherType,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30
            ),
          )
        ],
      );
    }
  }
