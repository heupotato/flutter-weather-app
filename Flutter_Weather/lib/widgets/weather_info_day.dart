import 'package:flutter/material.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/models/weather_extension.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/widgets/icons/weather_type_icon.dart';

class WeatherInfoDay extends StatelessWidget{
  final DayWeather dayData;
  const WeatherInfoDay ({Key? key, required this.dayData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return weatherInfoDay(dayData, dayData.initDate, dayData.timeOffset);
  }

  WeatherTypeIcon _weatherIcon(String weather) {
    return WeatherTypeIcon(weather: weather);
  }

  SizedBox weatherInfoDay(DayWeather dayData, DateTime initDate, int timeOffset) {
    return SizedBox(
      height: dayData.upperLimitTemp*2 + 120,
      child:  ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return _weatherInfoHour(dayData.weathers[index], initDate, timeOffset);
        },
        separatorBuilder: (BuildContext context, int index) => HBox(10),
        itemCount: dayData.weathers.length),
    );
  }

  Column _weatherInfoHour(WeatherData hourData, DateTime initDate, int timeOffset) {
    String currentTime = hourData.localTime(initDate, timeOffset);
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: (hourData.temp2m *2 + 120),
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
         )
        ]
    );
  }
}
