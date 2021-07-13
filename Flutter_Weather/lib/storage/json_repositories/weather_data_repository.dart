import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/resources/assets.dart';
import 'package:flutter_weather/services/date_formatter.dart';
import 'package:intl/intl.dart';

class WeatherDataRepository{

  static Future<Weather> getData() async {
    final response = await rootBundle.loadString(Assets.mockJsonData);
    final data = await jsonDecode(response);
    Weather mockWeather = Weather.fromJson(data);
    return mockWeather;
  }
}

extension ProcessMockJsonData on Weather{
  //int getInitTime() => int.parse(init.substring(init.length - 2, init.length));

  get initDate => yearMonthDayHour(init);//DateFormatter.yearMonthDay(init.substring(0, init.length -2));

  DateTime getTrueDate(int timePoint) => this.initDate.add(Duration(hours: timePoint));

  List<DateTime> getTrueDates(List<WeatherData> dataList)
   => dataList.map((data) => this.getTrueDate(data.timepoint)).toList();

  List<String> getWeekDays()
    => this.getTrueDates(this.getWeekData()).map((trueDate) => DateFormatter.weekDay(trueDate)).toList();

  List<int> getWeekDayIndex(){
    List<int> indexes = [0];
    int prev = 0;
    for (int i = 1; i < dataseries.length; i++){
      if (getTrueDate(dataseries[i].timepoint).day > getTrueDate(dataseries[prev].timepoint).day){
        prev = i;
        indexes.add(i);
      }
    }
    return indexes;
  }

  List<WeatherData> getWeekData(){
    final indexList = this.getWeekDayIndex();
    List<WeatherData> weekData = [];
    ///seven days of week
    for (int i = 0; i < 8; i++)
      weekData.add(dataseries[indexList[i]]);
    return weekData;
  }

  List<WeatherData> getDayData(){
    List<WeatherData> dayData= [];
    int day = this.initDate.day;
    for (int i = 0; i<dataseries.length; i++){
      if (this.getTrueDate(dataseries[i].timepoint).day != day)
        break;
      dayData.add(dataseries[i]);
    }
    return dayData;
  }

  DateTime yearMonthDayHour(String initDate){
    final year = initDate.substring(0, 4);
    final month = initDate.substring(4, 6);
    final day = initDate.substring(6, 8);
    final hour = initDate.substring(8, initDate.length);
    return DateFormat('yyyy MM dd hh').parse("$year $month $day $hour", true);
  }

}
