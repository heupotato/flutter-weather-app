import 'package:flutter/material.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/models/weather_extension.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/widgets/icons/weather_type_icon.dart';

class WeatherInfoDay{
  static WeatherTypeIcon _weatherIcon(String weather) {
    return WeatherTypeIcon(weather: weather);
  }

  static List<Widget> weatherInfoDay(DayWeather dayData, DateTime initDate) {
    List<Widget> _weatherInfoDay = [];
    for (int i = 1; i < dayData.weathers.length*2; i++) {
      if (i % 2 == 0)
        _weatherInfoDay.add(HBox(15));
      else{
        _weatherInfoDay.add(_weatherInfoHour(dayData.weathers[i ~/ 2], initDate));
      }
    }
    return _weatherInfoDay;
  }

  static Container _weatherInfoHour(WeatherData hourData, DateTime initDate) {

    // String currentTime = (hourData.hour(initDate) > 12) ?
    // (hourData.hour(initDate)).toString() + "PM"
    //     : (hourData.hour(initDate)).toString() + "AM";
    String currentTime = hourData.localTime(initDate);
    return Container(
      height: hourData.temp2m * 5,
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
}
