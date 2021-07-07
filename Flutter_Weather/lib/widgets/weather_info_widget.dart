import 'package:flutter/material.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/resources/palette.dart';
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
          VBox(MediaQuery.of(context).size.height * 0.65),
          WeatherType(weatherType),
          VBox(15),
          TempLimit(upperLimitTemp, lowerLimitTemp),
          VBox(15),
          CurrentTemp(currentTemp)
        ],
      ),
    );
  }
}

Row WeatherType(String weatherType) {
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

Row TempLimit(double upperLimitTemp, double lowerLimitTemp) {
  return Row(
    children: [
      Icon(Icons.arrow_upward_sharp,
        color: Palette.white,
        size: 20,),
      HBox(20),
      Text(
          "$upperLimitTemp°C",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30
          )
      ),
      HBox(40),
      Icon(Icons.arrow_downward_sharp,
        color: Palette.white,
        size: 20,),
      HBox(20),
      Text(
          "$lowerLimitTemp°C",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30
          )
      ),
    ],
  );
}

Align CurrentTemp(double currentTemp){
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
        "$currentTemp°",
        style: TextStyle(
          color: Colors.white,
          fontSize: 100,
        )
    ),
  );
}
