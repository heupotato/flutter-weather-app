import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter_weather/models/index.dart';
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
  int hour(DateTime initDate) => initDate.add(Duration(hours:  this.timepoint)).hour;
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

  WeatherData ? get weatherNow{
    try {
      DateTime now = DateTime.now();
      return weathers.firstWhere((weatherData) =>
        now.difference(initDate.add(Duration(hours: weathers.first.timepoint))).inMinutes <= 90);
    } on Exception catch (e) {
      Logger.logError(
      className: "Day Weather",
      methodName: "get WeatherNow",
      message: e.toString());
    }
  }

  int get upperLimitTemp
    => weathers.map((hourData) => hourData.temp2m).toList().reduce(max);

  int get lowerLimitTemp
    => weathers.map((hourData) => hourData.temp2m).toList().reduce(min);
}

extension WeekWeatherExtension on Weather{
  List<String> get weekDays
  => this.getTrueDates(this.weekDayIndexes).map((trueDate) => DateFormatter.weekDay(trueDate)).toList();

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
    return this.allDays().where((day) =>
    DateTime.now().isBefore(this.getTrueDate(day.weathers[0].timepoint))).toList();
  }

  DayWeather get today => this.allAvailableDays().first;
}

class DayWeather{
  final DateTime initDate;
  final List<WeatherData> weathers;
  const DayWeather({required this.weathers, required this.initDate});

  String weekDay(){
    return DateFormatter.weekDay(initDate.add(Duration(hours: weathers.first.timepoint)));
  }

  WeatherData get weatherNow{
    DateTime now = DateTime.now().toLocal();
    WeatherData weatherNow = weathers.firstWhere((weatherData) =>
      now.difference(initDate.add(Duration(hours: weatherData.timepoint)).toLocal()).inMinutes <= 90);
    print(now);
    DateTime chosenDate = initDate.add(Duration(hours: weatherNow.timepoint));
    print(chosenDate);
    print(now.difference(chosenDate).inHours);
    return weatherNow;
  }

  int get upperLimitTemp
    => weathers.map((hourData) => hourData.temp2m).toList().reduce(max);

  int get lowerLimitTemp
    => weathers.map((hourData) => hourData.temp2m).toList().reduce(min);

  @override
  String toString() {
    super.toString();
    return "${weathers.first.timepoint}";
  }
}