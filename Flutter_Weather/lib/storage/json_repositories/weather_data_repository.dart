import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_weather/models/index.dart';
import 'package:flutter_weather/resources/assets.dart';
import 'package:flutter_weather/services/date_formatter.dart';

class WeatherDataRepository{

  static Future<Mockjsondata> getData() async {
    final response = await rootBundle.loadString(Assets.mockJsonData);
    final data = await jsonDecode(response);
    Mockjsondata mockdata = Mockjsondata.fromJson(data);
    return mockdata;
  }
}

extension ProcessMockJsonData on Mockjsondata{
  //int getInitTime() => int.parse(init.substring(init.length - 2, init.length));

  DateTime getInitDate() => DateFormatter.yearMonthDayHour(init);//DateFormatter.yearMonthDay(init.substring(0, init.length -2));

  DateTime getTrueDate(int timePoint) => this.getInitDate().add(Duration(hours: timePoint));

  List<DateTime> getTrueDates(List<WeatherData> dataList)
   => dataList.map((data) => this.getTrueDate(data.timepoint)).toList();

  List<String> getWeekDays(List<WeatherData> dataList)
    => this.getTrueDates(dataList).map((trueDate) => DateFormatter.weekDay(trueDate)).toList();

  List<int> getDateIndex(){
    List<int> indexes = [];
    for (int i = 0; i < dataseries.length; i++){
      if (i%8==0) indexes.add(i);
    }
    return indexes;
  }

  List<WeatherData> getWeekData(){
    final indexList = this.getDateIndex();
    List<WeatherData> weekData = [];
    for (int i = 0; i < 8; i++)
      weekData.add(dataseries[indexList[i]]);
    return weekData;
  }

  List<WeatherData> getDayData(){
    List<WeatherData> dayData= [];
    int day = this.getInitDate().day;
    for (int i = 0; i<dataseries.length; i++){
      if (this.getTrueDate(dataseries[i].timepoint).day != day)
        break;
      dayData.add(dataseries[i]);
    }
    return dayData;
  }

}

extension ProcessWeatherDate on WeatherData{

}
