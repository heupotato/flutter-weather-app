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

  String get weatherTypeName{
    return weatherType;
  //   switch (weatherType) {
  //     case "clearday":
  //       return "Sunny Day";
  //     case "clearnight":
  //       return "Clear night";
  //     case "pcloudyday":
  //       return "Partly Cloudy Day";
  //     case "pcloudynight":
  //       return "Partly Cloudy Night";
  //     case "mcloudyday":
  //       return "mcloudyday";
  //     case "mcloudynight":
  //       return "mcloudynight";
  //     case "cloudyday":
  //       return "Cloudy Day";
  //     case "cloudynight":
  //       return "Cloudy Night";
  //     case "humidday":
  //       return "Humid Day";
  //     case "humidnight":
  //       return "Humid Night";
  //     case "lightrainday":
  //       return "Light Rainy Day";
  //     case "lightrainnight":
  //       return "Light Rainy Night";
  //     case "oshowerday":
  //       return "oshowerday";
  //     case "oshowernight":
  //       return "oshowernight";
  //     case "ishowerday":
  //       return "ishowerday";
  //     case "ishowernight":
  //       return "ishowernight";
  //     case "lightsnowday":
  //       return "Light Snow day";
  //     case "lightsnownight":
  //       return "Light Snow Night";
  //     case "rainday":
  //       return WeatherIcons.day_rain_mix;
  //     case "rainnight":
  //       return WeatherIcons.night_rain_mix;
  //     case "snowday":
  //       return WeatherIcons.day_snow_wind;
  //     case "snownight":
  //       return WeatherIcons.night_snow_wind;
  //     case "rainsnowday":
  //       return WeatherIcons.day_snow_thunderstorm;
  //     case "rainsnownight":
  //       return WeatherIcons.night_snow_thunderstorm;
  //     case "tsday":
  //       return WeatherIcons.day_lightning;
  //     case "tsnight":
  //       return WeatherIcons.night_lightning;
  //     case "tsrainday":
  //       return WeatherIcons.day_thunderstorm;
  //     case "tsrainnight":
  //       return WeatherIcons.night_thunderstorm;
  //   }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          //VBox(MediaQuery.of(context).size.height * 0.5),
          WeatherType(weatherType: weatherTypeName),
          VBox(15),
          TempLimit(lowerLimitTemp: lowerLimitTemp, upperLimitTemp: upperLimitTemp),
          VBox(15),
          CurrentTemp(currentTemp: currentTemp)
        ],
      ),
    );
  }
}

