import 'dart:math';

import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/resources/assets.dart';
import 'package:flutter_weather/services/date_formatter.dart';
import 'package:intl/intl.dart';

extension TimeHandlerExtension on Weather{
  get initDate => yearMonthDayHour(init);

  DateTime getTrueDate(int timePoint) => this.initDate.add(Duration(hours: timePoint));

  List<DateTime> getTrueDates(List<int> weekDayIndex)
  => weekDayIndex.map((index) => this.getTrueDate(dataseries[index].timepoint)).toList();

  DateTime yearMonthDayHour(String initDate){
    final year = initDate.substring(0, 4);
    final month = initDate.substring(4, 6);
    final day = initDate.substring(6, 8);
    final hour = initDate.substring(8, initDate.length);
    return DateFormat('yyyy MM dd hh').parse("$year $month $day $hour", true);
  }
}

extension DayWeatherExtension on Weather{
  DayWeather get dayData{
    List<WeatherData> dayData= [];
    int day = this.initDate.day;
    for (int i = 0; i<dataseries.length; i++){
      if (this.getTrueDate(dataseries[i].timepoint).day != day)
        break;
      dayData.add(dataseries[i]);
    }
    return DayWeather(day: dayData);
  }


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