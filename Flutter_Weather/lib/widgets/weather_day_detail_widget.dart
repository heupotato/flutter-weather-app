import 'package:flutter/material.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/storage/json_repositories/weather_data_repository.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherDayDetail extends StatefulWidget {
  final Mockjsondata mockWeatherData;
  final String position;
  const WeatherDayDetail({Key? key, required this.mockWeatherData, required this.position}) : super(key: key);

  @override
  _WeatherDayDetailState createState() => _WeatherDayDetailState();
}

class _WeatherDayDetailState extends State<WeatherDayDetail> {
  @override
  Widget build(BuildContext context) {
    final _mockWeatherData = widget.mockWeatherData;
    final dayData = _mockWeatherData.getDayData();
    final initTime = _mockWeatherData.getInitTime();
    double pos = (widget.position == 'bottom') ? 0.75 : 0.1;
    return Column(
      children: [
        VBox(MediaQuery.of(context).size.height*pos),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ...WeatherInfoDay(dayData, initTime)
          ],
        )
      ],
    );
  }
}

_getWeatherDataIcon(String weather)
{
  switch (weather)
  {
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

Icon _weatherIcon(String weather){
  return Icon(_getWeatherDataIcon(weather), color: Colors.white, size: 30);
}

List<Widget> WeatherInfoDay(List<WeatherData> dayData, int initTime){
  List<Widget> _weatherInfoDay = [];
  for (int i = 0; i<10; i++){
    if (i % 2 == 0) _weatherInfoDay.add(HBox(15));
    else _weatherInfoDay.add(WeatherInfoHour(dayData[i~/2], initTime));
  }
  return _weatherInfoDay;
}

Container WeatherInfoHour(WeatherData hourData, int initTime){
  String currentTime = (hourData.timepoint + initTime > 12) ?
      (hourData.timepoint + initTime - 12).toString() + "PM"
      : (hourData.timepoint + initTime ).toString() + "AM";

  return Container(
      height: hourData.temp2m*5,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black54
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _weatherIcon(hourData.weather),
          VBox(20),
          Text(
            "${hourData.temp2m}°C",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
          VBox(15),
          Text(
            "$currentTime",
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 15
            ),
          ), 
          VBox(15)
      ],
  ),
  );
}
