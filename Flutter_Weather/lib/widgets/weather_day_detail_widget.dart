import 'package:flutter/material.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/storage/json_repositories/weather_data_repository.dart';
import 'package:flutter_weather/widgets/icons/weather_type_icon.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherDayDetail extends StatefulWidget {
  final Weather mockWeatherData;
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
    final initTime = _mockWeatherData.initDate.hour;
    double pos = (widget.position == 'bottom') ? 0.75 : 0.1;
    return Column(
      children: [
        VBox(MediaQuery
            .of(context)
            .size
            .height * pos),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ...WeatherInfoDay(dayData, initTime)
          ],
        )
      ],
    );
  }

  WeatherTypeIcon _weatherIcon(String weather) {
    return WeatherTypeIcon(weather: weather);
  }

  List<Widget> WeatherInfoDay(List<WeatherData> dayData, int initTime) {
    List<Widget> _weatherInfoDay = [];
    for (int i = 0; i < 10; i++) {
      if (i % 2 == 0)
        _weatherInfoDay.add(HBox(15));
      else
        _weatherInfoDay.add(WeatherInfoHour(dayData[i ~/ 2], initTime));
    }
    return _weatherInfoDay;
  }

  Container WeatherInfoHour(WeatherData hourData, int initTime) {
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