import 'package:flutter/material.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/resources/palette.dart';
import 'package:flutter_weather/widgets/current_temp_widget.dart';
import 'package:flutter_weather/widgets/temp_limit_widget.dart';
import 'package:flutter_weather/widgets/weather_type_widget.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherInfo extends StatelessWidget {
  final String weatherType;
  final double upperLimitTemp;
  final double lowerLimitTemp;
  final double currentTemp;

  const WeatherInfo({
    Key? key,
    required this.weatherType,
    required this.upperLimitTemp,
    required this.lowerLimitTemp,
    required this.currentTemp
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          VBox(MediaQuery.of(context).size.height * 0.5),
          WeatherType(weatherType: weatherType),
          VBox(15),
          TempLimit(lowerLimitTemp: lowerLimitTemp, upperLimitTemp: upperLimitTemp),
          VBox(15),
          CurrentTemp(currentTemp: currentTemp)
        ],
      ),
    );
  }
}

