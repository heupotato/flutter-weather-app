import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/widgets/icons/weather_type_icon.dart';
import 'package:flutter_weather/models/weather_extension.dart';
import 'package:flutter_weather/widgets/weather_day_detail_list.dart';
import 'package:flutter_weather/widgets/weather_info_day.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherDayDetail extends StatefulWidget {
  final Weather mockWeatherData;
  const WeatherDayDetail({Key? key, required this.mockWeatherData}) : super(key: key);


  @override
  _WeatherDayDetailState createState() => _WeatherDayDetailState();
}

class _WeatherDayDetailState extends State<WeatherDayDetail> {
  GlobalKey stickyKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Weather _mockWeatherData = widget.mockWeatherData;
    final DateTime _initDate = _mockWeatherData.initDate;
    final List<DayWeather> _allAvailableDays = _mockWeatherData
        .allAvailableDays();
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: _allAvailableDays.length,
              itemBuilder: (context, index) {
                DayWeather dayWeather = _allAvailableDays[index];
                return
                  WeatherDayDetailList(dayWeather: dayWeather);
              },
              scrollDirection: Axis.horizontal,

            )
        ));
  }
}
