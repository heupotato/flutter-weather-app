import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/resources/assets.dart';
import 'package:flutter_weather/services/date_formatter.dart';
import 'package:flutter_weather/services/logger.dart';
import 'package:intl/intl.dart';

extension TimeHandlerWeather on Weather{
  DateTime get initDate => yearMonthDayHour(init);

  DateTime getTrueDate(int timePoint) => this.initDate.add(Duration(hours: timePoint));

  DateTime yearMonthDay(DateTime datetime) => DateTime(datetime.year, datetime.month, datetime.day);

  DateTime yearMonthDayHour(String initDate){
    final year = initDate.substring(0, 4);
    final month = initDate.substring(4, 6);
    final day = initDate.substring(6, 8);
    final hour = initDate.substring(8, initDate.length);
    return DateFormat('yyyy MM dd hh').parse("$year $month $day $hour", true);
  }
}

extension TimeHandlerWeatherData on WeatherData{
  DateTime getTrueDate(DateTime initDate) => initDate.add(Duration(hours:  this.timepoint));
  
  String localTime(DateTime initDate){
   return DateFormatter.time(this.getTrueDate(initDate));
  }
}

extension DayWeatherExtension on Weather{

  List<DayWeather> allDays() {
    List<DayWeather> allDays = [];
    final Map<DateTime, List<WeatherData>> allDaysData =
      groupBy(dataseries, (WeatherData data) {
        return this.yearMonthDay(this.getTrueDate(data.timepoint));
      });
    allDaysData.forEach((key, value) {allDays.add(DayWeather(weathers: value, initDate: this.initDate)); });
    return allDays;
  }

  List<DayWeather> allAvailableDays(){
    DateTime now = DateTime.now().add(Duration(minutes: this.timeOffset ?? 0));
    DateTime yesterday = DateTime(now.year, now.month, now.day).subtract(Duration(hours: 1));
    return this.allDays().where((day) =>
    yesterday.isBefore(this.getTrueDate(day.weathers.first.timepoint).toUtc())).toList();
  }
  DayWeather get today => this.allAvailableDays().first;

}


class DayWeather{
  final DateTime initDate;
  final List<WeatherData> weathers;
  const DayWeather({required this.weathers, required this.initDate});

  String get weekDay{
    return DateFormatter.weekDay(initDate.add(Duration(hours: weathers.first.timepoint)));
  }

  WeatherData get weatherNow{
    DateTime now = DateTime.now().toUtc();
    WeatherData weatherNow = weathers.firstWhere((weatherData) =>
      now.difference(initDate.add(Duration(hours: weatherData.timepoint)).toUtc()).abs().inMinutes <= 90);
    return weatherNow;
  }

  String get typicalWeather{
    String typicalWeather = "";
    int max = 0;
    final Map<String, List<WeatherData>> allWeathers =
    groupBy(weathers, (WeatherData weather) {
      return weather.weather;
    });
    allWeathers.forEach((key, value) {
      if (value.length > max){
        max = value.length;
        typicalWeather = key;
      }
    });
    return typicalWeather;
  }

  int get upperLimitTemp
    => weathers.map((hourData) => hourData.temp2m).toList().reduce(max);

  int get lowerLimitTemp
    => weathers.map((hourData) => hourData.temp2m).toList().reduce(min);
}

extension WeekWeatherExtension on Weather{
  List<String> get weekDays
  => this.getTrueDates(this.weekDayIndexes).map((trueDate) => DateFormatter.weekDay(trueDate)).toList();

  List<int> get weekDayIndexes{
    List<int> indexes = [];
    for (int i = 0; i < dataseries.length - 1; i++){
      if (getTrueDate(dataseries[i].timepoint).day < getTrueDate(dataseries[i + 1].timepoint).day)
        indexes.add(i);
    }
    indexes.add(dataseries.length - 1);
    indexes = indexes.getRange(0, 8).toList();
    return indexes;
  }

  WeekWeather get weekData{
    final indexList = this.weekDayIndexes;
    final List<DayWeather> weekData = [];
    for (int i = 0; i < 8; i++){
      weekData.add(DayWeather
        (day: dataseries.getRange((i != 0) ? i - 1 : 0, indexList[i] + 1).toList()));
    }
    return WeekWeather(weekData: weekData);
  }
}

class DayWeather{
  final List<WeatherData> day;
  const DayWeather({required this.day});

  WeatherData nowData(int nowHour, Weather weatherData){
    WeatherData res = day[day.length - 1];
    for (int i = 0; i < day.length; i++){
      int hour = weatherData.getTrueDate(day[i].timepoint).hour;
      if (hour > nowHour) {
        int prevHour = weatherData.getTrueDate(day[i - 1].timepoint).hour;
        if ((hour - nowHour).abs() < (hour - prevHour).abs())
          return day[i];
        return day[i -1];
      }
    }
    return res;
  }

  int get upperLimitTemp
    => day.map((hourData) => hourData.temp2m).toList().reduce(max);

  int get lowerLimitTemp
    => day.map((hourData) => hourData.temp2m).toList().reduce(min);
}

class WeekWeather{
  final List<DayWeather> weekData;
  const WeekWeather({required this.weekData});
}