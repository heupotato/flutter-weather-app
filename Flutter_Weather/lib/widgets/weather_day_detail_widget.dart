import 'package:flutter/material.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/widgets/icons/weather_type_icon.dart';
import 'package:flutter_weather/models/weather_extension.dart';

class WeatherDayDetail extends StatefulWidget {
  final Weather mockWeatherData;
  const WeatherDayDetail({Key? key, required this.mockWeatherData}) : super(key: key);

  @override
  _WeatherDayDetailState createState() => _WeatherDayDetailState();
}

class _WeatherDayDetailState extends State<WeatherDayDetail> {
  @override
  Widget build(BuildContext context) {
    final _mockWeatherData = widget.mockWeatherData;
    final DayWeather todayData = _mockWeatherData.today;
    final initTime = _mockWeatherData.initDate.hour;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ..._weatherInfoDay(todayData, initTime)
          ],
        )
      ],
    );
  }

  WeatherTypeIcon _weatherIcon(String weather) {
    return WeatherTypeIcon(weather: weather);
  }

  List<Widget> _weatherInfoDay(DayWeather dayData, int initTime) {
    List<Widget> _weatherInfoDay = [];
    for (int i = 0; i < 10; i++) {
      if (i % 2 == 0)
        _weatherInfoDay.add(HBox(15));
      else
        _weatherInfoDay.add(_weatherInfoHour(dayData.weathers[i ~/ 2], initTime));
    }
    return _weatherInfoDay;
  }

  Container _weatherInfoHour(WeatherData hourData, int initTime) {
    String currentTime = (hourData.timepoint + initTime > 12) ?
    (hourData.timepoint + initTime - 12).toString() + "PM"
        : (hourData.timepoint + initTime).toString() + "AM";

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
