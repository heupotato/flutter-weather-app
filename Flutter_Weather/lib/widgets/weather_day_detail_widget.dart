import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/packages/dafluta/dafluta.dart';
import 'package:flutter_weather/widgets/icons/weather_type_icon.dart';
import 'package:flutter_weather/models/weather_extension.dart';
import 'package:flutter_weather/widgets/weather_day_detail_list.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherDayDetail extends StatefulWidget {
  final Weather mockWeatherData;
  const WeatherDayDetail({Key? key, required this.mockWeatherData}) : super(key: key);

  @override
  _WeatherDayDetailState createState() => _WeatherDayDetailState();
}

class _WeatherDayDetailState extends State<WeatherDayDetail> {
  @override
  Widget build(BuildContext context) {
    final Weather _mockWeatherData = widget.mockWeatherData;
    final DateTime _initDate = _mockWeatherData.initDate;
    final List<DayWeather> _allAvailableDays = _mockWeatherData.allAvailableDays();
    return Padding(
        padding: EdgeInsets.fromLTRB(0,0,0, 0),
        child: SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: _allAvailableDays.length,
            itemBuilder: (context, index){
              DayWeather dayWeather = _allAvailableDays[index];
              return
                WeatherDayDetailList(weatherInfoDay: _weatherInfoDay(dayWeather, _initDate), weekDay: dayWeather.weekDay,);
            },
            scrollDirection: Axis.horizontal,

      )
    ));
  }

  WeatherTypeIcon _weatherIcon(String weather) {
    return WeatherTypeIcon(weather: weather);
  }

  List<Widget> _weatherInfoDay(DayWeather dayData, DateTime initDate) {
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

  Container _weatherInfoHour(WeatherData hourData, DateTime initDate) {

    // String currentTime = (hourData.hour(initDate) > 12) ?
    // (hourData.hour(initDate)).toString() + "PM"
    //     : (hourData.hour(initDate)).toString() + "AM";
    String currentTime = hourData.localTime(initDate);
    print(currentTime);
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
