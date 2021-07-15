import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherTypeIcon extends StatelessWidget {
  final String weather;
  const WeatherTypeIcon({Key? key, required this.weather}) : super(key: key);

  get WeatherDataIcon{
    switch (weather) {
      case "clearday":
        return WeatherIcons.day_sunny;
      case "clearnight":
        return WeatherIcons.night_clear;
      case "pcloudyday":
        return WeatherIcons.day_cloudy_gusts;
      case "pcloudynight":
        return WeatherIcons.night_partly_cloudy;
      case "mcloudyday":
        return WeatherIcons.day_cloudy_high;
      case "mcloudynight":
        return WeatherIcons.night_cloudy_high;
      case "cloudyday":
        return WeatherIcons.day_cloudy;
      case "cloudynight":
        return WeatherIcons.night_cloudy;
      case "humidday":
        return WeatherIcons.day_fog;
      case "humidnight":
        return WeatherIcons.night_fog;
      case "lightrainday":
        return WeatherIcons.day_rain;
      case "lightrainnight":
        return WeatherIcons.night_rain;
      case "oshowerday":
        return WeatherIcons.day_showers;
      case "oshowernight":
        return WeatherIcons.night_showers;
      case "ishowerday":
        return WeatherIcons.day_storm_showers;
      case "ishowernight":
        return WeatherIcons.night_storm_showers;
      case "lightsnowday":
        return WeatherIcons.day_snow;
      case "lightsnownight":
        return WeatherIcons.night_snow;
      case "rainday":
        return WeatherIcons.day_rain_mix;
      case "rainnight":
        return WeatherIcons.night_rain_mix;
      case "snowday":
        return WeatherIcons.day_snow_wind;
      case "snownight":
        return WeatherIcons.night_snow_wind;
      case "rainsnowday":
        return WeatherIcons.day_snow_thunderstorm;
      case "rainsnownight":
        return WeatherIcons.night_snow_thunderstorm;
      case "tsday":
        return WeatherIcons.day_lightning;
      case "tsnight":
        return WeatherIcons.night_lightning;
      case "tsrainday":
        return WeatherIcons.day_thunderstorm;
      case "tsrainnight":
        return WeatherIcons.night_thunderstorm;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(WeatherDataIcon, color: Colors.white, size: 30);
  }
}
